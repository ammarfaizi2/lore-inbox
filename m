Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129889AbQKAVoa>; Wed, 1 Nov 2000 16:44:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130414AbQKAVoK>; Wed, 1 Nov 2000 16:44:10 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:54979 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S129889AbQKAVoI>;
	Wed, 1 Nov 2000 16:44:08 -0500
Date: Wed, 1 Nov 2000 22:44:05 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200011012144.WAA04414@harpo.it.uu.se>
To: linux-kernel@vger.kernel.org
Subject: binutils/gas problem with 'lcall'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

arch/i386/kernel/apm.c and pci-pc.c use the lcall instruction
(call far indirect) for invoking BIOS services.
The following syntax is used:

(apm)		lcall %cs:apm_bios_entry
(pci-pc)	lcall (%edi)

This works ok with binutils 2.9.5, but binutils 2.10.0.18
(gas 2.10.90) as shipped with RedHat 7.0 complains:

	Warning: indirect lcall without `*'

To keep gas 2.10.90 happy one can insert the * prefix:

(apm)		lcall *%cs:apm_bios_entry
(pci-pc)	lcall *(%edi)

but older binutils like 2.9.5 treat these as syntax errors. Sigh.

So how do we want to handle this?
- ignore the warnings? (yuck; I hate compiler/assembler warnings)
- specify 2.10.0.18 as the minimum binutils for 2.4 kernels?
  if we're going to do it, we should do it NOW, before the real
  2.4.0 is released

/Mikael
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
