Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262871AbSKYKuq>; Mon, 25 Nov 2002 05:50:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262875AbSKYKuq>; Mon, 25 Nov 2002 05:50:46 -0500
Received: from 81-5-136-19.dsl.eclipse.net.uk ([81.5.136.19]:38917 "EHLO
	vlad.carfax.org.uk") by vger.kernel.org with ESMTP
	id <S262871AbSKYKuo>; Mon, 25 Nov 2002 05:50:44 -0500
Date: Mon, 25 Nov 2002 10:57:39 +0000
From: Hugo Mills <hugo-lkml@carfax.org.uk>
To: Clemmitt Sigler <siglercm@jrt.me.vt.edu>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>, Ted Tso <tytso@think.thunk.org>,
       Alan Cox <Alan.Cox@linux.org>
Subject: Re: 2.4.20-rc3 ext3 fsck corruption -- tool update warning needed?
Message-ID: <20021125105739.GA7531@carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo-lkml@carfax.org.uk>,
	Clemmitt Sigler <siglercm@jrt.me.vt.edu>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	lkml <linux-kernel@vger.kernel.org>,
	Ted Tso <tytso@think.thunk.org>, Alan Cox <Alan.Cox@linux.org>
References: <Pine.LNX.4.33L2.0211242351001.2368-100000@jrt.me.vt.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L2.0211242351001.2368-100000@jrt.me.vt.edu>
User-Agent: Mutt/1.4i
x-gpg-fingerprint: B997 A9F1 782D D1FD 9F87  5542 B2C2 7BC2 1C33 5860
x-gpg-key: 1C335860
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 25, 2002 at 12:12:55AM -0500, Clemmitt Sigler wrote:
> I'd been running 2.4.20-rc3 for two days.  While rebooting it tonight
> fsck.ext3 corrupted my / partition during an automatic fsck of the
> partition (caused by the maximal mount count being reached).  (I had
> backups so I was able to recover :^)  The symptoms were that some files
> like /etc/fstab and dirs like /etc/rc2.d disappeared -- not good.

   Did you also get some duplicated entries in /etc? I've had a
similar problem, with some files in /etc vanishing entirely, and
others being duplicated (so I got, for example, /etc/fstab appearing
twice in `ls /etc`). This has happened, as far as I can tell,
spontaneously -- no reboot, no run of fsck, not even any non-daemon
processes running other than X and an xterm. The machine wasn't being
used at all. Nothing turns up in the syslogs -- no oops, no bug,
nothing.

   Running fsck recovers the missing files into lost+found, but
doesn't remove the duplicated filenames. Duplicate files can be
deleted, but only one "filename" is removed, and the file then no
longer exists except to ls -- it shows up in `ls /etc`, but (e.g.)
`cat /etc/fstab` gives a "No such file or directory" error.

> My system is Debian Testing, with Debian e2fsprogs version
> 1.29+1.30-WIP-0930-1.  I use ext3 partitions with all options set to
> the defaults (ordered data mode).  This is an SMP system, in case
> that matters.  

   I'm also using Debian testing with the same e2fsprogs. I saw the
effect on ext2, on a UP box.

> Please e-mail me for any other details that might help.
> 
> I'm wondering if this change between -rc1 and -rc2 might be a factor ->
> 
>    <tytso@think.thunk.org>
>            HTREE backwards compatibility patch.

   I remember seeing a comment about HTREE running past when I tried
the e2fsck for the first time. Don't know if this is relevant.

   I've seen this happen twice now -- both times requiring a day or so
of effort to recover the system configuration (it wasn't up for long
enough between times to do a system backup :( ). I can't afford any
more downtime on this machine for the next month or so, so I'm no
longer running ext2 on my root partition -- I moved to reiserfs in the
hope that it'll be more stable.

   Hugo.

-- 
=== Hugo Mills: hugo@... carfax.org.uk | darksatanic.net | lug.org.uk ===
 PGP: 1024D/1C335860 from wwwkeys.eu.pgp.net or www.carfax.nildram.co.uk
  --- On Mondays, Wednesdays and Fridays they called it a particle. ---  
         On Tuesdays,  Thursdays and Saturdays, they called it a         
                   wave. On Sundays, they just prayed.                   

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE94gIjssJ7whwzWGARAtZCAJ9BvcB7apwzHTDQBezdoVuVZ/NTfQCfSlEP
K7YdArdbZmTJsmyuhA6IFYA=
=aai7
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--
