Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262104AbVBUUyO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262104AbVBUUyO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 15:54:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262106AbVBUUyO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 15:54:14 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:27655 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S262104AbVBUUyI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 15:54:08 -0500
Message-Id: <200502212054.j1LKs3xi032658@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Anthony DiSante <theant@nodivisions.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: uninterruptible sleep lockups 
In-Reply-To: Your message of "Mon, 21 Feb 2005 15:24:21 EST."
             <421A4375.9040108@nodivisions.com> 
From: Valdis.Kletnieks@vt.edu
References: <421A3414.2020508@nodivisions.com> <200502211945.j1LJjgbZ029643@turing-police.cc.vt.edu>
            <421A4375.9040108@nodivisions.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1109019242_9072P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 21 Feb 2005 15:54:03 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1109019242_9072P
Content-Type: text/plain; charset=us-ascii

On Mon, 21 Feb 2005 15:24:21 EST, Anthony DiSante said:
> Or maybe it SHOULD have killed your process, in some "proper" way that 
> prevents any outstanding I/O requests from coming in days later and breaking 
> things.  Again, I'm no kernel hacker, but if an I/O request takes *3 days*, 
> isn't that an indication of a bug or of faulty hardware perhaps?

Right.  And if you're an automated program trying to clean up after a *bug*,
what do you do?  It's quite likely that somebody's borked a lock - in which
case it may even be that the "hung" process is the victim rather than the
culprit, and breaking the lock will just make things worse.  Similar issues
apply to *all* of the resources the wedged process has attached to it.

When these things get posted on lkml, it almost always involves quite a bit
of code introspection and scratching of heads before we figure out how the
system *got* its figurative head wedged into that crevice.  Until you
figure out how it *got* there, a safe cleanup is in general impossible.  And
we haven't seen yet the automatic program that can introspect the code to that
detail - even the Stanford automated checker and sparse and the like are quite the
impressive pieces of work.

> > It's been covered before, look in the lkml archives for details.
> 
> Thanks, I'll do that.  But could you give me a more specific pointer? 

See the thread rooted here:
 
Date: Wed, 03 Nov 2004 07:51:39 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: is killing zombies possible w/o a reboot?
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Reply-to: gene.heskett@verizon.net
Message-id: <200411030751.39578.gene.heskett@verizon.net>


--==_Exmh_1109019242_9072P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCGkpqcC3lWbTT17ARAgk6AKCPlrpiVDIZk9O6Li8BsisKgpksbQCg4WoZ
04JNadXDPAaTpnOqTOSZQuM=
=N5Od
-----END PGP SIGNATURE-----

--==_Exmh_1109019242_9072P--
