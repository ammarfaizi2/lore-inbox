Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261767AbVCAI5B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261767AbVCAI5B (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 03:57:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261834AbVCAI5B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 03:57:01 -0500
Received: from h80ad2654.async.vt.edu ([128.173.38.84]:40459 "EHLO
	h80ad2654.async.vt.edu") by vger.kernel.org with ESMTP
	id S261767AbVCAI45 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 03:56:57 -0500
Message-Id: <200503010856.j218ushk004074@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc4-mm1 - pcmcia weirdness/breakage 
In-Reply-To: Your message of "Mon, 28 Feb 2005 14:48:20 EST."
             <200502281948.j1SJmKdV006528@turing-police.cc.vt.edu> 
From: Valdis.Kletnieks@vt.edu
References: <200502281948.j1SJmKdV006528@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1109667413_3728P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 01 Mar 2005 03:56:54 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1109667413_3728P
Content-Type: text/plain; charset=us-ascii

On Mon, 28 Feb 2005 14:48:20 EST, Valdis.Kletnieks@vt.edu said:

> Symptoms:  Running '/etc/init.d/pcmcia start' bombs - cardmgr goes into
> a loop spewing repeated 'Common memory region at 0x0: Generic or SRAM'
> messages.  In the dmesg, we find:

> [4294859.369000] cs: unable to map card memory!
> [4294859.369000] cs: unable to map card memory!

I backed the bk-pci.patch out, and it started working again, so the problem is
somewhere in there (progress - we've got it down to one 5,500 patch ;).
Perhaps related, the following compile warnings also went away:

   CC [M]  drivers/ieee1394/ohci1394.o
drivers/ieee1394/ohci1394.c: In function `ohci_initialize':
drivers/ieee1394/ohci1394.c:589: warning: long unsigned int format, different type arg (arg 7)
drivers/ieee1394/ohci1394.c:589: warning: long unsigned int format, different type arg (arg 8)
drivers/ieee1394/ohci1394.c: In function `ohci1394_pci_probe':
drivers/ieee1394/ohci1394.c:3266: warning: long unsigned int format, different type arg (arg 4)

   CC      drivers/pci/rom.o
drivers/pci/rom.c: In function `pci_map_rom':
drivers/pci/rom.c:74: warning: cast to pointer from integer of different size
drivers/pci/rom.c: In function `pci_map_rom_copy':
drivers/pci/rom.c:160: warning: cast to pointer from integer of different size
drivers/pci/rom.c:164: warning: cast to pointer from integer of different size
drivers/pci/rom.c: In function `pci_cleanup_rom':
drivers/pci/rom.c:217: warning: cast to pointer from integer of different size

   CC [M]  drivers/pcmcia/rsrc_nonstatic.o
drivers/pcmcia/rsrc_nonstatic.c: In function `nonstatic_find_io_region':
drivers/pcmcia/rsrc_nonstatic.c:629: warning: passing arg 7 of `pci_bus_alloc_resource' from incompatible pointer type
drivers/pcmcia/rsrc_nonstatic.c:633: warning: passing arg 7 of `allocate_resource' from incompatible pointer type
drivers/pcmcia/rsrc_nonstatic.c: In function `nonstatic_find_mem_region':
drivers/pcmcia/rsrc_nonstatic.c:672: warning: passing arg 7 of `pci_bus_alloc_resource' from incompatible pointer type
drivers/pcmcia/rsrc_nonstatic.c:676: warning: passing arg 7 of `allocate_resource' from incompatible pointer type

I'm suspicious of the warnings for rsrc_nonstatic.o, because we end up in that
exact piece of code just before failing with the 'unable to map card memory'
message. Maybe that arg 7 is causing us to pass a stack that doesn't quite
match what's expected, and thus the bug?



--==_Exmh_1109667413_3728P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCJC5VcC3lWbTT17ARAi76AJ962O1AV1bgD86qbpLUHzR3VZpuCACgwZBC
n0GL5ULtYkYal96dwGeDL4U=
=rMRA
-----END PGP SIGNATURE-----

--==_Exmh_1109667413_3728P--
