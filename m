Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129396AbRA3OaE>; Tue, 30 Jan 2001 09:30:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130368AbRA3O3y>; Tue, 30 Jan 2001 09:29:54 -0500
Received: from pliniusz.dkgroup.com.pl ([217.8.164.106]:40713 "EHLO
	Pliniusz.dkgroup.com.pl") by vger.kernel.org with ESMTP
	id <S129396AbRA3O3e>; Tue, 30 Jan 2001 09:29:34 -0500
From: "Micha³ 'CeFeK' Nazarewicz" 
	<CeFeK@MichalNazarewicz.COM>
To: <linux-kernel@vger.kernel.org>
Subject: FW: 2.4.1 - ppc - compile problems
Date: Sun, 28 Jan 2001 15:32:33 +0100
Message-ID: <NEBBIOGJMKPNNALEPMFGMEJACCAA.CeFeK@MichalNazarewicz.COM>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



[FAQ informations at http://www.tux.org/lkml/ are inaccurate -- wrong list
address :-)]

Hello,

There appears to be undefined variable (in pmac_pci), called
PCI_DEVICE_ID_APPLE_KL_USB. When anyone tries to compile the newest kernel
on PPC machine with USB support on, there is an error saying that this is
undefined.

This definition does not exist in include/linux/pci_ids.h

After having dealt with this problem (forced the function to always return
0 -- i don't use iMac, either), there are some problems with linking:

ld -T arch/ppc/vmlinux.lds -Ttext 0xc0000000 -Bstatic arch/ppc/kernel/head.o
init/main.o init/version.o \
        --start-group \
        arch/ppc/kernel/kernel.o arch/ppc/mm/mm.o arch/ppc/lib/lib.o
kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o arch/ppc/xmon/x.o \
        drivers/block/block.o drivers/char/char.o drivers/misc/misc.o
drivers/net/net.o drivers/media/media.o  drivers/net/appletalk/appletalk.o
drivers/ide/idedriver.o drivers/scsi/scsidrv.o drivers/cdrom/driver.o
drivers/sound/sounddrivers.o drivers/pci/driver.o
drivers/macintosh/macintosh.o drivers/video/video.o drivers/usb/usbdrv.o
drivers/input/inputdrv.o \
        net/network.o \
        /usr/src/linux/lib/lib.a \
        --end-group \
        -o vmlinux
arch/ppc/kernel/kernel.o: In function `pmac_ide_default_irq':
arch/ppc/kernel/kernel.o(.text+0xbbb4): undefined reference to
`pmac_ide_get_irq'
arch/ppc/kernel/kernel.o(.text+0xbbb4): relocation truncated to fit:
R_PPC_REL24 pmac_ide_get_irq
arch/ppc/kernel/kernel.o: In function `pmac_init':
arch/ppc/kernel/kernel.o(.text.init+0x2de6): undefined reference to
`keyboard_sends_linux_keycodes'
arch/ppc/kernel/kernel.o(.text.init+0x2dea): undefined reference to
`keyboard_sends_linux_keycodes'
arch/ppc/kernel/kernel.o(.text.init+0x2e32): undefined reference to
`mac_hid_init_hw'
arch/ppc/kernel/kernel.o(.text.init+0x2e36): undefined reference to
`mac_hid_kbd_translate'
arch/ppc/kernel/kernel.o(.text.init+0x2e3a): undefined reference to
`mac_hid_kbd_unexpected_up'
arch/ppc/kernel/kernel.o(.text.init+0x2eb2): undefined reference to
`mac_hid_init_hw'
arch/ppc/kernel/kernel.o(.text.init+0x2eb6): undefined reference to
`mac_hid_kbd_translate'
arch/ppc/kernel/kernel.o(.text.init+0x2eba): undefined reference to
`mac_hid_kbd_unexpected_up'
arch/ppc/kernel/kernel.o(.text.init+0x2f12): undefined reference to
`mac_hid_kbd_sysrq_xlate'
arch/ppc/kernel/kernel.o(.text.init+0x2f16): undefined reference to
`mac_hid_kbd_sysrq_xlate'
drivers/scsi/scsidrv.o: In function `ncr_script_copy_and_bind':
drivers/scsi/scsidrv.o(.text.init+0x8a0): undefined reference to
`phys_to_bus'
drivers/scsi/scsidrv.o(.text.init+0x8a0): relocation truncated to fit:
R_PPC_REL24 phys_to_bus
drivers/scsi/scsidrv.o: In function `ncr_attach':
drivers/scsi/scsidrv.o(.text.init+0x1898): undefined reference to
`phys_to_bus'
drivers/scsi/scsidrv.o(.text.init+0x1898): relocation truncated to fit:
R_PPC_REL24 phys_to_bus
drivers/macintosh/macintosh.o: In function `powerbook_sleep_G3':
drivers/macintosh/macintosh.o(.text.openfirmware+0x1d20): undefined
reference to `grackle_pcibios_read_config_word'
drivers/macintosh/macintosh.o(.text.openfirmware+0x1d20): relocation
truncated to fit: R_PPC_REL24 grackle_pcibios_read_config_word
drivers/macintosh/macintosh.o(.text.openfirmware+0x1d44): undefined
reference to `grackle_pcibios_write_config_word'
drivers/macintosh/macintosh.o(.text.openfirmware+0x1d44): relocation
truncated to fit: R_PPC_REL24 grackle_pcibios_write_config_word
drivers/macintosh/macintosh.o(.text.openfirmware+0x1d5c): undefined
reference to `grackle_pcibios_read_config_word'
drivers/macintosh/macintosh.o(.text.openfirmware+0x1d5c): relocation
truncated to fit: R_PPC_REL24 grackle_pcibios_read_config_word
drivers/macintosh/macintosh.o(.text.openfirmware+0x1d7c): undefined
reference to `grackle_pcibios_write_config_word'
drivers/macintosh/macintosh.o(.text.openfirmware+0x1d7c): relocation
truncated to fit: R_PPC_REL24 grackle_pcibios_write_config_word
drivers/video/video.o: In function `chips_of_init':
drivers/video/video.o(.text.init+0x4d10): undefined reference to
`pci_device_loc'
drivers/video/video.o(.text.init+0x4d10): relocation truncated to fit:
R_PPC_REL24 pci_device_loc
drivers/video/video.o(.text.init+0x4d54): undefined reference to
`pci_io_base'
drivers/video/video.o(.text.init+0x4d54): relocation truncated to fit:
R_PPC_REL24 pci_io_base
drivers/video/video.o(.text.init+0x4d60): undefined reference to
`pci_io_base'
drivers/video/video.o(.text.init+0x4d60): relocation truncated to fit:
R_PPC_REL24 pci_io_base
drivers/input/inputdrv.o: In function `keybdev_event':
drivers/input/inputdrv.o(.text+0xba4): undefined reference to `emulate_raw'
drivers/input/inputdrv.o(.text+0xba4): relocation truncated to fit:
R_PPC_REL24 emulate_raw
make: *** [vmlinux] Error 1



And I *really* need this 2.4 kernel... because under 2.2 my ethernet works
strangely.

Oh, BTW -- my GNU ld is of version 2.9.5 (with BFD 2.9.5.0.19)

I am not a subscriber of this list, but I thought it might be helpful --
please CC: all email regarding this to me. Please...

Greetings
     Micha³ 'CeFeK' Nazarewicz
     dk Career Online SA
     office: +48 (22) 816 7603
     mobile: +48 (XXX) CEFEK 0
     fax   : +48 (22) 642 7888

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
