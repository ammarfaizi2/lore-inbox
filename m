Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318348AbSHUPF4>; Wed, 21 Aug 2002 11:05:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318349AbSHUPF4>; Wed, 21 Aug 2002 11:05:56 -0400
Received: from mail4.quicken.com ([206.154.105.71]:30949 "EHLO
	mail4.quicken.com") by vger.kernel.org with ESMTP
	id <S318348AbSHUPFy>; Wed, 21 Aug 2002 11:05:54 -0400
X-Server-Uuid: A30EB3EE-CD20-42DB-89B9-CCAEC3F48615
Message-ID: <1D633A747CE4D311B89400D0B73EB16E05F00A42@liex01.liv.intuit.com>
From: "Downey, Brian" <Brian_Downey@quickenloans.com>
To: "'Nagy Tibor'" <nagyt@otpbank.hu>, linux-kernel@vger.kernel.org
Subject: RE: Dell Perc 3/QC performance
Date: Wed, 21 Aug 2002 11:09:43 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
X-WSS-ID: 117D72BD3956159-01-01
Content-Type: text/plain;
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What type of RAID are you attempting to use?

-Brian

-----Original Message-----
From: Nagy Tibor [mailto:nagyt@otpbank.hu]
Sent: Wednesday, August 21, 2002 10:26 AM
To: linux-kernel@vger.kernel.org
Subject: Dell Perc 3/QC performance


Hi,

I am not satisfied with the disk I/O performance of the RAID controller
'Dell Perc 3/QC' (AMI megaraid) under Linux.

Short description of my problem:

We have a Dell PowerEdge 6600 + PERC 3/QC, and I am not satisfied with
the performance. I/O speed is not linearly growing if I read more disks
simultenausly. If I read 1 disk, I get about 49 MB/s read speed, if I
read 2 disks simultaneosly I get about 64 MB/s read speed (only
+15MB/s), if I read 3 disks simultaneosly I get about 68 MB/s read speed
(only +4MB/s), If I read more disk I don't get higher speed.

Do you have any idea, what is the problem?

Detailed description:

1. Configuration

Dell Poweredge 6600: 4 x 1400 MHz, 4 GB RAM
PERC 3/QC Firmware: 1.61N Bios: 3.17

 Logical drive 0 (18 GB) - RAID 1 - Channel 0 Id 0 - 18 GB
                                  \ Channel 0 Id 1 - 18 GB

 Logical drive 1 (22 GB) - RAID 1 - Channel 2 Id 0 - 72 GB
 Logical drive 2 (22 GB) +        \ Channel 3 Id 9 - 72 GB
 Logical drive 3 (24 GB) /

 Logical drive 4 (22 GB) - RAID 1 - Channel 2 Id 1 - 72 GB
 Logical drive 5 (22 GB) +        \ Channel 3 Id 10 - 72 GB
 Logical drive 6 (24 GB) /

 Logical drive 7 (22 GB) - RAID 1 - Channel 2 Id 2 - 72 GB
 Logical drive 8 (22 GB) +        \ Channel 3 Id 11 - 72 GB
 Logical drive 9 (24 GB) /

 18 GB disks: Quantum ATLAS 10KIII 18 SCA (160 MB SCSI)
 72 GB disks: Hitachi DK32DJ-72 (160 MB SCSI)

 The 18 GB disks are installed in the server itself, the 72 GB disks are
installed in a PowerVault 221S disk tower with splitted backplane.

 The 72 GB disks are splitted into 22-24 GB logical drives, because
Informix database engine can use max 2GB chunks (partitions), and only
15 partitions can be installed in linux on 1 drive.

 'Cache policy' is set to 'Direct IO' and 'Read (ahead) policy' to
'adaptive' for all logical drives. (I tried other confugurations, too.)

 Logical drives 1-9 are used as raw devices by informix, logical drive 0
is for the operating system.

2. Operating system

SuSe Linux 8.0, kernel 2.4.18

emiir:~ # uname -a
Linux emiir 2.4.18-64GB-SMP #1 SMP Wed Mar 27 13:58:12 UTC 2002 i686
unknown


3. I/O test

3.1 Read from Logical drive 1

dd if=/dev/rsdb1 of=/dev/null bs=1024k	->  49 MB/s I/O

3.2 Read from Logical drive 1 and 4 (different disks)

dd if=/dev/rsdb1 of=/dev/null bs=1024k &
dd if=/dev/rsde1 of=/dev/null bs=1024k &  -> 64 MB/s I/O

3.2 Read from Logical drive 1, 4 and 7 (different disks)

dd if=/dev/rsdb1 of=/dev/null bs=1024k &
dd if=/dev/rsde1 of=/dev/null bs=1024k &
dd if=/dev/rsdh1 of=/dev/null bs=1024k &  -> 68 MB/s I/O

All I/O speed came from the column 'bi' of 'vmstat 1'.


4. Result

I do not understand, why the speed is not increased nearly linearly. The
I/O between the PERC controller and the host is 64 bit PCI with 66MHz,
ca. 530MB/s, each of the four SCSI channel has a speed of 160MB/s. At
least test 3.2 should result the double of the speed of test 3.1 (two
SCSI channel, separate disks).

I see also on the dell site 300 MB/s for sequential read:
  http://www.dell.com/us/en/biz/topics/power_ps1q02-perc.htm

Do you have any idea what can be wrong?

Than you

Tibor

------------------------------------------------------------------------
Tibor Nagy
National Savings and Commercial Bank Ltd (OTP Bank)
H-1051 Budapest Nador u. 16.
Tel: 00 36 1 374 6990	Fax: 00 36 1 374 6981	E-mail: nagyt@otpbank.hu
------------------------------------------------------------------------

