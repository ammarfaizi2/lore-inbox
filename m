Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268230AbUHTPoK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268230AbUHTPoK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 11:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267507AbUHTPoK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 11:44:10 -0400
Received: from mx-out.forthnet.gr ([193.92.150.5]:35543 "EHLO
	mx-out-04.forthnet.gr") by vger.kernel.org with ESMTP
	id S267343AbUHTPnr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 11:43:47 -0400
From: V13 <v13@priest.com>
To: gene.heskett@verizon.net
Subject: Re: Possible dcache BUG
Date: Fri, 20 Aug 2004 18:43:21 +0300
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>, mingo@elte.hu,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org> <20040820073334.GB8205@logos.cnet> <200408201106.15117.gene.heskett@verizon.net>
In-Reply-To: <200408201106.15117.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3121215.pvB83fCDX5";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200408201843.23222.v13@priest.com>
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3121215.pvB83fCDX5
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 20 August 2004 18:06, Gene Heskett wrote:
> On Friday 20 August 2004 03:33, Marcelo Tosatti wrote:
> [...]
>
> >> >I can't see how that could be caused by flaky hardware.
> >>
> >> There is still that possibility Marcelo.  Someone recommended I
> >> get cpuburn and memburn, and before fixing the scanf statement (it
> >> was broken) in memburn, I had compiled it for a 512 meg test the
> >> first time, and a 768 meg test the next couple of runs.
> >>
> >> All exited with errors like this:
> >> Passed round 133, elapsed 4827.19.
> >> FAILED at round 134/14208927: got ff00, expected 0!!!
> >>
> >> REREAD: ff00, ff00, ff00!!!
> >>
> >> [root@coyote memburn]# vim memburn.c
> >> [root@coyote memburn]# gcc -o memburn memburn.c
> >> [root@coyote memburn]# ./memburn
> >> Starting test with size 768 megs..
> >>
> >> Passed round 0, elapsed 44.36.
> >> Passed round 1, elapsed 74.13.
> >> Passed round 2, elapsed 105.12.
> >> FAILED at round 3/25777183: got 2b00, expected 0!!!
> >>
> >> REREAD: 2b00, 2b00, 2b00!!!
>
> The latest output of memburn after a bit of format hacking:
>
> FAILED at round 78/165714207: got 0000ff00, expected 00000000!!!
> REREAD: 0000ff00, 0000ff00, 0000ff00!!!
>
> and
>
> FAILED at round 160/200780831: got 02025302, expected 02020202!!!
> REREAD: 02025302, 02025302, 02025302!!!
>
> So it appears that its the third byte of 4 each time thats fubar'd.
> I'l run it a few more times to confirm.  Is memory byte wide per chip
> on these things today?

I had a simillar problem some years ago. I had core dumps and gcc errors al=
l=20
the time but memtest could not find a thing. 99% it was a CPU problem and n=
ot=20
a memory problem. It seemed that there were errors at random times even whe=
n=20
there was no cpu load.

I believe it was a cache problem. I made a simple prog (like memburn) that=
=20
allocated memory blocks and then did some read/write on them (alloc+write 5=
=20
blocks, check 1, free 1, alloc+write 6, check 2, free 2 alloc+write 7....).=
=20
After that whenever the program encountered an error it looped on this bloc=
k=20
forever.=20

The errors occured after a random period of time (from 1 block allocation t=
o=20
more than an hour) and were never reproduced after a stop/start. When this=
=20
test program was running and looping on the bad block, gcc never displayed=
=20
errors. The problem was fixed when I replaced the CPU and I'm still using t=
he=20
same DIMMs without problems. I also did a lot of checks before replacing th=
e=20
CPU, like changing the position of the DIMMs, removing one of them, change=
=20
their timing, and much more without success. Even removed all the PCI cards.

Disabling the CPU cache or replacing it can be a good test.

<<V13>>

--nextPart3121215.pvB83fCDX5
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBJhwbVEjwdyuhmSoRAnaxAJ41OVtIc+wTksgTj+sA4LF5NuHJewCgrW7Q
LgQhoYhtbbIhN9FEO6OVPw8=
=Kj7f
-----END PGP SIGNATURE-----

--nextPart3121215.pvB83fCDX5--
