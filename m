Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964902AbVHOTGB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964902AbVHOTGB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 15:06:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964896AbVHOTGB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 15:06:01 -0400
Received: from mailhub.lss.emc.com ([168.159.2.31]:29286 "EHLO
	mailhub.lss.emc.com") by vger.kernel.org with ESMTP id S964886AbVHOTGA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 15:06:00 -0400
Message-ID: <4300E83F.1090401@emc.com>
Date: Mon, 15 Aug 2005 15:08:47 -0400
From: Brett Russ <russb@emc.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 2.6.13-rc6] PCI/libata INTx cleanup
References: <20050803204709.8BA0720B06@lns1058.lss.emc.com> <42FBA08C.5040103@pobox.com> <20050812171043.CF61020E8B@lns1058.lss.emc.com> <20050812182253.GA7842@suse.de> <42FD14E9.8060502@pobox.com> <20050812224303.F40A820E94@lns1058.lss.emc.com> <20050815185732.GA15216@kroah.com>
In-Reply-To: <20050815185732.GA15216@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-PMX-Version: 4.7.1.128075, Antispam-Engine: 2.1.0.0, Antispam-Data: 2005.8.15.22
X-PerlMx-Spam: Gauge=, SPAM=7%, Reasons='EMC_FROM_00+ 0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0, __USER_AGENT 0'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Fri, Aug 12, 2005 at 06:43:03PM -0400, Brett Russ wrote:
> 
>>Simple cleanup to eliminate X copies of the pci_enable_intx() function
>>in libata.  Moved ahci.c's pci_intx() to pci.c and use it throughout
>>libata and msi.c.
>>
>>Signed-off-by: Brett Russ <russb@emc.com>
> 
> 
> It would have been nice if you had built this code :(
> 
> Hint, get rid of all TRUE and FALSE usages in your patch.  Care to try
> again?
> 
> thanks,
> 
> greg k-h


Hmm, I did build it before submitting, saw not even a warning.  So I 
just rebuilt it again to verify, and same thing.  Why would my tree work 
and not yours?  config file?

russb@lns1058:/net/maggie/exports/russb/lk/linux-2.6.13-rc6> q pop
Removing patch patches/pcix
Restoring drivers/pci/msi.c
Restoring drivers/pci/pci.c
Restoring drivers/scsi/ata_piix.c
Restoring drivers/scsi/sata_sis.c
Restoring drivers/scsi/sata_uli.c
Restoring drivers/scsi/ahci.c
Restoring include/linux/pci.h

No patches applied
russb@lns1058:/net/maggie/exports/russb/lk/linux-2.6.13-rc6> q push
Applying patch patches/pcix
patching file drivers/scsi/sata_sis.c
patching file drivers/scsi/ahci.c
patching file drivers/scsi/ata_piix.c
patching file drivers/pci/msi.c
patching file drivers/pci/pci.c
patching file include/linux/pci.h
patching file drivers/scsi/sata_uli.c

Now at patch patches/pcix
russb@lns1058:/net/maggie/exports/russb/lk/linux-2.6.13-rc6> quilt applied
patches/pcix


maggie:/net/maggie/exports/russb/lk/linux-2.6.13-rc6 # make -j5
   CHK     include/linux/version.h
make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
   CHK     include/asm-i386/asm_offsets.h
   CHK     usr/initramfs_list
   CHK     include/linux/compile.h
   CC      arch/i386/kernel/pci-dma.o
   CC      arch/i386/pci/i386.o
   CC      arch/i386/kernel/quirks.o
   CC      arch/i386/pci/pcbios.o
   CC      drivers/char/agp/backend.o
   CC      arch/i386/kernel/cpu/cyrix.o
   CC      arch/i386/kernel/cpu/mtrr/main.o
   CC      drivers/char/agp/frontend.o
   CC      arch/i386/pci/direct.o
   CC      lib/iomap.o
   CC      drivers/char/agp/generic.o
   LD      lib/built-in.o
   CC      arch/i386/pci/fixup.o
   LD      arch/i386/kernel/cpu/mtrr/built-in.o
   LD      arch/i386/kernel/cpu/built-in.o
   CC      arch/i386/pci/legacy.o
   LD      arch/i386/kernel/built-in.o
   CC      drivers/char/agp/isoch.o
   CC      drivers/char/drm/drm_auth.o
   CC      arch/i386/pci/irq.o
   CC      drivers/char/drm/drm_bufs.o
   CC      arch/i386/pci/common.o
   CC      drivers/char/agp/intel-agp.o
   CC      drivers/char/drm/drm_context.o
   LD      arch/i386/pci/built-in.o
   CC      drivers/char/drm/drm_dma.o
   CC      drivers/ide/pci/piix.o
   LD      drivers/char/agp/agpgart.o
   LD      drivers/char/agp/built-in.o
   CC      drivers/char/drm/drm_drawable.o
   CC      drivers/ieee1394/ieee1394_core.o
   CC      drivers/ide/ide.o
   CC      drivers/ide/ide-io.o
   CC      drivers/char/drm/drm_drv.o
   CC      drivers/ide/pci/rz1000.o
   CC      drivers/char/drm/drm_fops.o
   CC      drivers/char/drm/drm_init.o
   CC      drivers/ieee1394/hosts.o
   CC      drivers/char/drm/drm_ioctl.o
   CC      drivers/ide/pci/generic.o
   CC      drivers/ide/ide-iops.o
   CC      drivers/char/drm/drm_irq.o
   CC      drivers/ieee1394/nodemgr.o
   CC      drivers/ide/ide-lib.o
   LD      drivers/ide/pci/built-in.o
   CC      drivers/net/tg3.o
   CC      drivers/char/drm/drm_lock.o
   CC      drivers/parport/parport_pc.o
   CC      drivers/char/drm/drm_memory.o
   CC      drivers/ide/ide-probe.o
   CC      drivers/ieee1394/dma.o
   CC      drivers/char/drm/drm_proc.o
   CC      drivers/ieee1394/iso.o
   LD      drivers/parport/built-in.o
   CC      drivers/char/drm/drm_stub.o
   CC      drivers/ide/ide-taskfile.o
   CC      drivers/ieee1394/ohci1394.o
   CC      drivers/ieee1394/raw1394.o
   CC      drivers/char/drm/drm_vm.o
   CC      drivers/ide/pci/cmd640.o
   CC      drivers/char/drm/drm_agpsupport.o
   CC      drivers/char/drm/drm_scatter.o
   CC      drivers/ide/setup-pci.o
   CC      drivers/ide/ide-dma.o
   LD      drivers/ieee1394/ieee1394.o
   LD      drivers/ieee1394/built-in.o
   CC      drivers/ide/ide-proc.o
   CC      drivers/char/drm/ati_pcigart.o
   CC      drivers/pci/access.o
   CC      drivers/char/drm/drm_pci.o
   CC      drivers/pnp/resource.o
   CC      drivers/pci/bus.o
   CC      drivers/ide/ide-generic.o
   LD      drivers/char/drm/drm.o
   LD      drivers/char/drm/built-in.o
   LD      drivers/char/built-in.o
   CC      drivers/ide/ide-disk.o
   CC      drivers/pci/probe.o
   LD      drivers/pnp/built-in.o
   CC      drivers/ide/ide-cd.o
   CC      drivers/pci/remove.o
   LD      drivers/net/built-in.o
   LD      drivers/ide/ide-core.o
   CC      drivers/pci/pci.o
   CC      drivers/pci/quirks.o
   CC      drivers/pci/names.o
   CC      drivers/pci/pci-driver.o
   CC      drivers/scsi/libata-core.o
   CC      drivers/serial/8250_pnp.o
   LD      drivers/ide/built-in.o
   CC      drivers/pci/search.o
   CC      drivers/usb/core/message.o
   CC      drivers/serial/8250_pci.o
   CC      drivers/scsi/libata-scsi.o
   CC      drivers/pci/pci-sysfs.o
   CC      drivers/usb/core/hcd-pci.o
   LD      drivers/serial/built-in.o
   CC      drivers/usb/host/ehci-hcd.o
   CC      drivers/pci/rom.o
   CC      drivers/scsi/scsi_lib.o
   CC      drivers/pci/proc.o
   LD      drivers/usb/core/usbcore.o
   LD      drivers/usb/core/built-in.o
   CC      drivers/usb/host/uhci-hcd.o
   CC      drivers/pci/setup-res.o
   CC      drivers/pci/hotplug.o
   LD      drivers/scsi/libata.o
   CC      drivers/scsi/ahci.o
   CC      drivers/pci/setup-bus.o
   CC      drivers/scsi/ata_piix.o
   LD      drivers/scsi/sd_mod.o
   LD      drivers/scsi/scsi_mod.o
   LD      drivers/scsi/built-in.o
   LD      drivers/pci/built-in.o
   LD      drivers/usb/host/built-in.o
   LD      drivers/usb/built-in.o
   LD      drivers/built-in.o
   GEN     .version
   CHK     include/linux/compile.h
   UPD     include/linux/compile.h
   CC      init/version.o
   LD      init/built-in.o
   LD      .tmp_vmlinux1
   KSYM    .tmp_kallsyms1.S
   AS      .tmp_kallsyms1.o
   LD      .tmp_vmlinux2
   KSYM    .tmp_kallsyms2.S
   AS      .tmp_kallsyms2.o
   LD      vmlinux
   SYSMAP  System.map
   SYSMAP  .tmp_System.map
   Building modules, stage 2.
   AS      arch/i386/boot/setup.o
   MODPOST
   LD      arch/i386/boot/setup
   OBJCOPY arch/i386/boot/compressed/vmlinux.bin
   GZIP    arch/i386/boot/compressed/vmlinux.bin.gz
   LD      arch/i386/boot/compressed/piggy.o
   LD      arch/i386/boot/compressed/vmlinux
   OBJCOPY arch/i386/boot/vmlinux.bin
   BUILD   arch/i386/boot/bzImage
Root device is (8, 5)
Boot sector 512 bytes.
Setup is 4602 bytes.
System is 1814 kB
Kernel: arch/i386/boot/bzImage is ready  (#12)
