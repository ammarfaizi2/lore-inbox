Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318428AbSHGQep>; Wed, 7 Aug 2002 12:34:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318642AbSHGQep>; Wed, 7 Aug 2002 12:34:45 -0400
Received: from m5-real.eastlink.ca ([24.222.0.25]:26326 "EHLO m5.andara.com")
	by vger.kernel.org with ESMTP id <S318428AbSHGQek>;
	Wed, 7 Aug 2002 12:34:40 -0400
From: "Alan Miles" <alanmiles@hfx.eastlink.ca>
To: <linux-kernel@vger.kernel.org>
Subject: FW: Problems with 2.4.19 Kernel and Promise FastTrak100 RAID Controller (2.4.18 works)
Date: Wed, 7 Aug 2002 13:38:20 -0300
Keywords: Linux
Message-ID: <JLEBIHHBMBHBAFPAJLEFKEFACPAA.alanmiles@hfx.eastlink.ca>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo,

(Tried sending this to you at "marcelo@plucky.distro.conectiva" but it kept
getting returned to me with host unknown.)

I am sending this message to you as you are working on the 2.4.19/2.4.20
maintenance release - I am having problems with this release.

I am successfully using 2.4.18, but am having problems with 2.4.19 and the
Promise FastTrak100 Raid controller.

See my attached message.

Alan

-----Original Message-----
From: Alan Miles [mailto:alanmiles@hfx.eastlink.ca]
Sent: August 5, 2002 19:19
To: Ataraid-List
Cc: arjanv@redhat.com
Subject: Problems with 2.4.19 Kernel and Promise Fastrak100 RAID
Controller (2.4.18 works)


All,

I am not sure if there is something wrong with the ataraid in 2.4.19 (I am
successfully using the ataraid/fastrak in the 2.4.18 kernel - custom
compiled).

I have been using ataraid since the -ac days (before it was in the standard
kernel). In fact I did some testing for Arjan when he sent me a .c file to
test (in the -ac days).

This is rather lengthy but ...

To convert my 2.4.18 config file to 2.4.19 I did:

Put the 2.4.18 config in /usr/src
(from source dir: /usr/src/linux-2.4.19/)

make mrproper
make xconfig

(loaded the config file from /usr/src/)

then saved and exited - then:

make dep

copied the /usr/src/linux-2.4.19/.config to /usr/src/config.new
then:

make mrproper
cp ../config.new .config
make oldconfig

I used the same procedure when I build the 2.4.18 (2.4.17 "original" config
to build the 2.4.18 config) and 2.4.19 kernels.

My hardware configuration is as follows:

- the two similar drives (hdg/hdh) (IBM-DTLA-307060) connected to the
Fasttrak100 Promise RAID controller
- the remaining drive (hdi) (IC35L060AVER07-0) connected to the motherboard

With 2.4.18 (note: This WORKS) , and using dmesg upon boot I get:

...

hdg: IBM-DTLA-307060, ATA DISK drive
hdh: IBM-DTLA-307060, ATA DISK drive
hdi: IC35L060AVER07-0, ATA DISK drive

...

hdg: 120103200 sectors (61493 MB) w/1916KiB Cache, CHS=119150/16/63,
UDMA(100)
hdh: 120103200 sectors (61493 MB) w/1916KiB Cache, CHS=119150/16/63,
UDMA(100)
hdi: 120103200 sectors (61493 MB) w/1916KiB Cache, CHS=119150/16/63,
UDMA(100)

...

Partition check:
 hdg:<7>LDM:  DEBUG (ldm.c, 962): validate_partition_table: No MS-DOS
partition found.
 unknown partition table
 hdh: [PTBL] [7476/255/63] hdh1 < >
 hdi: [PTBL] [7476/255/63] hdi1 hdi2 hdi3 hdi4 < hdi5 hdi6 >
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
Linux video capture interface: v1.00
ide-floppy driver 0.97.sv
 ataraid/d0: ataraid/d0p1 < ataraid/d0p5 ataraid/d0p6 >
Drive 0 is 58644 Mb (34 / 64)
Drive 1 is 58644 Mb (34 / 0)
Raid0 array consists of 2 drives.
 ataraid/d1: ataraid/d1p1 ataraid/d1p2 ataraid/d1p3 ataraid/d1p4 <
ataraid/d1p5 ataraid/d1p6 >
Drive 0 is 58644 Mb (56 / 0)
Raid0 array consists of 1 drives.
Promise Fasttrak(tm) Softwareraid driver for linux version 0.03beta
Highpoint HPT370 Softwareraid driver for linux version 0.01
No raid array found
....


the cat /proc/partitions looks like:

major minor  #blocks  name

 114     0  120103137 ataraid/d0
 114     1          1 ataraid/d0p1
 114     5   35849016 ataraid/d0p5
 114     6   84244828 ataraid/d0p6
 114    16   60051568 ataraid/d1
 114    17    7389868 ataraid/d1p1
 114    18      40162 ataraid/d1p2
 114    19      40162 ataraid/d1p3
 114    20          1 ataraid/d1p4
 114    21    1413688 ataraid/d1p5
 114    22   51166993 ataraid/d1p6
  56     0   60051600 hdi
  56     1    7389868 hdi1
  56     2      40162 hdi2
  56     3      40162 hdi3
  56     4          1 hdi4
  56     5    1413688 hdi5
  56     6   51166993 hdi6
  34     0   60051600 hdg
  34    64   60051600 hdh
  34    65          1 hdh1

Note: /dev/ataraid/d1* <===> /dev/hdi*

However, with the 2.4.19 kernel (which does NOT work) I get:

...

PDC20267: IDE controller on PCI bus 00 dev 68
PCI: Found IRQ 3 for device 00:0d.0
PCI: Sharing IRQ 3 with 00:04.2
PCI: Sharing IRQ 3 with 00:04.3
PCI: Sharing IRQ 3 with 00:09.0
PDC20267: chipset revision 2
ide: Skipping Promise RAID controller.
PDC20265: IDE controller on PCI bus 00 dev 88
...

hde: IC35L060AVER07-0, ATA DISK drive

...

hde: 120103200 sectors (61493 MB) w/1916KiB Cache, CHS=119150/16/63,
UDMA(100)

...

Linux video capture interface: v1.00
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 690M
agpgart: Detected Via Apollo Pro KT133 chipset
agpgart: AGP aperture is 64M @ 0xe4000000
ide-floppy driver 0.99.newide
 ataraid/d0: ataraid/d0p1 ataraid/d0p2 ataraid/d0p3 ataraid/d0p4 <
ataraid/d0p5 ataraid/d0p6 >
Drive 0 is 58644 Mb (33 / 0)
Raid0 array consists of 1 drives.
Promise Fasttrak(tm) Softwareraid driver for linux version 0.03beta
Highpoint HPT370 Softwareraid driver for linux version 0.01
No raid array found

...

and the cat /proc/partitions looks like:

major minor  #blocks  name

 114     0   60051568 ataraid/d0
 114     1    7389868 ataraid/d0p1
 114     2      40162 ataraid/d0p2
 114     3      40162 ataraid/d0p3
 114     4          1 ataraid/d0p4
 114     5    1413688 ataraid/d0p5
 114     6   51166993 ataraid/d0p6
  33     0   60051600 hde
  33     1    7389868 hde1
  33     2      40162 hde2
  33     3      40162 hde3
  33     4          1 hde4
  33     5    1413688 hde5
  33     6   51166993 hde6

I have lost the two (IBM-DTLA-307060) drives and have /dev/ataraid/do* <===>
/dev/hde*

therefore cannot do anything.

In the 2.4.19 config file:

...

CONFIG_BLK_DEV_PDC202XX=y
CONFIG_PDC202XX_BURST=y
CONFIG_PDC202XX_FORCE=y
...

CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_BLK_DEV_ATARAID=y
CONFIG_BLK_DEV_ATARAID_PDC=y
CONFIG_BLK_DEV_ATARAID_HPT=y

Reviewing the 2.4.19 changelogs I see:

...
<marcelo@plucky.distro.conectiva> (02/07/26 1.654)
	Make FastTrak be disabled by default
...

<marcelo@plucky.distro.conectiva> (02/07/19 1.646)
	Fix wrong #ifdef in ide-pci.c: Was causing problems with FastTrak

...

<marcelo@plucky.distro.conectiva> (02/03/22 1.220.1.24)
	Add Promise 20276 to supported IDE controllers
...

<arjanv@redhat.com> (02/04/15 1.383.2.29)
	[PATCH] Add missing ataraid entries



Could any of these changes broken something? I would really like to use
2.4.19 but am limited to 2.4.18 (which works!).

Thanks,

Alan


