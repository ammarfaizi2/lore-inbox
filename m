Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265420AbTFMPvb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 11:51:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265421AbTFMPva
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 11:51:30 -0400
Received: from scrye.com ([216.17.180.1]:31400 "HELO scrye.com")
	by vger.kernel.org with SMTP id S265420AbTFMPv2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 11:51:28 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Kevin Fenzi <kevin@scrye.com>
To: Zsolt Babak <zod@sch.bme.hu>
Cc: inux-kernel@vger.kernel.org
Subject: Re: 2.4.21-rc8-laptop1 released
In-Reply-To: <20030613114324.GA24705@gandalf.sch.bme.hu>
References: <20030612223940.7fcc00a1.hanno@gmx.de>
	<20030612211707.2266BF7FE0@voldemort.scrye.com>
	<20030613114324.GA24705@gandalf.sch.bme.hu>
X-Mailer: VM 7.07 under 21.4 (patch 12) "Portable Code" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Message-Id: <S265421AbTFMPva/20030613155130Z+2583@vger.kernel.org>
Date: Fri, 13 Jun 2003 11:51:30 -0400

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

>>>>> "Zsolt" == Zsolt Babak <zod@sch.bme.hu> writes:

Zsolt> Hi!  This has nothing to do with the laptop patch, these
Zsolt> defines are really missing from include/linux/pci_ids.h.

ah... so I see. 

Zsolt> In -rc5 I just removed the line from the .c file that
Zsolt> referenced the missing ID, and it works very well...

Zsolt> Maybe this is a bug ;)

Yeah, looks like, or something that wasn't entirely merged. 
Commenting those out gets me further, but then it fails in: 

ld -m elf_i386 -r -o cpqphp.o cpqphp_core.o cpqphp_ctrl.o cpqphp_proc.o cpqphp_pci.o
gcc -D__KERNEL__ -I/usr/src/redhat/BUILD/kernel-2.4.21rc8laptop1/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=pentium4 -DMODULE -DMODVERSIONS -include /usr/src/redhat/BUILD/kernel-2.4.21rc8laptop1/include/linux/modversions.h  -nostdinc -iwithprefix include -DKBUILD_BASENAME=acpiphp_core  -c -o acpiphp_core.o acpiphp_core.c
gcc -D__KERNEL__ -I/usr/src/redhat/BUILD/kernel-2.4.21rc8laptop1/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=pentium4 -DMODULE -DMODVERSIONS -include /usr/src/redhat/BUILD/kernel-2.4.21rc8laptop1/include/linux/modversions.h  -nostdinc -iwithprefix include -DKBUILD_BASENAME=acpiphp_glue  -c -o acpiphp_glue.o acpiphp_glue.c
acpiphp_glue.c: In function `find_host_bridge':
acpiphp_glue.c:815: warning: passing arg 2 of `acpi_get_object_info_R4d2dc830' from incompatible pointer type
acpiphp_glue.c:821: subscripted value is neither array nor pointer
acpiphp_glue.c:826: incompatible type for argument 1 of `strcmp'
make[3]: *** [acpiphp_glue.o] Error 1
make[3]: Leaving directory `/usr/src/redhat/BUILD/kernel-2.4.21rc8laptop1/drivers/hotplug'
make[2]: *** [_modsubdir_hotplug] Error 2
make[2]: Leaving directory `/usr/src/redhat/BUILD/kernel-2.4.21rc8laptop1/drivers'
make[1]: *** [_mod_drivers] Error 2
make[1]: Leaving directory `/usr/src/redhat/BUILD/kernel-2.4.21rc8laptop1'
error: Bad exit status from /var/tmp/rpm-tmp.58636 (%build)

Something related to the i830 stuff someone else reported problems
with? 

Zsolt>     Zod.

kevin
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.8 <http://mailcrypt.sourceforge.net/>

iD8DBQE+6fX43imCezTjY0ERAnJlAJ9mcRMTcbkzn/ZehaGJFzh7wp4o3wCfaIJX
BwSw91MAR7gzaNaqyGlvSEA=
=uMbl
-----END PGP SIGNATURE-----

