Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129669AbRBWUuj>; Fri, 23 Feb 2001 15:50:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129826AbRBWUu3>; Fri, 23 Feb 2001 15:50:29 -0500
Received: from ns.arraycomm.com ([199.74.167.5]:65197 "HELO
	bastion.arraycomm.com") by vger.kernel.org with SMTP
	id <S129669AbRBWUuQ>; Fri, 23 Feb 2001 15:50:16 -0500
Message-Id: <5.0.2.1.2.20010223120954.025fa3b0@pop.arraycomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Date: Fri, 23 Feb 2001 12:48:29 -0800
To: linux-kernel@vger.kernel.org
From: Jasmeet Sidhu <jsidhu@arraycomm.com>
Subject: DMA blues...System lockup on setting DMA mode using hdparam
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey guys,

I have five Promise ATA100 controllers configured using kernel version 
2.4.2-ac1 (using pdc202xx drivers of course) on ASUS A7V with a AMD Tbird 
1GHz processor.  Now for the most part this kernel is very stable.  I have 
premium cables connected to the hard drives and all drives in the system 
are masters as you can probably tell by the drive device letters 
assigned.  The cables are 80pin UDMA (100% Data Integrity).  I have not 
seen any CRC errors, in fact the system has been up overnight and has 
almost transferred about 105GB of data in various file sizes.

The problem:

when trying to set the DMA mode on the drives, using "hdparm -X69 
/dev/hda", it works fine.  As a matter of fact, this command succeeds for 
the following devices:
/dev/hda, /dev/hdc, /dev/hdm, /dev/hdo, /dev/hdq, /dev/hds
However, the system locks up completely when I try the same exact command 
for *any* of the following devices: /dev/hde, /dev/hdg, /dev/hdi, /dev/hdk.

*NOTE* the Raid5 array /dev/md0 is not running when I am trying to set the 
DMA modes.  The raid is not mounted and is in stopped mode using raidstop 
/dev/md0.

Also, when I try and use the -k and the -K switches (keep settings after 
reset), the programs says that it worked.  However, after I restart the 
system, these "flags" are set to 0 again.  Is this normal?  In other words:
hdparam -k /dev/hda
  keepsettings =  0 (off)
# now lets set the -k option (keep settings after refresh).
hdparam -k1 /dev/hda
  setting keep_settings to 1 (on)
  keepsettings =  1 (on)
# noe lets restart the system and query again
hdparam -k /dev/hda
  keepsettings =  0 (off)

Is this normal?

Also another question related to IDE:
	Is there anyway we can see how good/bad the system performance is while 
the system is working?  I am not talking about a benchmarking tool like 
bonnie that simply tries to figure out how good a system can perform.  I 
would like to see something, maybe in /proc/ide/, that shows me the current 
throughput of the ide subsystem.  For example how many kb of data is going 
in, how much coming out of each device.  Any ideas on how to go about maybe 
adding this?  Where would be an ideal place to add such functionality?  In 
the ide code or maybe in the raid section?  Or maybe these two should be 
kept separate.  Any thoughts guys?

Any additional required information can be posted, let me know.

Anybody else out there with a similar situation?  Your thoughts on this 
would be really appreciated.

Here's the setup:

ide0 at 0x3800-0x3807,0x3402 on irq 11	PDC20265
ide1 at 0x3000-0x3007,0x2802 on irq 11	
ide2 at 0x5400-0x5407,0x5002 on irq 15	PDC20267
ide3 at 0x4800-0x4807,0x4402 on irq 15
ide4 at 0x7000-0x7007,0x6802 on irq 11	PDC20267
ide5 at 0x6400-0x6407,0x6002 on irq 11
ide6 at 0x8800-0x8807,0x8402 on irq 14	PDC20267
ide7 at 0x8000-0x8007,0x7802 on irq 14
ide8 at 0xa400-0xa407,0xa002 on irq 10	PDC20267
ide9 at 0x9800-0x9807,0x9402 on irq 10

hda: 40188960 sectors (20577 MB) w/1916KiB Cache, CHS=39870/16/63, UDMA(100)
hdc: 150136560 sectors (76870 MB) w/1916KiB Cache, CHS=148945/16/63, UDMA(100)
hde: 150136560 sectors (76870 MB) w/1916KiB Cache, CHS=148945/16/63, UDMA(100)
hdg: 150136560 sectors (76870 MB) w/1916KiB Cache, CHS=148945/16/63, UDMA(100)
hdi: 150136560 sectors (76870 MB) w/1916KiB Cache, CHS=148945/16/63, UDMA(100)
hdk: 150136560 sectors (76870 MB) w/1916KiB Cache, CHS=148945/16/63, UDMA(100)
hdm: 150136560 sectors (76870 MB) w/1916KiB Cache, CHS=148945/16/63, UDMA(100)
hdo: 150136560 sectors (76870 MB) w/1916KiB Cache, CHS=148945/16/63, UDMA(100)
hdq: 150136560 sectors (76870 MB) w/1916KiB Cache, CHS=148945/16/63, UDMA(100)
hds: 150136560 sectors (76870 MB) w/1916KiB Cache, CHS=148945/16/63, UDMA(100)

# Raid-5 configuration
#
raiddev                 	/dev/md0
raid-level              	5
chunk-size           	4
parity-algorithm     	left-symmetric
persistent-superblock 	1
nr-raid-disks           	8
nr-spare-disks        	1
device          		/dev/hde1
raid-disk       		0
device          		/dev/hdg1
raid-disk       		1
device          		/dev/hdi1
raid-disk       		2
device          		/dev/hdk1
raid-disk       		3
device          		/dev/hdm1
raid-disk       		4
device          		/dev/hdo1
raid-disk       		5
device          		/dev/hdq1
raid-disk      		 6
device          		/dev/hds1
raid-disk       		7
device          		/dev/hdc1
spare-disk      		0

[root@bertha hdparm-3.9]# df -k
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/hda3             19072868   3589612  14514392  20% /
/dev/hda1               198313     11667    176392   7% /boot
/dev/md0             525461076 108657156 416803920  21% /raid
sj-f760-1:/vol/vol03/data01
                      142993408 140675648   2317760  99% /mnt/netapps

