Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266153AbTGIVZW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 17:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266159AbTGIVZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 17:25:21 -0400
Received: from hnexfe09.hetnet.nl ([195.121.6.175]:14738 "EHLO
	hnexfe09.hetnet.nl") by vger.kernel.org with ESMTP id S266153AbTGIVZE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 17:25:04 -0400
From: Bas Mevissen <bas@basmevissen.nl>
To: alan@lxorguk.ukuu.org.uk
Subject: Build problem introduced in 2.4.22-pre3 -> 2.4.22-pre3-ac1 (+config+analysis)
Date: Wed, 9 Jul 2003 23:36:59 +0200
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <200307092329.06003.bas@basmevissen.nl>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_7rID/KgH4h+h8oZ"
X-OriginalArrivalTime: 09 Jul 2003 21:39:39.0313 (UTC) FILETIME=[9988E210:01C34662]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_7rID/KgH4h+h8oZ
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline



Hi Alan, all,

The attached .config fails to build on 2.4.22-pre3-ac1, but builds (and 
runs) fine on 2.4.22-pre3. The build error (during linkage) is:

(make bzImage)

ld -m elf_i386 -T /usr/src/linux-2.4.22-pre3-ac1/arch/i386/vmlinux.lds -e 
stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o 
init/version.o init/do_mounts.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o 
fs/fs.o ipc/ipc.o \
         drivers/acpi/acpi.o drivers/cpufreq/cpufreq.o drivers/char/char.o 
drivers/block/block.o drivers/misc/misc.o drivers/net/net.o 
drivers/char/drm/drm.o
drivers/ide/idedriver.o drivers/cdrom/driver.o drivers/pci/driver.o 
drivers/net/pcmcia/pcmcia_net.o drivers/net/wireless/wireless_net.o 
drivers/pnp/pnp.o drivers/video/video.o drivers/media/media.o \
        net/network.o \
        /usr/src/linux-2.4.22-pre3-ac1/arch/i386/lib/lib.a 
/usr/src/linux-2.4.22-pre3-ac1/lib/lib.a 
/usr/src/linux-2.4.22-pre3-ac1/arch/i386/lib/lib.a \
        --end-group \
        -o vmlinux
arch/i386/kernel/kernel.o(.text.init+0x7dae): In function 
`setup_ioapic_ids_from_mpc':
: undefined reference to `xapic_support'
arch/i386/kernel/kernel.o(.text.init+0x7fe5): In function 
`setup_ioapic_ids_from_mpc':
: undefined reference to `xapic_support'
make: *** [vmlinux] Error 1

The symbol xapic_support is defined in arch/i386/kernel/io_apic.c as
"extern unsigned int xapic_support;"
But it is declared nowhere. Note that the symbol is new in -ac1. 

>From comparing the pre3 and pre3-ac1 versions of io_apic.c, I conclude that 
this is some unfinished work and not a typo. What probably is missing is some 
change to another file that should decare (and set) xapic_support.

Sorry for not being able to submit a patch, but I hope my analyses helps.

Regards,

Bas.
(Dell Inspiron 8500 with 2.4.22-pre3)

(Note: I'm not on the list, so please always CC me)







--Boundary-00=_7rID/KgH4h+h8oZ
Content-Type: application/x-gzip;
  name="dotconfig.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="dotconfig.gz"

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
0iux9z8MozjdAmQAAA==

--Boundary-00=_7rID/KgH4h+h8oZ--


