Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312380AbSDPLVG>; Tue, 16 Apr 2002 07:21:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312386AbSDPLVF>; Tue, 16 Apr 2002 07:21:05 -0400
Received: from loki.Informatik.Uni-Oldenburg.DE ([134.106.9.61]:35593 "EHLO
	walker.pmhahn.de") by vger.kernel.org with ESMTP id <S312380AbSDPLVF>;
	Tue, 16 Apr 2002 07:21:05 -0400
Date: Tue, 16 Apr 2002 13:20:37 +0200
From: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: hch@infradead.org
Subject: [BUG] skip_ioapic_setup
Message-ID: <20020416112037.GA9185@titan.lahn.de>
In-Reply-To: <Pine.LNX.4.21.0204160049130.18896-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organization: UUCP-Freunde Lahn e.V.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2002 at 12:50:13AM -0300, Marcelo Tosatti wrote:

> <hch@infradead.org> (02/04/15 1.407)
> 	[PATCH] disable APIC when broken mptable is found
[...]
> <hch@infradead.org> (02/04/15 1.410)
> 	[PATCH] allow forcing APIC mode

Linking fails:
ld -m elf_i386 -T /usr/src/linux-2.4.19/arch/i386/vmlinux.lds -e stext
arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o
init/version.o init/do_mounts.o --start-group arch/i386/kernel/kernel.o
arch/i386/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o kdb/kdb.o
drivers/acpi/acpi.o drivers/char/char.o drivers/block/block.o
drivers/misc/misc.o drivers/net/net.o drivers/media/media.o
drivers/ide/idedriver.o drivers/cdrom/driver.o drivers/pci/driver.o
drivers/net/pcmcia/pcmcia_net.o drivers/net/wireless/wireless_net.o
drivers/video/video.o drivers/isdn/vmlinux-obj.o net/network.o
/usr/src/linux-2.4.19/arch/i386/lib/lib.a
/usr/src/linux-2.4.19/lib/lib.a
/usr/src/linux-2.4.19/arch/i386/lib/lib.a
/usr/src/linux-2.4.19/arch/i386/kdb/kdba.o --end-group -o .tmp_vmlinux1
init/main.o: In function `smp_init':
init/main.o(.text.init+0x686): undefined reference to `skip_ioapic_setup'
arch/i386/kernel/kernel.o: In function `broken_pirq':
arch/i386/kernel/kernel.o(.text.init+0x302a): undefined reference to `skip_ioapic_setup'


skip_ioapic_setup is defined in arch/i386/io_apic.c, which is
conditionally compiled only, if CONFIG_X86_IO_APIC is defined. which is
only defined for SMP or when CONFIG_X86_UP_IOAPIC is set.

init/main.c:332 and arch/i386/kernel/dmi_scan.c:357 do both use it and
don't depend on CONFIG_X86_IO_APIC themselves.

BYtE
Philipp
-- 
  / /  (_)__  __ ____  __ Philipp Hahn
 / /__/ / _ \/ // /\ \/ /
/____/_/_//_/\_,_/ /_/\_\ pmhahn@titan.lahn.de
