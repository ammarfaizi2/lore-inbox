Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267722AbUG3Ppp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267722AbUG3Ppp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 11:45:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267723AbUG3Ppp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 11:45:45 -0400
Received: from S01060080c85517f6.wp.shawcable.net ([24.77.129.12]:49342 "EHLO
	ubb.ca") by vger.kernel.org with ESMTP id S267722AbUG3Po5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 11:44:57 -0400
Mime-Version: 1.0 (Apple Message framework v618)
Content-Transfer-Encoding: 7bit
Message-Id: <6672E9F8-E23F-11D8-8B40-0005023722B8@ubb.ca>
Content-Type: text/plain; charset=US-ASCII; format=flowed
To: linux-kernel@vger.kernel.org
From: Tony Mantler <nicoya@ubb.ca>
Subject: RAID1 Corruption
Date: Fri, 30 Jul 2004 10:44:53 -0500
X-Mailer: Apple Mail (2.618)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, here's the deal. My friend has a Dual-CPU PowerMac 9600, and it's 
randomly corrupting it's filesystem. Kernel is 2.6.5, unpatched.

Currently it's set up as thus:

IDE Harddrives -> MD RAID1 -> LVM -> XFS

Everything works fine with only one drive in the RAID1 (not that it's 
much of a RAID1 that way). Add in a second drive (100% clean), sync it 
up, and it eats the filesystem.

I'm really quite baffled as to why this is happening, and my friend is 
getting understandably frustrated.

# uname -a
Linux egunn 2.6.5 #4 SMP Thu Jun 24 22:15:21 CDT 2004 ppc GNU/Linux

# cat /proc/ide/pdc202xx

                                 Ultra66 Chipset.
------------------------------- General Status 
---------------------------------
Burst Mode                           : enabled
Host Mode                            : Tri-Stated
Bus Clocking                         : 100 External
IO pad select                        : 10 mA
Status Polling Period                : 15
Interrupt Check Status Polling Delay : 15
--------------- Primary Channel ---------------- Secondary Channel 
-------------
                 disabled                         disabled
66 Clocking     enabled                          enabled
            Mode MASTER                      Mode MASTER
                 Error                            Error
--------------- drive0 --------- drive1 -------- drive0 ---------- 
drive1 ------
DMA enabled:    yes              yes             yes               yes
DMA Mode:       UDMA 4           NOTSET          UDMA 4            
NOTSET
PIO Mode:       PIO 4            NOTSET           PIO 4            
NOTSET

# cat /proc/mdstat
Personalities : [linear] [raid0] [raid1] [raid5]
md0 : active raid1 hde[0] hdg[1]
       40146560 blocks [2/2] [UU]

unused devices: <none>

# pvdisplay
   --- Physical volume ---
   PV Name               /dev/md0
   VG Name               raid40gs
   PV Size               38.29 GB / not usable 0
   Allocatable           yes (but full)
   PE Size (KByte)       4096
   Total PE              9801
   Free PE               0
   Allocated PE          9801
   PV UUID               lKMk7i-S9Ex-OWsl-tp1Y-ujvy-GrgS-sINUpT
# vgdisplay
   --- Volume group ---
   VG Name               raid40gs
   System ID
   Format                lvm2
   Metadata Areas        1
   Metadata Sequence No  4
   VG Access             read/write
   VG Status             resizable
   MAX LV                0
   Cur LV                3
   Open LV               3
   Max PV                0
   Cur PV                1
   Act PV                1
   VG Size               38.29 GB
   PE Size               4.00 MB
   Total PE              9801
   Alloc PE / Size       9801 / 38.29 GB
   Free  PE / Size       0 / 0
   VG UUID               96IWfR-zm53-3qD8-ZilV-9zW6-VG87-36QqDI

# lvdisplay
   --- Logical volume ---
   LV Name                /dev/raid40gs/var
   VG Name                raid40gs
   LV UUID                jgdM0R-fp4I-LgAl-s1vI-63i0-WHX6-OfnU69
   LV Write Access        read/write
   LV Status              available
   # open                 1
   LV Size                4.88 GB
   Current LE             1250
   Segments               1
   Allocation             inherit
   Read ahead sectors     0
   Block device           253:0

   --- Logical volume ---
   LV Name                /dev/raid40gs/usr
   VG Name                raid40gs
   LV UUID                hWtNL5-gfaq-jwj4-R6XD-Sew2-TKCy-fxLKrW
   LV Write Access        read/write
   LV Status              available
   # open                 1
   LV Size                4.88 GB
   Current LE             1250
   Segments               1
   Allocation             inherit
   Read ahead sectors     0
   Block device           253:1

   --- Logical volume ---
   LV Name                /dev/raid40gs/home
   VG Name                raid40gs
   LV UUID                myekKQ-eXR7-0dGV-ZMg6-ISPG-Hijh-ZmDA5V
   LV Write Access        read/write
   LV Status              available
   # open                 1
   LV Size                28.52 GB
   Current LE             7301
   Segments               1
   Allocation             inherit
   Read ahead sectors     0
   Block device           253:2


--
Tony 'Nicoya' Mantler -- Master of Code-fu -- nicoya@ubb.ca
--  http://nicoya.feline.pp.se/  --  http://www.ubb.ca/  --

