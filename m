Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265207AbUFAUMk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265207AbUFAUMk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 16:12:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265206AbUFAUMj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 16:12:39 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:3216 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S265207AbUFAULD (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 16:11:03 -0400
Message-Id: <200406012010.i51KAuWP024552@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: reg@dwf.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Intel 875 Motherboard cant use 4GB of Memory. 
In-Reply-To: Your message of "Tue, 01 Jun 2004 13:56:34 MDT."
             <200406011956.i51JuYkD019999@orion.dwf.com> 
From: Valdis.Kletnieks@vt.edu
References: <200406011956.i51JuYkD019999@orion.dwf.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_648145696P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 01 Jun 2004 16:10:56 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_648145696P
Content-Type: text/plain; charset=us-ascii

On Tue, 01 Jun 2004 13:56:34 MDT, reg@dwf.com said:

>   00000000-0009fbff : System RAM
>   0009fc00-0009ffff : reserved
>   000a0000-000bffff : Video RAM area
>   000c0000-000ccfff : Video ROM
>   000f0000-000fffff : System ROM
>   00100000-ae62ffff : System RAM                    1048576 - 2925723647
>   00100000-002a2fff : Kernel code
>   002a3000-003542ff : Kernel data
>   ae630000-ae64180f : ACPI Non-volatile Storage

and thence a long list of other reserved stuff pretty much clear up to
ffffffff.  So there may be 4G of physical memory in the box, but everything
above ae630000 or so is shadowed by something else using those memory
addresses.. and that's just about 1/3 of the address space...

> This still isnt making much sense to me, so if somone can explain why I
> can only see a little over 2/3 of the installed memory, I would appreciate
> it.

If you *were* to allocate a page at (for instance) ff8f0000, and then wrote to
it, who should get the write - the memory page or the device 0000:01:00.0 on
PCI Bus 1?

> And of course, the original question, any workarround?
There's 3 basic directions you can go:  (1) find a way to disambiguate the
memory addresses so shadowing isn't a problem (probably not an option), (2a)
find a way to relocate the reserved stuff above the 4G address line (probably
need BIOS assistance for this), or (2b) find a way to relocate a gig and a half
or so of memory above the 4G linem or (3) Move to an architecture that isn't
constrained by 32-bit addresses...


--==_Exmh_648145696P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAvOLQcC3lWbTT17ARAkfuAKC38CSdr3ZihUAA3tR3Xx1TwdXSrQCgz8+2
XglMFREOgs0m+nh+iIeRmaA=
=PyhG
-----END PGP SIGNATURE-----

--==_Exmh_648145696P--
