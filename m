Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288502AbSADFrN>; Fri, 4 Jan 2002 00:47:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288503AbSADFrD>; Fri, 4 Jan 2002 00:47:03 -0500
Received: from web14311.mail.yahoo.com ([216.136.224.61]:19461 "HELO
	web14311.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S288502AbSADFqt>; Fri, 4 Jan 2002 00:46:49 -0500
Message-ID: <20020104054648.77014.qmail@web14311.mail.yahoo.com>
Date: Thu, 3 Jan 2002 21:46:48 -0800 (PST)
From: farmer dude <farmerduderl@yahoo.com>
Subject: dd failure odd sectors, block addressing of 1024 question
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All!

I have a question regarding the use gnufileutils 'dd'
wherein it fails to image completely in certain
circumstances.  I've tossed this around a bit, and so
far the best answer seems to be not a DD problem, but
rather block addressing within the kernel itself
(currently it is 1024bytes???).  Someone has suggested
I post to this list to see a) if this is a known issue
and/or b) what is being done to correct it (say,
changing to 512bytes for example)?

Also, why would *BSD not puke on this same scenario?

PS, I am not subscribed to the list, but lurk on the
archives, so feel free to CC me direct if you can,
grazie.

I've included the discussion below for review.

farmerdude

"The claim actually is that Red Hat Linux Version 7.1
dd (GNU fileutils) 4.0.36 misses the last sector from
a source device that has an odd number of sectors. A
source device may be either a disk drive (e.g.,
/dev/hda or /dev/sdc) or a partition (e.g., /dev/hdb3
or /dev/sda6).
It is no surprise that finding a disk with an odd
number of sectors is hard. The odds are against
finding an IDE (ATA) drive with an odd number of
sectors. Since both the number of heads and cylinders
would need to be odd. However a partition with an odd
number of sectors is easy to create if the number of
heads is odd. Some drives allow selection of the
number of heads (either 15 or 16) by jumper. Some SCSI
disks do have an odd number of sectors, e.g., QUANTUM
ATLAS10K2-TY092J 17938985 or a SEAGATE ST39204LC
17921835 Sectors. A visit to vendor web sites would
likely turn up more.

Here is an extract from three of our test cases. DI-06
is a partition copy of a partition that just happened
to have an odd number of sectors. DI-08 is a copy of a
SCSI disk to an identical model (the selected disk
again just happens to have an odd number of sectors).
DI-09 is a copy to a smaller destination drive that is
odd sized. The last sector is dropped for each case.
The last sector of the destination is not changed from
the contents present before dd is executed.


Test case DI(Linux)-06 copies a partition (entry #9
from the partition table). Note that the partition is
on an IBM-DTLA-307020 ATA disk with an even number of
sectors (40188960), but since the disk has 255 heads
(logically not physically) the partition has an odd
number of sectors (9430155). The last sector was not
copied.
The dd command line was: dd if=/dev/hda3 of=/dev/hdb1
bs=1b

Test case DI(Linux)-08 copies an entire disk to
another disk of the same model. The last sector is not
copied. (QUANTUM ATLAS10K2-TY092J 17938985 sectors)

Test case DI(Linux)-08 copies part of a disk (QUANTUM
ATLAS10K2-TY092J 17938985 sectors) to another disk of
a smaller size (SEAGATE ST39204LC 17921835 Sectors).
dd outputs a message that the destination is to small
but stops the copy one sector short, i.e., dd could
have copied one more sector to the destination drive
but it did not do it. The destination disk has an odd
number of sectors.

Product Name:	Red Hat Linux Version 7.1 dd (GNU
fileutils) 4.0.36	
Test ID:	DI(Linux)-06	
Case Summary:	Copy a LINUX IDE source disk to a LINUX
IDE destination disk and the source contains a LINUX
partition where the source disk is larger than the
destination  	
Tester Name:	JRL	
Test Date:	Thu Aug 30 18:06:47 2001	
PC:	Cadfael	
Disks:	Source: DOS Drive 80 Physical Label F5 Linux
device hda3 Destination: DOS Drive 81 Physical Label
A6 Linux device hdb1 Boot/Image media: Physical Label
CD F5 is an IBM-DTLA-307020 40188960 Sectors, IDE A6
is a WDC WD200BB-00AUA1 39102336 Sectors, IDE CD is a
SEAGATE ST336705LC 71687370 Sectors, SCSI Jaz disk
with Support software, scripts PC DOS 6.3 Boot floppy 
	
Source disk setup:	Dual boot Linux/Windows Me with
EXT2 & Fat16 Disk: F5 N   Start LBA Length    Start
C/H/S End C/H/S   boot Partition type  1 P 000000063
001236942 0000/001/01 0076/254/63 Boot 06 Fat16  2 X
002249100 007181055 0140/000/01 0586/254/63      05
extended  3 S 000000063 000208782 0140/001/01
0152/254/63      83 Linux  4 x 000208845 000144585
0153/000/01 0161/254/63      05 extended  5 S
000000063 000144522 0153/001/01 0161/254/63      06
Fat16  6 x 004450005 000192780 0417/000/01 0428/254/63
     05 extended  7 S 000000063 000192717 0417/001/01
0428/254/63      16 other  9 P 009430155 006152895
0587/000/01 0969/254/63      83 Linux 10 P 039760875
000417690 1023/000/01 1023/254/63      82 Linux swap  

Expected Results:	src compares qualified equal to dst,
src is truncated on dst truncation is logged Source
disk unchanged	
Actual Results:	src compares qualified equal to dst,
src is truncated on dst truncation is logged except
for 1 sector not copied to destination Source disk is
unchanged  	
Log File Highlights:	Sectors Compared 5943987 Sectors
Differ 1 Diffs range:  5943986 Source (6152895) has
208908 more sectors than destination (5943987) Hash
after test: 83A0002816BBF089F8BE33C41C92C3B5A0F42A54
dd: writing /dev/hdb1: No space left on device	


Product Name:	Red Hat Linux Version 7.1 dd (GNU
fileutils) 4.0.36	
Test ID:	DI(Linux)-08	
Case Summary:	Copy a LINUX SCSI source disk to a LINUX
SCSI destination disk where the source disk is the
same size as the destination  	
Disks:	Source: DOS Drive 80 Physical Label E3 Linux
device sda Destination: DOS Drive 81 Physical Label E0
Linux device sdb Boot/Image media: Physical Label AD
E3 is a QUANTUM ATLAS10K2-TY092J 17938985 Sectors,
SCSI E0 is a QUANTUM ATLAS10K2-TY092J 17938985
Sectors, SCSI AD is a Maxtor53073H4 60030432 Sectors,
IDE Jaz disk with Support software, scripts PC DOS 6.3
Boot floppy  	
Source disk setup:	Dual boot Linux/Windows Me with
EXT2 & Fat16 Disk: E3 N   Start LBA Length    Start
C/H/S End C/H/S   boot Partition type  1 P 000000063
001236942 0000/001/01 0076/254/63 Boot 06 Fat16  2 X
002249100 007181055 0140/000/01 0586/254/63      05
extended  3 S 000000063 000208782 0140/001/01
0152/254/63      83 Linux  4 x 000208845 000144585
0153/000/01 0161/254/63      05 extended  5 S
000000063 000144522 0153/001/01 0161/254/63      06
Fat16  6 x 004450005 000192780 0417/000/01 0428/254/63
     05 extended  7 S 000000063 000192717 0417/001/01
0428/254/63      16 other  9 P 009430155 006152895
0587/000/01 0969/254/63      83 Linux 10 P 017510850
000417690 1023/000/01 1023/254/63      82 Linux swap  

Execute:	dd if=/dev/sda of=/dev/sdb bs=1b  	
Expected Results:	src compares equal to dst Source
disk unchanged	
Actual Results:	src compares equal to dst except for 1
sector not copied to destination Source disk is
unchanged  	
Log File Highlights:	Sectors Compared 17938985 Sectors
Differ 1 Diffs range 17938984 	

Product Name:	Red Hat Linux Version 7.1 dd (GNU
fileutils) 4.0.36	
Test ID:	DI(Linux)-09	
Case Summary:	Copy a LINUX SCSI source disk to a LINUX
SCSI destination disk where the source disk is larger
than the destination  	
Disks:	Source: DOS Drive 80 Physical Label E4 Linux
device sda Destination: DOS Drive 81 Physical Label EA
Linux device sdb Boot/Image media: Physical Label AE
E4 is a QUANTUM ATLAS10K2-TY092J 17938985 Sectors,
SCSI EA is a SEAGATE ST39204LC 17921835 Sectors, SCSI
AE is a Maxtor53073H4 60030432 Sectors, IDE Jaz disk
with Support software, scripts PC DOS 6.3 Boot floppy 
	
Source disk setup:	Windows 2000 with NTFS & Fat32
Disk: E4 N   Start LBA Length    Start C/H/S End C/H/S
  boot Partition type  1 P 000000063 006152832
0000/001/01 0382/254/63 Boot 0B Fat32  2 X 008193150
009735390 0510/000/01 1023/254/63      0F extended  4
x 002056320 001237005 0638/000/01 0714/254/63      05
extended  5 S 000000063 001236942 0638/001/01
0714/254/63      07 NTFS  6 x 005349645 001638630
0843/000/01 0944/254/63      05 extended  7 S
000000063 001638567 0843/001/01 0944/254/63      17
other  8 x 008498385 001237005 1023/000/01 1023/254/63
     05 extended  9 S 000000063 001236942 1023/001/01
1023/254/63      1B other  	
Execute:	dd if=/dev/sda of=/dev/sdb bs=1b  	
Expected Results:	src compares qualified equal to dst,
src is truncated on dst truncation is logged Source
disk unchanged	
Actual Results:	src compares qualified equal to dst,
src is truncated on dst truncation is logged except
for 1 sector not copied to destination Source disk is
unchanged  	
Log File Highlights:	Sectors Compared 17921835 Sectors
Differ 1 Diffs range 17921834 Source (17938985) has
17150 more sectors than destination (17921835) dd:
writing /dev/sdb: No space left on device	

1.3	Source of the problem
As some folks have commented, the problem is not in
dd. Looking at the dd source code is a red herring;
the source of the problem is in a software layer under
dd, i.e., kernel or driver. This missing sector issue
has implications beyond dd. For example, compute a md5
message digest with a DOS based tool and compare the
results with md5sum running under Linux. The results
are based on different data (1 more sector is used by
the DOS tool) and yield different values.
1.4	Scope of the dd problem
A simple experiment to check if a unix-like OS sees
all of a disk is to run the following command and note
the results:
dd if=/dev/disk_in_question of=/dev/null bs=1b

For Red Hat Linux Version 7.1 dd (GNU fileutils)
4.0.36 we get the following:
QUANTUM ATLAS10K2-TY092J (17938985):
17938984+0 Records in
17938984+0 Records out
SEAGATE ST39204LC 17921835 Sectors
17921834+0 Records in
17921834+0 Records out

For Mandrake Linux Version 7.2 dd (GNU fileutils)
4.0.p we get the same result:
QUANTUM ATLAS10K2-TY092J (17938985):
17938984+0 Records in
17938984+0 Records out
SEAGATE ST39204LC 17921835 Sectors
17921834+0 Records in
17921834+0 Records out

But for FreeBSD 4.4-Release#0 we get (for the Atlas) 
17938985+0 Records in
17938985+0 Records out
9184760320 bytes transferred in 1094.73 Secs

Bottom line: Linux skips that last sector, but FreeBSD
gets it all.

1.5	Suggested dd problem workarounds
If you see dd miss that last sector use another tool
to either capture the last sector or print the
contents in hex and ASCII.
Use FreeBSD.

Note that if the disk is on a Linux system then that
sector is unlikely to contain any data since it cannot
be used by Linux. If the disk comes from a DOS/WIN
system with FAT filesystems it is most unlikely to be
used in any cluster. In fact it usually would be
outside any partition. I would try to capture that
last sector no matter how unlikely it is to contain
data, just to be complete.
"

__________________________________________________
Do You Yahoo!?
Send your FREE holiday greetings online!
http://greetings.yahoo.com
