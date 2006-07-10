Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422660AbWGJPib@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422660AbWGJPib (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 11:38:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422654AbWGJPib
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 11:38:31 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:12756 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1422660AbWGJPia (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 11:38:30 -0400
Message-Id: <200607101538.k6AFc3OE007205@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jon Smirl <jonsmirl@gmail.com>,
       "Antonino A. Daplas" <adaplas@gmail.com>,
       "H. Peter Anvin" <hpa@zytor.com>, Greg KH <greg@kroah.com>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Clean up old names in tty code to current names
In-Reply-To: Your message of "Mon, 10 Jul 2006 16:21:47 BST."
             <20060710152146.GA18728@flint.arm.linux.org.uk>
From: Valdis.Kletnieks@vt.edu
References: <1152524657.27368.108.camel@localhost.localdomain> <9e4733910607100541i744dd744n16c35c50dae1e98d@mail.gmail.com> <1152537049.27368.119.camel@localhost.localdomain> <9e4733910607100603r5ae1a21ex1a2fa0f045424fd1@mail.gmail.com> <1152539034.27368.124.camel@localhost.localdomain> <9e4733910607100707g4810a86boa93a5b6b0b1a8d0a@mail.gmail.com> <44B26752.9000507@gmail.com> <9e4733910607100757t4ddfaf93l1723580de551529b@mail.gmail.com> <1152544746.27368.134.camel@localhost.localdomain> <200607101510.k6AFAWND006142@turing-police.cc.vt.edu>
            <20060710152146.GA18728@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1152545883_3170P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 10 Jul 2006 11:38:03 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1152545883_3170P
Content-Type: text/plain; charset=us-ascii

On Mon, 10 Jul 2006 16:21:47 BST, Russell King said:

> Maybe - what if userspace is looking up /dev/tty0 in /proc/tty/drivers
> and happens to know that it's called /dev/vc/0, because it's working
> around this known idiosyncrasy of the kernel ?

It only breaks if it's being totally brain-dead and doing this:

	if (!strcmp(inputdev,"/dev/tty0") inputdev = "/dev/vc/0";

and not bothering to check that /dev/tty0 could *possibly* actually
appear in the /proc/tty entry.  In fact, it would have to be actively
asserting that it can't appear.

Code that does this sort of thing:

	if (!strcmp(procentry,"/dev/vc/0") procentry = "/dev/tty0";
	if (!strcmp(procentry, inputdev)) { whatever to to do when found }

will still work.

> That "terminally broken stuff" might just happen to work with today's
> kernels.  Even so, that's no reason to pile in additional user-visible
> changes which could potentially have adverse effects.

Oddly enough, "This PoS code only happened to work" is considered a good
and sufficient reason to fix kernel code. :)

Also, please note that I *did* agree with Alan - this needs to be done right
in /sys first, and then tools updated.  However, having provided a *correct*
way to do it, we should not *then* use "old crap might break further" as
a reason to not finish the cleanup.


--==_Exmh_1152545883_3170P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEsnRbcC3lWbTT17ARAtSOAJ9ycrJmCrX9+ycJ4LjyBTgg46qKrgCg3G9c
fw61C/g9jvnill+dBKTduEc=
=3Wf/
-----END PGP SIGNATURE-----

--==_Exmh_1152545883_3170P--
