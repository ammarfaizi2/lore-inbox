Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262425AbTK1Piq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 10:38:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262427AbTK1Piq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 10:38:46 -0500
Received: from imap.gmx.net ([213.165.64.20]:12738 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262425AbTK1Pim (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 10:38:42 -0500
X-Authenticated: #2249349
Date: Fri, 28 Nov 2003 16:38:32 +0100
From: Timo Boettcher <spida@gmx.net>
Reply-To: Timo Boettcher <spida@gmx.net>
X-Priority: 3 (Normal)
Message-ID: <1055053726.20031128163832@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: raid5: Operation continuing on 0 devices
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am having problems with a software-raid5 device in my system.
Because of some hardware-issues all 3 disks of that array fail after
each other, the kernel/raid-module does notice it, but does not act
upon this. 

raid5: Disk failure on sde1, disabling device. Operation continuing on 2 devices
raid5: Disk failure on sdd1, disabling device. Operation continuing on 1 devices
raid5: Disk failure on sdf1, disabling device. Operation continuing on 0 devices

Why does the kernel/raid-module not make the array read-only or take
it offline?

System is a Dual P3-933 on a Supermicro 370DE6 Mainboard, HDDs are all
scsi, problem occurred with IBM DPSS 18GB drives on 2.4.22 and now
with IBM DPSS 36GB drives in 2.6.0-test11.
I am aware that there is a hardware-problem involved, however I guess
that a software raid should be taken offline when there are not enough
drives to get the full data, at latest when there is no hdd left :-).

Here is a part from my kernel-log, as all events occurred in the same
second, I have cut all timestamps out for better readability.

If you need more information, I 'll gladly provide it.
Thanks for any help.

================== BEGIN Paste from kern.log ==================
SCSI error : <2 0 12 0> return code = 0x8000002
Current sde: sense = 70  b
ASC=47 ASCQ= 0
Raw sense data:0x70 0x00 0x0b 0x00 0x00 0x00 0x00 0x18 0x00 0x00 0x00
               0x00 0x47 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
               0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 
end_request: I/O error, dev sde, sector 11557887
raid5: Disk failure on sde1, disabling device. Operation continuing on 2 devices
SCSI error : <2 0 12 0> return code = 0x8000002
Info fld=0x0, Current sde: sense = f0  b
Raw sense data:0xf0 0x00 0x0b 0x00 0x00 0x00 0x00 0x00
end_request: I/O error, dev sde, sector 11557895
SCSI error : <2 0 12 0> return code = 0x8000002
Info fld=0x0, Current sde: sense = f0  b
Raw sense data:0xf0 0x00 0x0b 0x00 0x00 0x00 0x00 0x00
end_request: I/O error, dev sde, sector 11557903
SCSI error : <2 0 12 0> return code = 0x8000002
Info fld=0x0, Current sde: sense = f0  b
Raw sense data:0xf0 0x00 0x0b 0x00 0x00 0x00 0x00 0x00
end_request: I/O error, dev sde, sector 11557911
SCSI error : <2 0 12 0> return code = 0x8000002
Current sde: sense = 70  b
ASC=47 ASCQ= 0
Raw sense data:0x70 0x00 0x0b 0x00 0x00 0x00 0x00 0x18 0x00 0x00 0x00
               0x00 0x47 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
               0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 
end_request: I/O error, dev sde, sector 11558911
SCSI error : <2 0 12 0> return code = 0x8000002
Current sde: sense = 70  b
ASC=47 ASCQ= 0
Raw sense data:0x70 0x00 0x0b 0x00 0x00 0x00 0x00 0x18 0x00 0x00 0x00
               0x00 0x47 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
               0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 
end_request: I/O error, dev sde, sector 11555871
SCSI error : <2 0 12 0> return code = 0x8000002
Info fld=0x0, Current sde: sense = f0  b
Raw sense data:0xf0 0x00 0x0b 0x00 0x00 0x00 0x00 0x00
end_request: I/O error, dev sde, sector 11555879
SCSI error : <2 0 11 0> return code = 0x8000002
Current sdd: sense = 70  b
ASC=47 ASCQ= 0
Raw sense data:0x70 0x00 0x0b 0x00 0x00 0x00 0x00 0x18 0x00 0x00 0x00
               0x00 0x47 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
               0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 
end_request: I/O error, dev sdd, sector 11556919
raid5: Disk failure on sdd1, disabling device. Operation continuing on 1 devices
SCSI error : <2 0 12 0> return code = 0x8000002
Current sde: sense = 70  b
ASC=47 ASCQ= 0
Raw sense data:0x70 0x00 0x0b 0x00 0x00 0x00 0x00 0x18 0x00 0x00 0x00
               0x00 0x47 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
               0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 
end_request: I/O error, dev sde, sector 11558919
SCSI error : <2 0 12 0> return code = 0x8000002
Info fld=0x0, Current sde: sense = f0  b
Raw sense data:0xf0 0x00 0x0b 0x00 0x00 0x00 0x00 0x00
end_request: I/O error, dev sde, sector 11555887
SCSI error : <2 0 12 0> return code = 0x8000002
Info fld=0x0, Current sde: sense = f0  b
Raw sense data:0xf0 0x00 0x0b 0x00 0x00 0x00 0x00 0x00
end_request: I/O error, dev sde, sector 11558927
SCSI error : <2 0 13 0> return code = 0x8000002
Current sdf: sense = 70  b
ASC=47 ASCQ= 0
Raw sense data:0x70 0x00 0x0b 0x00 0x00 0x00 0x00 0x18 0x00 0x00 0x00
               0x00 0x47 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
               0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 
end_request: I/O error, dev sdf, sector 11559871
raid5: Disk failure on sdf1, disabling device. Operation continuing on 0 devices
SCSI error : <2 0 12 0> return code = 0x8000002
Current sde: sense = 70  b
ASC=47 ASCQ= 0
Raw sense data:0x70 0x00 0x0b 0x00 0x00 0x00 0x00 0x18 0x00 0x00 0x00
               0x00 0x47 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
               0x00 0x00 0x00
0x00 0x00 0x00 0x00 0x00 0x00 0x00  
end_request: I/O error, dev sde, sector 11557919
SCSI error : <2 0 13 0> return code = 0x8000002
Info fld=0x0, Current sdf: sense = f0  b
Raw sense data:0xf0 0x00 0x0b 0x00 0x00 0x00 0x00 0x00

[some more scsi-errors]

md: write_disk_sb failed for device sdf1
md: errors occurred during superblock update, repeating
RAID5 conf printout:
--- rd:3 wd:0 fd:3
disk 0, o:0, dev:sdd1
disk 1, o:0, dev:sde1
disk 2, o:0, dev:sdf1
RAID5 conf printout:
--- rd:3 wd:0 fd:3
disk 0, o:0, dev:sdd1
disk 1, o:0, dev:sde1
RAID5 conf printout:
--- rd:3 wd:0 fd:3
disk 0, o:0, dev:sdd1
disk 1, o:0, dev:sde1
RAID5 conf printout:
--- rd:3 wd:0 fd:3
disk 1, o:0, dev:sde1
Nov 28 15:44:51 server Buffer I/O error on device md5, logical block 2889456
Nov 28 15:44:51 server lost page write due to I/O error on md5
Nov 28 15:44:51 server Buffer I/O error on device md5, logical block 2889464
Nov 28 15:44:51 server lost page write due to I/O error on md5
Nov 28 15:44:51 server Buffer I/O error on device md5, logical block 2889457
Nov 28 15:44:51 server lost page write due to I/O error on md5
Nov 28 15:44:51 server Buffer I/O error on device md5, logical block 2889465
Nov 28 15:44:51 server lost page write due to I/O error on md5
Nov 28 15:44:51 server Buffer I/O error on device md5, logical block 2889458
Nov 28 15:44:51 server lost page write due to I/O error on md5
Nov 28 15:44:51 server Buffer I/O error on device md5, logical block 2889466
Nov 28 15:44:51 server lost page write due to I/O error on md5

[some thousand of these last messages]
=================== END Paste from kern.log ===================


 Timo


