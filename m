Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262207AbSJ0BOM>; Sat, 26 Oct 2002 21:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262212AbSJ0BOM>; Sat, 26 Oct 2002 21:14:12 -0400
Received: from paloma12.e0k.nbg-hannover.de ([62.181.130.12]:12186 "HELO
	paloma12.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S262207AbSJ0BOL> convert rfc822-to-8bit; Sat, 26 Oct 2002 21:14:11 -0400
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Linux 2.5.44-ac4
Date: Sun, 27 Oct 2002 03:20:25 +0200
User-Agent: KMail/1.4.7
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200210270220.25037.Dieter.Nuetzel@hamburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IDE as modules: Unresolved symbols

make -f arch/i386/lib/Makefile modules_install
if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.44-ac4; fi
depmod: *** Unresolved symbols in 
/lib/modules/2.5.44-ac4/kernel/drivers/ide/ide-disk.o
depmod:         proc_ide_read_geometry
depmod: *** Unresolved symbols in 
/lib/modules/2.5.44-ac4/kernel/drivers/ide/ide-probe.o
depmod:         do_ide_request
depmod:         ide_add_generic_settings
depmod:         ide_bus_type
depmod:         create_proc_ide_interfaces
depmod: *** Unresolved symbols in 
/lib/modules/2.5.44-ac4/kernel/drivers/ide/ide.o
depmod:         ide_release_dma
depmod:         ide_add_proc_entries
depmod:         ide_scan_pcibus
depmod:         proc_ide_read_capacity
depmod:         proc_ide_create
depmod:         ide_remove_proc_entries
depmod:         destroy_proc_ide_drives
depmod:         proc_ide_destroy
depmod:         create_proc_ide_interfaces
depmod: *** Unresolved symbols in 
/lib/modules/2.5.44-ac4/kernel/drivers/ide/pci/amd74xx.o
depmod:         ide_setup_dma_Rsmp_35fed897
depmod:         ide_pci_unregister_driver_Rsmp_dba95e77
depmod:         ide_pci_register_driver_Rsmp_018476ee
depmod:         ide_pci_register_host_proc
depmod:         ide_setup_pci_device_Rsmp_c4237914


CONFIG_AIC7XXX_BUILD_FIRMWARE=y

Not fixed:

This one works:

--- drivers/scsi/aic7xxx/Makefile.Alan  Sun Oct 27 02:20:06 2002
+++ drivers/scsi/aic7xxx/Makefile       Sat Oct 26 03:53:07 2002
@@ -37,12 +37,11 @@ $(addprefix $(obj)/,$(aic7xxx-objs)): $(

 ifeq ($(CONFIG_AIC7XXX_BUILD_FIRMWARE),y)

-$(obj)/aic7xxx_seq.h: $(src)/aic7xxx.seq $(src)/aic7xxx.reg \
-                     $(obj)/aicasm/aicasm
-       $(obj)/aicasm/aicasm -I$(obj) -r $(obj)/aic7xxx_reg.h \
-                                -o $(obj)/aic7xxx_seq.h $(src)/aic7xxx.seq
-
-$(obj)/aic7xxx_reg.h: $(obj)/aix7xxx_seq.h
+$(obj)/aic7xxx_seq.h $(obj)/aic7xxx_reg.h: $(src)/aic7xxx.seq \
+                                           $(src)/aic7xxx.reg \
+                                           $(obj)/aicasm/aicasm
+       $(obj)/aicasm/aicasm -I$(src) -r $(obj)/aic7xxx_reg.h \
+                                 -o $(obj)/aic7xxx_seq.h $(src)/aic7xxx.seq

 $(obj)/aicasm/aicasm: $(src)/aicasm/*.[chyl]
        $(MAKE) -C $(src)/aicasm

Regards,
	Dieter
