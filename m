Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932324AbWE3QuI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932324AbWE3QuI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 12:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932321AbWE3QuI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 12:50:08 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:22251 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S932324AbWE3QuH (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 12:50:07 -0400
Message-Id: <200605301649.k4UGnooZ004266@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Voluspa <lista1@comhem.se>
Cc: wfg@mail.ustc.edu.cn, linux-kernel@vger.kernel.org
Subject: Re: Adaptive Readahead V14 - statistics question...
In-Reply-To: Your message of "Tue, 30 May 2006 05:36:31 +0200."
             <20060530053631.57899084.lista1@comhem.se>
From: Valdis.Kletnieks@vt.edu
References: <20060530053631.57899084.lista1@comhem.se>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1149007790_3454P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 30 May 2006 12:49:50 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1149007790_3454P
Content-Type: text/plain; charset=us-ascii

On Tue, 30 May 2006 05:36:31 +0200, Voluspa said:
> On 2006-05-30 0:37:57 Wu Fengguang wrote:
> > On Mon, May 29, 2006 at 03:44:59PM -0400, Valdis Kletnieks wrote:
> [...]
> >> doing anything useful? (One thing I've noticed is that xmms, rather
> >> than gobble up 100K of data off disk every 10 seconds or so, snarfs
> >> a big 2M chunk every 3-4 minutes, often sucking in an entire song at
> >> (nearly) one shot...)
> >
> > Hehe, it's resulted from the enlarged default max readahead size(128K
> > => 1M). Too much aggressive? I'm interesting to know the recommended
> > size for desktops, thanks. For now you can adjust it through the
> > 'blockdev --setra /dev/hda' command.

Actually, it doesn't seem too aggressive at all - I have 768M of memory,
and the larger max readahead means that it hits the disk 1/8th as often
for a bigger slurp.  Since I'm on a laptop with a slow 5400rpm 60g disk,
a 128K seek-and-read "costs" almost exactly the same as a 1M seek-and-read...

(If I was more memory constrained, I'd probably be hitting that --setra though ;)

The only hard numbers I have so far are a build of a 17-rc4-mm3 kernel tree
under -mm3+readahead and a slightly older -mm2 - the readahead kernel got
through the build about 30 seconds faster (19 mins 45 secs versus 20:17 -but
that's only 1 trial each).

Oh.. another "hard number" - elapsed time for a 4AM 'tripwire' run from cron
with a -mm3+readahead kernel was 36 minutes. A few days earlier, a -mm3
kernel took 46 minutes for the same thing.  I'll have to go and retry this
with equivalent cache-cold scenarios - I *think* the file cache was roughly
equivalent, but can't prove it...

The desktop "feel" is certainly at least as good, but it's a lot harder
to quantify that - yesterday I was doing some heavy-duty cleaning in my
~/Mail directory (MH-style one message per file, about 250K files and 3G,
obviously seriously in need of cleaning).  I'd often have 2 different
'find | xargs grep' type commands running at a time, and that seemed to
work a lot better than it used to (but again, no numbers)..

Damn, this is a lot harder to benchmark than the sort of microbenchmarks
we usually see around here. :)

> And notebooks? I'm running a 64bit system with 2gig memory and a 7200
> RPM disk. Without your patches a movie like Elephants_Dream_HD.avi
> causes a continuous silent read. After patching 2.6.17-rc5 (more on that
> later) there's a slow 'click-read-click-read-click-etc' during the
> same movie as the head travels _somewhere_ to rest(?) between reads.

For my usage patterns, this is a feature, not a bug. As mentioned before,
on this machine anything that reduces the number of seeks is a Good Thing.

> Distracting in silent sequences, and perhaps increased disk wear/tear.

It would be increased wear/tear only if the disk was idle long enough to
spin down. Especially for video, the read-ahead needed to let the disk spin
down (assuming a sane timeout for that) would be enormous. :)

> I'll try adjusting the readahead size towards silence tomorrow.

The onboard sound chip is an ok-quality CS4205, the onboard speakers are crap.
However, running the audio through a nice pair of Kenwood headphones is a good
solution. I don't hear the disk (or sometimes even the phone), and my
co-workers don't have to hear my Malmsteen collection. :)



--==_Exmh_1149007790_3454P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEfHeucC3lWbTT17ARAtuoAJ4/FUKELt1RsL0eWryUKiTUAQVTEQCg3xUr
NP3s9Exg3jRcxp91HNGloxw=
=LrT5
-----END PGP SIGNATURE-----

--==_Exmh_1149007790_3454P--
