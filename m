Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261953AbTJ2JKi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 04:10:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261956AbTJ2JKi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 04:10:38 -0500
Received: from guard.dmz.aa.ap.titech.ac.jp ([131.112.71.131]:37128 "HELO
	guard.dmz.aa.ap.titech.ac.jp") by vger.kernel.org with SMTP
	id S261953AbTJ2JKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 04:10:25 -0500
Date: Wed, 29 Oct 2003 18:10:21 +0900
Subject: A harmless problem  in the IDE driver (linux-2.4.22)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v552)
Cc: adachi@aa.ap.titech.ac.jp
To: linux-kernel@vger.kernel.org
From: =?ISO-2022-JP?B?GyRCQi1OKUFvGyhC?= <adachi@aa.ap.titech.ac.jp>
Content-Transfer-Encoding: 7bit
Message-Id: <B8DC3168-09EF-11D8-83B0-003065E04568@aa.ap.titech.ac.jp>
X-Mailer: Apple Mail (2.552)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dear Developers of Linux kernel,

    *BUG report 2/2*

Several months ago, I ported several recent versions of linux kernel
to a platform ``OpenBlockS 50'', which is a small box hardware
that is made by an Industorial Company ``PlatH'ome'' in Japan.
The CPU that is used in this hardware is Motorola's MPC860T,
which is an embedded version of PowerPC. This hardware has two
Ethernet ports to access network and one serial port to be used
for serial console. It has also an IDE bus interface
inside of it, which can be used to attach one harddisk and
one Compact Flash memory.

My port of recent linux kernels (version 2.4.21, 2.4.22) to this 
hardware
is based on anohter port of linux kernel (version 2.4.13),
which was done about one year ago by a Japanese, Mr. Katsunori Murase
(Home page in Japanese: http://homepage2.nifty.com/murase/).

While I was porting the linux kernel, I found a serious bug
in the linux kernel when it is compiled for MPC860T.
This serious bug is related with the swap management in the virtual 
memory
system. I also found a minor harmless problem about the IDE device 
driver.

Maybe, it is better to report these two problems in separate emails
to help the maintainer to record different problems in different files.
So, I am now writing two emails to report these two problems.


This second email reports the latter minor harmless problem,
which is related to the IDE device driver.


This minor problem is about IDE device driver and is harmless actually
except for printing some error message on console when the system is 
booted.
However, since I want the linux kernel to be most perfect as we can do,
I am writing this email to ask the mainainer to fix this minor problem.

I found this minor problem for linux-2.4.21.
This problem still remains in linux-2.4.22.

The following is the log that appears on the serial console
when OpenBlockS is booted:

Linux version 2.4.22-obs-0.1 (adachi@wisdom2) (gcc version 3.2.2) 
\(\backslash\)
#1 Mon Sep 29 13:30:36 JST 2003
On node 0 totalpages: 4096
zone(0): 4096 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/hda1
RTC Backup utility
Decrementer Frequency = 184320000/60
Calibrating delay loop... 48.94 BogoMIPS
Memory: 14844k available (988k kernel code, 300k data, 48k init, 0k 
highmem)
Dentry cache hash table entries: 2048 (order: 2, 16384 bytes)
Inode cache hash table entries: 1024 (order: 1, 8192 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 4096 (order: 2, 16384 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
LED driver version 1.0.0
Push switch driver v0.01
Starting kswapd
CPM UART driver version 0.03
ttyS00 at 0x0280 is a SMC
ttyS01 at 0x0000 is a SCC
pty: 256 Unix98 ptys configured
eth0: FEC ENET Version 0.2, FEC irq 3, MII irq 10, addr 
00:80:6d:47:17:c5
eth0: Phy @ 0x0, type 78Q2120 (0x0300e54b)
eth1: CPM ENET Version 0.2 on SCC2, 00:80:6d:47:17:c6
RAMDISK driver initialized: 16 RAM disks of 6144K size 1024 blocksize
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 50MHz system bus speed for PIO modes; override with 
idebus=xx
IDE driver for OBS Version 1.2.0
IDE init done
Probing IDE interface ide0...
hda: IBM-DJSA-220, ATA DISK drive
hdb: SanDisk SDCFB-128, CFA DISK drive
ide0 at 0xc2000010-0xc2000017,0xc200200c on irq 8
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 39070080 sectors (20004 MB) w/1874KiB Cache, CHS=38760/16/63
hdb: attached ide-disk driver.
hdb: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error } 
<= (*)
hdb: task_no_data_intr: error=0x04 { DriveStatusError }               
<= (*)
hdb: 250880 sectors (128 MB) w/1KiB Cache, CHS=980/8/32
Partition check:
  hda: hda1 hda2 hda3 hda4
  hdb: [mac] hdb1 hdb2
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 1024 bind 2048)
IPv4 over IPv4 tunneling driver
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 48k init
INIT: version 2.84 booting
...
...

The error message consisting of the two lines marked by the symbol
``<= (*)'' is the harmless minor problem, which is mentioned above.
The error message is generated while a function
idedisk_read_native_max_address() is executed. This function
idedisk_read_native_max_address() is called from a function
init_idedisk_capacity() and calls further another function 
ide_raw_taskfile()
inside the function. Namely, the the sequence of calling functions is
the following:

           init_idedisk_capacity()              in ide-disk.c
      ---> idedisk_read_native_max_address()    in ide-disk.c
      ---> ide_raw_taskfile()                   in ide-taskfile.c

When the function ide_raw_taskfile() is called,
it issues an ATA command, which is specified by the arguments to the 
function,
by writing the ATA command to the ATA command register of an ATA 
controller.

In the above sequence of calling functions, when the function
ide_raw_taskfile() is called from the function
idedisk_read_native_max_address(), the "READ NATIVE MAX ADDRESS" command
(0xF8) is requested to issue to the specified IDE device.

If my understanding is right, the "READ NATIVE MAX ADDRESS" command 
(0xF8)
is an optional command accoring to the ATA standard.
An IDE device may or may not be able to respond to this command.

Actually, the slave IDE device in our hardware OpenBlockS 50 seems to 
have
no ability to respond to the "READ NATIVE MAX ADDRESS" command (0xF8).
This slave device is a Compact Flash disk made by SanDisk.

When this Comact Flash memeory is asked to answer the inquiry made by 
the
"READ NATIVE MAX ADDRESS" command (0xF8), which can not be answered by 
it,
the above error in the boot log is generated.

These functions are in the source file 
linux-2.4.22/drivers/ide/ide-disk.c.
The part of the source code for the function init_ide_disk_capacity()
where the function idedisk_read_native_max_address() is called is
the following:

static void init_idedisk_capacity (ide_drive_t  *drive)
{
         struct hd_driveid *id = drive->id;
         unsigned long capacity = drive->cyl * drive->head * drive->sect;
         unsigned long set_max = idedisk_read_native_max_address(drive); 
   /* Here! */
         unsigned long long capacity_2 = capacity;
         unsigned long long set_max_ext;

         drive->capacity48 = 0;
         drive->select.b.lba = 0;

         (void) idedisk_supports_host_protected_area(drive);   /* Here!! 
*/

         ...
}

It is clear from this part that the function
idedisk_read_native_max_address() is called always if the function
init_idedisk_capacity() is called. This makes the error message
on serial console appear when system is booted if an IDE device cannot
repond to the "READ NATIVE MAX ADDRESS" command (0xF8).

To fix this promlem, the above code needs to be modified so as to call
the function idedisk_read_native_max_address() only when the IDE device
actually has the ability to respond to the "READ NATIVE MAX ADDRESS" 
command
(0xF8).

Optional ATA commands are classified into several classes, which are 
called
feature sets. The "READ NATIVE MAX ADDRESS" command (0xF8) belongs to 
the
"Host Protected Area Feature Set".

It is interesting to see that the check for a given particular IDE 
device
to see whether the IDE device supports "Host Protected Area Feature Set"
or not is performed in the above source code fragment.
At the line maked by the sumbol ``/* Here!! */'', the function
idedisk_supports_host_protected_area() is called. This function performs
the check. If the IDE device supports the "Host Protected Area Feature 
Set",
the function idedisk_supports_host_protected_area() prints a message
``xxx: host protected area => 1'' on serial console. In addition,
the function idedisk_supports_host_protected_area() always returns
an integer flag that represents the result of the check.
The flag is true if and only if the "Host Protected Arear Feature Set" 
is
supported by the IDE device. Unfortunately, the function
idedisk_supports_host_protected_area() is called in the above source 
code
fragment only for the purpose of printing the message if it is 
appropriate
and the returned flag is just disposed by casting the return type of
the function to void. We also note that the function
idedisk_supports_host_protected_area() is called a little bit later than
the function idedisk_read_native_max_address() is called.

Accordingly, it is easy to modify the above code in such a way that
the function idedisk_read_native_max_address() is called only
when the IDE device actually has the ability to respond to the
"READ NATIVE MAX ADDRESS" command (0xF8). For this purpose,
the function idedisk_supports_host_protected_area() needs to be called
before the function idedisk_read_native_max_address() is called.
Then, the integer flag returned from 
idedisk_supports_host_protected_area()
needs to be kept to judge whether the function
idedisk_read_native_max_address() is to be called or not.
The following is the modified code in this way:

diff -rcP linux-2.4.22/drivers/ide/ide-disk.c 
linux-2.4.22-obs-0.1/drivers/ide/i
de-disk.c
*** linux-2.4.22/drivers/ide/ide-disk.c Fri Jun 13 23:51:33 2003
--- linux-2.4.22-obs-0.1/drivers/ide/ide-disk.c Wed Oct  1 01:24:12 2003
***************
*** 1161,1174 ****
   {
         struct hd_driveid *id = drive->id;
         unsigned long capacity = drive->cyl * drive->head * drive->sect;
!       unsigned long set_max = idedisk_read_native_max_address(drive);
         unsigned long long capacity_2 = capacity;
         unsigned long long set_max_ext;

         drive->capacity48 = 0;
         drive->select.b.lba = 0;
-
-       (void) idedisk_supports_host_protected_area(drive);

         if (id->cfs_enable_2 & 0x0400) {
                 capacity_2 = id->lba_capacity_2;
--- 1161,1174 ----
   {
         struct hd_driveid *id = drive->id;
         unsigned long capacity = drive->cyl * drive->head * drive->sect;
!       int flag = idedisk_supports_host_protected_area(drive);
!       unsigned long set_max
!               = (flag ? idedisk_read_native_max_address(drive) : 0);
         unsigned long long capacity_2 = capacity;
         unsigned long long set_max_ext;

         drive->capacity48 = 0;
         drive->select.b.lba = 0;

         if (id->cfs_enable_2 & 0x0400) {
                 capacity_2 = id->lba_capacity_2;

After this fix, the minor error message in the boot log disappears.
I have explained my understanding about this minor problem and its 
possible
fix. Please fix this minor problem by some appropriate way.

Finally, while I was reading the source code for the IDE driver,
I found a typographical error in the source file
linux-2.4.22/drivers/ide/ide-probe.c as

diff -rcP linux-2.4.22/drivers/ide/ide-probe.c 
linux-2.4.22-obs-0.1/drivers/ide/
ide-probe.c
*** linux-2.4.22/drivers/ide/ide-probe.c        Mon Aug 25 20:44:41 2003
--- linux-2.4.22-obs-0.1/drivers/ide/ide-probe.c        Tue Sep 30 
10:42:48 2003
***************
*** 102,108 ****
                 if (id->config == 0x848a) return 1;     /* CompactFlash 
*/
                 if (!strncmp(id->model, "KODAK ATA_FLASH", 15)  /* 
Kodak */
                  || !strncmp(id->model, "Hitachi CV", 10)       /* 
Hitachi */
!                || !strncmp(id->model, "SunDisk SDCFB", 13)    /* 
SunDisk */
                  || !strncmp(id->model, "HAGIWARA HPC", 12)     /* 
Hagiwara */
                  || !strncmp(id->model, "LEXAR ATA_FLASH", 15)  /* 
Lexar */
                  || !strncmp(id->model, "ATA_FLASH", 9))        /* 
Simple Tech *
/
--- 102,108 ----
                 if (id->config == 0x848a) return 1;     /* CompactFlash 
*/
                 if (!strncmp(id->model, "KODAK ATA_FLASH", 15)  /* 
Kodak */
                  || !strncmp(id->model, "Hitachi CV", 10)       /* 
Hitachi */
!                || !strncmp(id->model, "SanDisk SDCFB", 13)    /* 
SanDisk */
                  || !strncmp(id->model, "HAGIWARA HPC", 12)     /* 
Hagiwara */
                  || !strncmp(id->model, "LEXAR ATA_FLASH", 15)  /* 
Lexar */
                  || !strncmp(id->model, "ATA_FLASH", 9))        /* 
Simple Tech *
/

Sincerely yours,

Satoshi Adachi
adachi@aa.ap.titech.ac.jp

Tokyo Institute of Technology
Department of Condensed Matter Physics

P.S. The patch file for the source code of the official linux kernel
to make the kernel be usable on OpenBlockS 50 is stored at the following
address:

    ftp://ftp.aa.ap.titech.ac.jp/
       pub/adachi/OpenBlockS/linux/linux-2.4.22-obs-0.1.patch

This is a patch file for the official linux kernel (version 2.4.22).

