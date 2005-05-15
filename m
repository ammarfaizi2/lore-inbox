Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261607AbVEOLOk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261607AbVEOLOk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 07:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261608AbVEOLOk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 07:14:40 -0400
Received: from h80ad250f.async.vt.edu ([128.173.37.15]:40205 "EHLO
	h80ad250f.async.vt.edu") by vger.kernel.org with ESMTP
	id S261607AbVEOLO3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 07:14:29 -0400
Message-Id: <200505151113.j4FBDf2a011875@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: Borislav Petkov <petkov@uni-muenster.de>, Edgar Toernig <froese@gmx.de>,
       jmerkey <jmerkey@utah-nac.org>,
       Scott Robert Ladd <lkml@coyotegulch.com>, linux-kernel@vger.kernel.org
Subject: Re: Automatic .config generation 
In-Reply-To: Your message of "Sun, 15 May 2005 11:52:51 +0200."
             <Pine.LNX.4.62.0505151148220.2387@dragon.hyggekrogen.localhost> 
From: Valdis.Kletnieks@vt.edu
References: <200505150742.j4F7gds1020180@turing-police.cc.vt.edu>
            <Pine.LNX.4.62.0505151148220.2387@dragon.hyggekrogen.localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1116155620_5152P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 15 May 2005 07:13:41 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1116155620_5152P
Content-Type: text/plain; charset=us-ascii

On Sun, 15 May 2005 11:52:51 +0200, Jesper Juhl said:
> What's the big gain? Where's the harm in just building all the sound
> modules - you only load one in the end anyway, and the space taken by the
> other modules is negligible with the disk sizes of today I'd say (ok,
> there's some extra build time involved, but that shouldn't be a big deal

If you're doing building and testing on an older/slower box, the build
time and disk size matters - there's 481 'y' or 'm' in my current .config, versus
1701 in the Fedora -1287 kernel.  Being able to do 3 build/reboot loops in
an hour versus one every 90 mins makes a big difference.  Being able to do a
build in 400M instead of 2G means that a 7G /usr/src/ partition can hold 8 or 9
trees, rather than 3 (useful for those "when did this start" regressions, especially
in combo with that 20 min versus 90 build time. ;)

> you want. Besides, it's not as if you have to redo your kernel config from
> scratch every time you want a new kernel. Make your favorite config once, 
> build and install that kernel and then when you want a newer kernel simply 
> either cd linux-<version>; zcat /proc/config.gz > .config ; make oldconfig 
> and then build the new kernel using your previous config.

Yes, that's easy if you're working on *the same hardware*, so new device drivers
aren't of interest, and the only thing 'make oldconfig' will prompt you for is
new non-driver functionality. However, that's not everybody...

The function is for building streamlined configs for new systems - you get
in a Frobozz2005 laptop, and although you probably have your own favorite set
of values for things like which netfilter modules to build, you probably have
*no* idea right off what device drivers you need. So you end up either going
the RedHat route and building it *all* anyhow, or spending a lot of time
figuring out which drivers you need for *this* box.  And you can't even trust
the vendor sometimes - the Dell laptop I'm typing on was part of a larger order.
A co-worker got another C840, and we had both ordered the same CD/RW-DVD drive.
Machines had consecutive Dell service/serial numbers - and different vendor
drives (mine had a Toshiba, his had something else).

I won't even *start* on the number of subtly different AC'97-ish sound chips
Dell has gone through.. ;)

If you have a better solution to the "minimize *total* time to build optimized
kernels for 12 different machines that just got dropped on your workbench
this morning" feel free to share.. ;)

--==_Exmh_1116155620_5152P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFChy7kcC3lWbTT17ARAgg6AKDubzrWwOr438w2SUFf5Coq5jpl5gCfb2JN
FV9FAFemlI93V4wQdAoxuPQ=
=nvpy
-----END PGP SIGNATURE-----

--==_Exmh_1116155620_5152P--
