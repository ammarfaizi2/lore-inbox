Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135553AbRD2G0Q>; Sun, 29 Apr 2001 02:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132691AbRD2G0H>; Sun, 29 Apr 2001 02:26:07 -0400
Received: from smtp1.xs4all.nl ([194.109.127.131]:41732 "EHLO smtp1.xs4all.nl")
	by vger.kernel.org with ESMTP id <S135553AbRD2G0B>;
	Sun, 29 Apr 2001 02:26:01 -0400
From: thunder7@xs4all.nl
Date: Sun, 29 Apr 2001 07:58:56 +0200
To: mdharm-usb@one-eyed-alien.net
Cc: linux-kernel@vger.kernel.org
Subject: Mounting an external USB host-powered ZIP 250 drive hangs in mount()
Message-ID: <20010429075856.A821@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I cannot seem to mount my external USB host-powered 250 Mb zip-drive in
Linux-2.4.3-ac12. This is a freshly rebooted machine, rebooted with the
zip-drive attached and a zip-disk inside that Windows-2000 will read
without problems.

dmesg:
uhci.c: USB UHCI at I/O 0xc400, IRQ 7
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
uhci.c: USB UHCI at I/O 0xc800, IRQ 7
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
Initializing USB Mass Storage driver...
usb.c: registered new driver usb-storage
USB Mass Storage support registered.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 240k freed
hub.c: USB new device connect on bus1/1, assigned device number 2
scsi1 : SCSI emulation for USB Mass Storage devices
  Vendor: IOMEGA    Model: ZIP 250           Rev: 61.T
  Type:   Direct-Access                      ANSI SCSI revision: 02
Attached scsi removable disk sda at scsi1, channel 0, id 0, lun 0
sda : READ CAPACITY failed.
sda : status = 1, message = 00, host = 0, driver = 08 
sda : extended sense code = 2 
sda : block size assumed to be 512 bytes, disk size 1GB.  
 sda: I/O error: dev 08:00, sector 0
 unable to read partition table
WARNING: USB Mass Storage data integrity not assured
USB Mass Storage device found at 2
======================================================================
IRQ 7 is an unshared IRQ.
I've read that the 'READ CAPACITY failed' indicates there is no disk
in the drive - but there is.


/proc/scsi/usb-storage-0/1:
   Host scsi1: usb-storage
       Vendor: Iomega
      Product: USB Zip 250
Serial Number: 003240BCC4D11622
     Protocol: Transparent SCSI
    Transport: Bulk
         GUID: 059b0032003240bcc4d11622

All seems fine, but when I do

mount /dev/sda4 /mnt

the whole kernel hangs, including the keyboard and the network.
Windows-2000 on the same hardware can access the device. If I strace the
mount progress, it hangs in

mount("/dev/sda4", "/mnt", "vfat", 0xc0ed000, 0

I've searched the web, searched the mailing lists at usb/sourceforge,
and I seem to be alone in this.

Hardware:

Abit VP6, dual P3/866
512 Mb memory
gcc-2.95.3
SuSE 7.1 basis
linux-2.4.3-ac12

Kernel config:

CONFIG_USB=y
CONFIG_USB_UHCI_ALT=y
CONFIG_USB_STORAGE=y
CONFIG_SCSI=y
CONFIG_SCSI_DEBUG_QUEUES=y
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_SYM53C8XX=y
CONFIG_SCSI_NCR53C8XX_DEFAULT_TAGS=4
CONFIG_SCSI_NCR53C8XX_MAX_TAGS=32
CONFIG_SCSI_NCR53C8XX_SYNC=20
CONFIG_SCSI_NCR53C8XX_SYMBIOS_COMPAT=y

I thought that would do the trick?

Thanks for any help that prevents me from rebooting into Windows-2000
every time!

Jurriaan
-- 
I have transcended that phase in my intellectual growth where I discover
humour in simple freakishness. What exists is real, therefore it is tragic,
since whatever lives must die. Only fantasy, the vapors rising from sheer
nonsense, can now excite my laughter.
	Jack Vance - Lyonesse II - The Green Pearl
GNU/Linux 2.4.3-ac12 SMP/ReiserFS 2x1743 bogomips load av: 0.05 0.03 0.00
