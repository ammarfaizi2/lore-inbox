Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263423AbTJLFLU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 01:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263425AbTJLFLU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 01:11:20 -0400
Received: from mail.tbdnetworks.com ([63.209.25.99]:42245 "EHLO stargazer")
	by vger.kernel.org with ESMTP id S263423AbTJLFLP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 01:11:15 -0400
Date: Sat, 11 Oct 2003 22:11:07 -0700
To: linux-kernel@vger.kernel.org
Cc: linux-usb-users@lists.sourceforge.net
Subject: usb-storage kills lilo (2.6-test[67])
Message-ID: <20031012051107.GA1881@defiant>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Norbert Kiesel <nkiesel@tbdnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(sorry for the flashy subject, but I could not come up with another one
:-)

Hi, I got problems with usb-storage and linux-2.6-test[67]. AFAICS,
test5 works fine (still have to retest to make sure).

Problem is that inserting my USB flash memory disk makes /dev/sda (and
/dev/sda1) appear in /proc/partitions, but removing it does not remove
the entries from /proc/partitions.  lilo is reading /proc/partitions
(verified trough strace) and dies because /dev/sda is gone.

Possibly related to that is the next time I insert the flash disk, is
shows up as /dev/sdb1 (and adds this to /proc/partiotions, too). 

System is a Debian-sid updated today morning (see below for details).

Please CC (I read the kernel list but not the USB one).

so long
	Norbert


defiant% cat /proc/version
Linux version 2.6.0-test7 (nkiesel@defiant) (gcc version 3.3.2 20031005 (Debian prerelease)) #8 Wed Oct 8 18:11:11 PDT 2003

defiant% ls '/sys/devices/pci0000:00/0000:00:07.2/usb1/1-2/1-2.4/1-2.4.2/1-2.4.2:1.0/host1/1:0:0:0'
block   detach_state    model   queue_depth  rev         type
delete  device_blocked  online  rescan       scsi_level  vendor
defiant% cat '/sys/devices/pci0000:00/0000:00:07.2/usb1/1-2/1-2.4/1-2.4.2/1-2.4.2:1.0/host1/1:0:0:0/type'
0
defiant% cat '/sys/devices/pci0000:00/0000:00:07.2/usb1/1-2/1-2.4/1-2.4.2/1-2.4.2:1.0/host1/1:0:0:0/model'
DIGITAL FILM

defiant% grep -E 'USB|IDE' .config | grep -v '^#'
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDEFLOPPY=m
CONFIG_BLK_DEV_IDESCSI=y
CONFIG_IDE_TASKFILE_IO=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_AUTO=y
CONFIG_VIDEO_SELECT=y
CONFIG_USB=m
CONFIG_USB_DEVICEFS=y
CONFIG_USB_UHCI_HCD=m
CONFIG_USB_STORAGE=m
CONFIG_USB_STORAGE_DEBUG=y
CONFIG_USB_STORAGE_JUMPSHOT=y
CONFIG_USB_HID=m
CONFIG_USB_HIDINPUT=y
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_VISOR=m

defiant% /usr/sbin/lsusb
Bus 002 Device 001: ID 0000:0000  
Bus 001 Device 006: ID 05dc:0080 Lexar Media, Inc. 
Bus 001 Device 004: ID 058f:9254 Alcor Micro Corp. Hub
Bus 001 Device 003: ID 0451:2046 Texas Instruments, Inc. TUSB2046 Hub
Bus 001 Device 002: ID 045e:0040 Microsoft Corp. Wheel Mouse Optical
Bus 001 Device 001: ID 0000:0000  

defiant% cat /proc/partitions
major minor  #blocks  name

  22    64   11255328 hdd
  22    65    3583912 hdd1
  22    66          1 hdd2
  22    69     255496 hdd5
  22    70    3840448 hdd6
  22    71    1024096 hdd7
  22    72    2551216 hdd8
  33    64    8901720 hdf
  33    65    8901616 hdf1
  34    64   20066251 hdh
  34    65          1 hdh1
  34    66     976752 hdh2
  34    69   12287961 hdh5
  34    70    6800944 hdh6
   8     0     125952 sda
   8     1     125296 sda1
   8    16     125952 sdb
   8    17     125296 sdb1

defiant% mount
rootfs on / type rootfs (rw)
/dev/root on / type ext3 (rw)
proc on /proc type proc (rw)
devpts on /dev/pts type devpts (rw)
/dev/hdd6 on /usr type ext3 (rw)
/dev/hdd8 on /var type ext3 (rw)
/dev/hdd7 on /tmp type ext3 (rw)
/dev/hdh5 on /home type ext3 (rw)
/dev/hdf1 on /ogg type ext3 (rw)
sysfs on /sys type sysfs (rw)
usbfs on /proc/bus/usb type usbfs (rw)
dev:/a on /a type nfs (rw,nosuid,nodev,v3,rsize=8192,wsize=8192,hard,intr,udp,lock,addr=dev)
dev:/b on /b type nfs (rw,nosuid,nodev,v3,rsize=8192,wsize=8192,hard,intr,udp,lock,addr=dev)
dev:/space on /space type nfs (ro,nosuid,nodev,v3,rsize=8192,wsize=8192,hard,intr,udp,lock,addr=dev)
dev:/local on /local type nfs (rw,nosuid,nodev,v3,rsize=8192,wsize=8192,hard,intr,udp,lock,addr=dev)
//iota/repository on /iota type smbfs (rw,uid=511,gid=511,file_mode=0744,dir_mode=0755)
automount(pid792) on /var/autofs/misc type autofs (rw)
automount(pid808) on /var/autofs/net type autofs (rw)

defiant% tail -n 30 /var/log/messages
Oct 11 21:09:31 defiant kernel: hub 1-2.4:1.0: new USB device on port 2, assigned address 5
Oct 11 21:09:31 defiant kernel: Initializing USB Mass Storage driver...
Oct 11 21:09:31 defiant kernel: scsi0 : SCSI emulation for USB Mass Storage devices
Oct 11 21:09:31 defiant kernel:   Vendor: LEXAR     Model: DIGITAL FILM      Rev: /W1.
Oct 11 21:09:31 defiant kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
Oct 11 21:09:31 defiant kernel: SCSI device sda: 251904 512-byte hdwr sectors (129 MB)
Oct 11 21:09:31 defiant scsi.agent[1219]: how to add device type= at /devices/pci0000:00/0000:00:07.2/usb1/1-2/1-2.4/1-2.4.2/1-2.4.2:1.0/host0/0:0:0:0 ??
Oct 11 21:09:31 defiant kernel: sda: Write Protect is off
Oct 11 21:09:31 defiant kernel: sda: cache data unavailable
Oct 11 21:09:31 defiant kernel:  sda:<7>usb-storage: queuecommand called
Oct 11 21:09:31 defiant kernel:  sda1
Oct 11 21:09:31 defiant kernel: Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0
Oct 11 21:09:31 defiant kernel: Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
Oct 11 21:09:31 defiant kernel: drivers/usb/core/usb.c: registered new driver usb-storage
Oct 11 21:09:31 defiant kernel: USB Mass Storage support registered.
Oct 11 21:11:18 defiant kernel: usb 1-2.4.2: USB disconnect, address 5
Oct 11 21:11:28 defiant kernel: hub 1-2.4:1.0: new USB device on port 2, assigned address 6
Oct 11 21:11:28 defiant kernel: scsi1 : SCSI emulation for USB Mass Storage devices
Oct 11 21:11:28 defiant kernel:   Vendor: LEXAR     Model: DIGITAL FILM      Rev: /W1.
Oct 11 21:11:28 defiant kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
Oct 11 21:11:28 defiant kernel: SCSI device sdb: 251904 512-byte hdwr sectors (129 MB)
Oct 11 21:11:28 defiant kernel: sdb: Write Protect is off
Oct 11 21:11:28 defiant kernel: sdb: cache data unavailable
Oct 11 21:11:28 defiant kernel:  sdb:<7>usb-storage: queuecommand called
Oct 11 21:11:28 defiant kernel:  sdb1
Oct 11 21:11:28 defiant kernel: Attached scsi removable disk sdb at scsi1, channel 0, id 0, lun 0
Oct 11 21:11:28 defiant kernel: Attached scsi generic sg0 at scsi1, channel 0, id 0, lun 0,  type 0
Oct 11 21:11:28 defiant scsi.agent[1321]: how to add device type= at /devices/pci0000:00/0000:00:07.2/usb1/1-2/1-2.4/1-2.4.2/1-2.4.2:1.0/host1/1:0:0:0 ??
