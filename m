Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271451AbTGQOEG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 10:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271458AbTGQOEG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 10:04:06 -0400
Received: from hauptpostamt.charite.de ([193.175.66.220]:41374 "EHLO
	hauptpostamt.charite.de") by vger.kernel.org with ESMTP
	id S271451AbTGQOD7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 10:03:59 -0400
Date: Thu, 17 Jul 2003 16:18:47 +0200
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test1-ac2 issues / Toshiba Laptop keyboard
Message-ID: <20030717141847.GF7864@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Finally, I was able to get 2.6.0-test1-ac2 working.

Some issues I found:

* eepro100 is b0rked:

eepro100: Unknown symbol mii_ethtool_sset
eepro100: Unknown symbol mii_link_ok
eepro100: Unknown symbol mii_check_link
eepro100: Unknown symbol mii_nway_restart
eepro100: Unknown symbol mii_ethtool_gset

  but by switchin to e100 instead, I got my NIC working

* The kernel reports itself as "Linux version 2.6.0-test1-ac1" but IS
  ac2!

* The IDE ATA disk works, but upon reboot, the machine does NOT find
  the IDE harddisk anymore! Tis means I have to turn the machine off
  and on again (since it has no reset button)

Details:

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH3M: IDE controller at PCI slot 0000:00:1f.1
ICH3M: chipset revision 2
ICH3M: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xcfa0-0xcfa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xcfa8-0xcfaf, BIOS settings: hdc:DMA, hdd:pio
hda: TOSHIBA MK4019GAX, ATA DISK drive
anticipatory scheduling elevator
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: TOSHIBA DVD-ROM SD-R2102, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: host protected area => 1
hda: 78140160 sectors (40008 MB), CHS=77520/16/63, UDMA(100)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)

* The module "sg" doesn't work:

sg: Unknown symbol scsi_do_req
sg: Unknown symbol scsi_device_get
sg: Unknown symbol scsi_block_when_processing_errors
sg: Unknown symbol scsi_ioctl
sg: Unknown symbol scsi_device_put
sg: Unknown symbol scsi_sleep
sg: Unknown symbol scsi_reset_provider
sg: Unknown symbol scsi_register_interface
sg: Unknown symbol scsi_ioctl_send_command
sg: Unknown symbol scsi_release_request
sg: Unknown symbol scsi_allocate_request
sg: Unknown symbol proc_scsi
sg: Unknown symbol print_req_sense

* ide_scsi doesn't work:

ide_scsi: Unknown symbol scsi_remove_host
ide_scsi: Unknown symbol scsi_host_put
ide_scsi: Unknown symbol scsi_sleep
ide_scsi: Unknown symbol scsi_add_host
ide_scsi: Unknown symbol scsi_adjust_queue_depth
ide_scsi: Unknown symbol scsi_host_alloc

* usb_storage barfs:

usb_storage: Unknown symbol scsi_remove_host
usb_storage: Unknown symbol scsi_host_put
usb_storage: Unknown symbol scsi_add_host
usb_storage: Unknown symbol scsi_host_alloc

* and the most interesting issue is related to the keyboard of this
  Toshiba laptop (Satellite Pro 6100):

  The Kernel reports:

atkbd.c: Unknown key (set 2, scancode 0xb2, on isa0060/serio0) pressed.
atkbd.c: Unknown key (set 2, scancode 0xae, on isa0060/serio0) pressed.
atkbd.c: Unknown key (set 2, scancode 0xb1, on isa0060/serio0) pressed.
atkbd.c: Unknown key (set 2, scancode 0x97, on isa0060/serio0) pressed.
atkbd.c: Unknown key (set 2, scancode 0xa2, on isa0060/serio0) pressed.
atkbd.c: Unknown key (set 2, scancode 0x92, on isa0060/serio0) pressed.

when I type. Back in 2.4.x, I submitted a patch to AC that fixed an
issue with the VERY SAME Laptop and bouncing keys. This patch was
included into 2.4.x sometime (keyboard.c). Maybe it's realted to the
strange kernel message I'm seeing now?

-- 
Ralf Hildebrandt (Im Auftrag des Referat V a)   Ralf.Hildebrandt@charite.de
Charite Campus Mitte                            Tel.  +49 (0)30-450 570-155
Referat V a - Kommunikationsnetze -             Fax.  +49 (0)30-450 570-916
AIM: ralfpostfix
