Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263583AbRFAPe4>; Fri, 1 Jun 2001 11:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263584AbRFAPeg>; Fri, 1 Jun 2001 11:34:36 -0400
Received: from f96.law7.hotmail.com ([216.33.237.96]:24582 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S263583AbRFAPee>;
	Fri, 1 Jun 2001 11:34:34 -0400
X-Originating-IP: [63.114.211.31]
From: "Adam Margulies" <aamargulies@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: megaraid
Date: Fri, 01 Jun 2001 11:34:28 -0400
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F96hotjCjWEF0HG0anl00000db9@hotmail.com>
X-OriginalArrivalTime: 01 Jun 2001 15:34:28.0625 (UTC) FILETIME=[587F3810:01C0EAB0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've had to keep an old 1.14b version of the driver around in order to build 
a functional kernel for a while now.
If I use the newer version (1.14g-ac2), then the kernel can't find my root 
filesystem on boot.

Is this a problem other people have seen? I believe I have the very latest 
firmware and I also believe my lilo.conf is correct.
The most instructive error is the "please a append a correct "root=" boot 
option", but why is my lilo.conf correct for 1.14b and not correct for 
1.14g?

	a successful startup with 1.14b looks like this:

SCSI subsystem driver Revision: 1.00
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.1.11
<Adaptec aic7899 Ultra160 SCSI adapter>
aic7899: Wide Channel A, SCSI Id=7, 32/255 SCBs
scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.1.11
   <Adaptec aic7899 Ultra160 SCSI adapter>
   aic7899: Wide Channel B, SCSI Id=7, 32/255 SCBs
megaraid: v1.14b (Release Date: Jan 18, 2001; 17:06)
megaraid: found 0x101e:0x1960:idx 0:bus 4:slot 0:func 0
scsi2 : Found a MegaRAID controller at 0xc0808000, IRQ: 22
megaraid: [l148:3.11] detected 1 logical drives
scsi2 : AMI MegaRAID l148 254 commands 16 targs 2 chans 40 luns
scsi2: scanning channel 1 for devices.
scsi2: scanning channel 2 for devices.
scsi2: scanning virtual channel for logical drives.
  Vendor: MegaRAID  Model: LD0 RAID1 35255R  Rev: l148
  Type:   Direct-Access                      ANSI SCSI revision: 02
Attached scsi disk sda at scsi2, channel 2, id 0, lun 0
SCSI device sda: 72202240 512-byte hdwr sectors (36968 MB)
Partition check:
sda: sda1 sda2 < sda5 > sda3 sda4
usb.c: registered new driver hub
usb-ohci.c: USB OHCI at membase 0xc080a000, IRQ 10
usb-ohci.c: usb-00:0f.2, PCI device 1166:0220 (ServerWorks)
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 4 ports detected
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET 4.0.
NET4: AppleTalk 0.18a for Linux NET4.0
reiserfs: checking transaction log (device 08:01) ...
Using tea hash to sort names
reiserfs: using 3.5.x disk format
ReiserFS version 3.6.25
VFS: Mounted root (reiserfs filesystem) readonly.

	an unsuccessful startup with 1.14g looks like this:

SCSI subsystem driver Revision: 1.00
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.1.13
        <Adaptec aic7899 Ultra160 SCSI adapter>
        aic7899: Wide Channel A, SCSI Id=7, 32/255 SCBs

scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.1.13
        <Adaptec aic7899 Ultra160 SCSI adapter>
        aic7899: Wide Channel B, SCSI Id=7, 32/255 SCBs

megaraid: v1.14g-ac2 (Release Date: Mar 22, 2001; 19:34:02)
megaraid: found 0x101e:0x1960:idx 0:bus 4:slot 0:func 0
scsi2 : Found a MegaRAID controller at 0xc0808000, IRQ: 22
scsi2 : enabling 64 bit support
megaraid: [l148:3.11] detected 1 logical drives
scsi2 : AMI MegaRAID l148 254 commands 16 targs 2 chans 40 luns
scsi2 : scanning channel 1 for devices.
scsi2 : scanning channel 2 for devices.
scsi2 : scanning virtual channel for logical drives.
  Vendor MegaRAID  Model: LD0 RAID1 35255R  Rev: l148
  Type:  Direct-Access                      ANSI SCSI revision: 02
SCSI device sda: 72202240 512-byte hdwr sectors (36968 MB)
Partition check:
sda: unknown partition table
VFS: Cannot open root device "801" or 08:01
Please append a correct "root=" boot option
Kernel panic: VFS: Unable to mount root fs on 08:01


Here's my configuration:

dual AIC-7899 SCSI controllers, bios 2.57
MegaRAID 40-LD bios ver 3.11 12/13/2000

lilo.conf:

boot=/dev/sda
map=/boot/map
install=/boot/boot.b
prompt
timeout=50
message=/boot/message
vga=ext
#linear
lba32
default=linux2.4.5-ac4

image=/boot/vmlinuz-2.4.5-ac4
        label=linux2.4.5-ac4
        read-only
        root=/dev/sda1
image=/boot/vmlinuz-2.4.4tuxA1
        label=linux2.4.4tuxA1
        read-only
        root=/dev/sda1

.configs are the same for both kernel builds...

_________________________________________________________________
Get your FREE download of MSN Explorer at http://explorer.msn.com

