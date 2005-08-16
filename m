Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932605AbVHPGpj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932605AbVHPGpj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 02:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932607AbVHPGpj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 02:45:39 -0400
Received: from h80ad2575.async.vt.edu ([128.173.37.117]:48354 "EHLO
	h80ad2575.async.vt.edu") by vger.kernel.org with ESMTP
	id S932605AbVHPGpi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 02:45:38 -0400
Message-Id: <200508160645.j7G6jLkx020286@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Michael E Brown <Michael_E_Brown@dell.com>
Cc: Kyle Moffett <mrmacman_g4@mac.com>,
       Doug Warzecha <Douglas_Warzecha@dell.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 2.6.13-rc6] add Dell Systems Management Base Driver (dcdbas) with sysfs support 
In-Reply-To: Your message of "Tue, 16 Aug 2005 01:10:23 CDT."
             <1124172623.10755.230.camel@soltek.michaels-house.net> 
From: Valdis.Kletnieks@vt.edu
References: <1124168323.10755.179.camel@soltek.michaels-house.net> <200508160536.j7G5aKox017930@turing-police.cc.vt.edu>
            <1124172623.10755.230.camel@soltek.michaels-house.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1124174720_3269P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 16 Aug 2005 02:45:20 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1124174720_3269P
Content-Type: text/plain; charset=us-ascii

On Tue, 16 Aug 2005 01:10:23 CDT, Michael E Brown said:

> Ok, very nice. Finally some actual code review, thanks. :-)

I have to admit I'm not qualified to do a detailed review, but I try.. ;)

> These are all just standard CMOS port numbers that pretty much every
> chipset uses to access CMOS.

The Kconfig has 'depends on X86 || X86_64' - do we know for a fact that *all*
of these boxes have CMOS at that address, including some of the odder subarchs?

> If you have not got a PE1300, the worst that happens is you have some
> random bits scribbled into your CMOS. Nothing that that "cmos clear"
> jumper won't fix. :-)

That's assuming that you can figure out what happened to the box. ;)

> Seriously, this file is meant to be activated by a userspace program
> that looks up the system ID in the appropriate table and writes the
> correct value into the driver. I'm not sure there is much more to be
> said than "don't do that." The official Dell management stack will
> always ensure that this is set correctly. If you don't use the official
> Dell stack, libsmbios is available, and we would be happy to make the
> appropriate tables available there. If you don't use either of these and
> go fiddling with this, I'm not sure there is much more to be done.

Somehow, the concept that the kernel is trusting userspace to do the
verification before we trash the CMOS doesn't give the security geek in me
any warm-n-fuzzies, especially when we're not even checking that it's the
right vendor's gear...

> > Can we have a check that the machine is (a) a Dell and (b) has a PIIX and (c) the
> > PIIX has a functional SMI behind it, before we start doing outb() calls?
>
> I'll have to defer to Doug on this. It may be possible to arrange this.

That would be nice.  I have a lot less issues with letting userspace scribble
a PE1300-specific value into a PE1300 than I do with letting it scribble that
same value into whatever happens to be at the address a PE1300 would be if it
was actually there.. ;)

--==_Exmh_1124174720_3269P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD4DBQFDAYuAcC3lWbTT17ARApW+AJ9Nzkp1ncvxYcCYSxQE0jBPhiYH8ACWLfLr
VIf05WSDEhJtJrSURJOBsA==
=w6jF
-----END PGP SIGNATURE-----

--==_Exmh_1124174720_3269P--
