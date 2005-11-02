Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751575AbVKBLBE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751575AbVKBLBE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 06:01:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751577AbVKBLBE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 06:01:04 -0500
Received: from ns.dynamicweb.hu ([195.228.155.139]:25238 "EHLO dynamicweb.hu")
	by vger.kernel.org with ESMTP id S1751575AbVKBLBB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 06:01:01 -0500
Message-ID: <027b01c5df9d$81f53f00$0400a8c0@dcccs>
From: "JaniD++" <djani22@dynamicweb.hu>
To: <linux-kernel@vger.kernel.org>
Subject: IDE HDD fail?
Date: Wed, 2 Nov 2005 12:06:39 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello list,

This happened 2nd times.

At this point, the problem is reproducable. (until i power down the server)

I have one IDE-HDD, that looks like everything is normal (no error message
at all), but when i write to the disk (eg fdisk), ALL DATA IS LOST!

This problem is generated to me about 1-1.5TB data loss on my 8TB system
(4x2TB disk nodes), 2 times!

This time i didnt shutdown the server, because the problem is visible now.
I dont know, what is wrong exactly, but i have few tips:

- the HDD itself  (the first time i have replaced the disk, but the original
is working fine too, i don't think)
- the ide adapter (SiI680: chipset revision 2)
- the ide cable (the first time replaced too, i don't think)
- the mainboard (abit IS7-E)
- software i mean one driver

The smartctl is reports no error at all including the drive offline long
self test!

kernel: 2.6.12-rc1

This caused after this command:
hdparm -c 1 -a 0 -M 254 -W 1 -m 16 -u 0 /dev/hdh

Can somebody help me to find the problem source?

Thanks

Janos


only one error message what i can find after hdparm command:
Oct 30 22:31:48 st-0001 sshd(pam_unix)[10610]: session opened for user root
by (uid=0)
Oct 30 22:32:44 st-0001 kernel: hdh: task_no_data_intr: status=0x51 {
DriveReady SeekComplete Error }
Oct 30 22:32:44 st-0001 kernel: hdh: task_no_data_intr: error=0x04 {
DriveStatusError }
Oct 30 22:32:44 st-0001 kernel: ide: failed opcode was: 0xef
Oct 30 22:32:44 st-0001 kernel: hdh: status error: status=0x58 { DriveReady
SeekComplete DataRequest }
Oct 30 22:32:44 st-0001 kernel:
Oct 30 22:32:44 st-0001 kernel: ide: failed opcode was: unknown
Oct 30 22:32:44 st-0001 kernel: hdh: drive not ready for command
Oct 30 22:32:44 st-0001 kernel: hdj: task_no_data_intr: status=0x51 {
DriveReady SeekComplete Error }
Oct 30 22:32:44 st-0001 kernel: hdj: task_no_data_intr: error=0x04 {
DriveStatusError }
Oct 30 22:32:44 st-0001 kernel: ide: failed opcode was: 0xef
Oct 30 22:32:49 st-0001 sshd(pam_unix)[10610]: session closed for user root

About 1 hour after, the concentrator crashed with XFS corruption.

I have reboot the st-0001 (and the concentrator), and tried these commands:

[root@st-0001 root]# fdisk /dev/hdh
Device contains neither a valid DOS partition table, nor Sun, SGI or OSF
disklab
el
Building a new DOS disklabel. Changes will remain in memory only,
until you decide to write them. After that, of course, the previous
content won't be recoverable.


The number of cylinders for this disk is set to 24792.
There is nothing wrong with that, but this is larger than 1024,
and could in certain setups cause problems with:
1) software that runs at boot time (e.g., old versions of LILO)
2) booting and partitioning software from other OSs
   (e.g., DOS FDISK, OS/2 FDISK)
Warning: invalid flag 0x0000 of partition table 4 will be corrected by
w(rite)

Command (m for help): n
Command action
   e   extended
   p   primary partition (1-4)
p
Partition number (1-4): 1
First cylinder (1-24792, default 1):
Using default value 1
Last cylinder or +size or +sizeM or +sizeK (1-24792, default 24792):
Using default value 24792

Command (m for help): p

Disk /dev/hdh: 203.9 GB, 203928109056 bytes
255 heads, 63 sectors/track, 24792 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes

   Device Boot    Start       End    Blocks   Id  System
/dev/hdh1             1     24792 199141708+  83  Linux

Command (m for help): w
The partition table has been altered!

Calling ioctl() to re-read partition table.
Syncing disks.
[root@st-0001 root]# fdisk /dev/hdh
Device contains neither a valid DOS partition table, nor Sun, SGI or OSF
disklab
el
Building a new DOS disklabel. Changes will remain in memory only,
until you decide to write them. After that, of course, the previous
content won't be recoverable.


The number of cylinders for this disk is set to 24792.
There is nothing wrong with that, but this is larger than 1024,
and could in certain setups cause problems with:
1) software that runs at boot time (e.g., old versions of LILO)
2) booting and partitioning software from other OSs
   (e.g., DOS FDISK, OS/2 FDISK)
Warning: invalid flag 0x0000 of partition table 4 will be corrected by
w(rite)

Command (m for help): p

Disk /dev/hdh: 203.9 GB, 203928109056 bytes
255 heads, 63 sectors/track, 24792 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes

   Device Boot    Start       End    Blocks   Id  System

Command (m for help): q
[root@st-0001 root]# smartctl -t long /dev/hdh
... ~1 hour test.....
[root@st-0001 root]# smartctl -a /dev/hdh
smartctl version 5.33 [i686-redhat-linux-gnu] Copyright (C) 2002-4 Bruce
Allen
Home page is http://smartmontools.sourceforge.net/

=== START OF INFORMATION SECTION ===
Device Model:     Maxtor 6B200P0
Serial Number:    B418P48H
Firmware Version: BAH41B70
User Capacity:    203,928,109,056 bytes
Device is:        Not in smartctl database [for details use: -P showall]
ATA Version is:   7
ATA Standard is:  ATA/ATAPI-7 T13 1532D revision 0
Local Time is:    Wed Nov  2 11:52:27 2005 CET
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

=== START OF READ SMART DATA SECTION ===
SMART overall-health self-assessment test result: PASSED

General SMART Values:
Offline data collection status:  (0x80) Offline data collection activity
                                        was never started.
                                        Auto Offline Data Collection:
Enabled.
Self-test execution status:      (   0) The previous self-test routine
completed
                                        without error or no self-test has
ever
                                        been run.
Total time to complete Offline
data collection:                 (1622) seconds.
Offline data collection
capabilities:                    (0x5b) SMART execute Offline immediate.
                                        Auto Offline data collection on/off
support.
                                        Suspend Offline collection upon new
                                        command.
                                        Offline surface scan supported.
                                        Self-test supported.
                                        No Conveyance Self-test supported.
                                        Selective Self-test supported.
SMART capabilities:            (0x0003) Saves SMART data before entering
                                        power-saving mode.
                                        Supports SMART auto save timer.
Error logging capability:        (0x01) Error logging supported.
                                        No General Purpose Logging support.
Short self-test routine
recommended polling time:        (   2) minutes.
Extended self-test routine
recommended polling time:        (  82) minutes.

SMART Attributes Data Structure revision number: 16
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE      UPDATED
WHEN_FAILED RAW_VALUE
  3 Spin_Up_Time            0x0027   206   206   063    Pre-fail
s       -       7270
  4 Start_Stop_Count        0x0032   253   253   000    Old_age
ys       -       37
  5 Reallocated_Sector_Ct   0x0033   253   253   063    Pre-fail
s       -       0
  6 Read_Channel_Margin     0x0001   253   253   100    Pre-fail
ine      -       0
  7 Seek_Error_Rate         0x000a   253   252   000    Old_age
ys       -       0
  8 Seek_Time_Performance   0x0027   252   232   187    Pre-fail
s       -       51510
  9 Power_On_Hours          0x0032   237   237   000    Old_age
ys       -       12521
 10 Spin_Retry_Count        0x002b   253   252   157    Pre-fail
s       -       0
 11 Calibration_Retry_Count 0x002b   253   252   223    Pre-fail
s       -       0
 12 Power_Cycle_Count       0x0032   253   253   000    Old_age
ys       -       85
192 Power-Off_Retract_Count 0x0032   253   253   000    Old_age
ys       -       0
193 Load_Cycle_Count        0x0032   253   253   000    Old_age
ys       -       0
194 Temperature_Celsius     0x0032   032   253   000    Old_age
ys       -       29
195 Hardware_ECC_Recovered  0x000a   253   241   000    Old_age
ys       -       33773
196 Reallocated_Event_Count 0x0008   253   253   000    Old_age
line      -       0
197 Current_Pending_Sector  0x0008   253   253   000    Old_age
line      -       0
198 Offline_Uncorrectable   0x0008   253   253   000    Old_age
line      -       0
199 UDMA_CRC_Error_Count    0x0008   199   199   000    Old_age
line      -       0
200 Multi_Zone_Error_Rate   0x000a   253   252   000    Old_age
ys       -       0
201 Soft_Read_Error_Rate    0x000a   253   252   000    Old_age
ys       -       0
202 TA_Increase_Count       0x000a   253   251   000    Old_age
ys       -       0
203 Run_Out_Cancel          0x000b   253   252   180    Pre-fail
s       -       8
204 Shock_Count_Write_Opern 0x000a   253   252   000    Old_age
ys       -       0
205 Shock_Rate_Write_Opern  0x000a   253   252   000    Old_age
ys       -       0
207 Spin_High_Current       0x002a   253   252   000    Old_age
ys       -       0
208 Spin_Buzz               0x002a   253   252   000    Old_age
ys       -       0
209 Offline_Seek_Performnce 0x0024   234   234   000    Old_age
line      -       237
210 Unknown_Attribute       0x0032   253   252   000    Old_age
ys       -       0
211 Unknown_Attribute       0x0032   253   252   000    Old_age
ys       -       0
212 Unknown_Attribute       0x0032   253   253   000    Old_age
ys       -       0

SMART Error Log Version: 1
No Errors Logged

SMART Self-test log structure revision number 1
Num  Test_Description    Status                  Remaining  LifeTime(hours)
LBA_of_first_error
# 1  Extended offline    Completed without error       00%
9         -

SMART Selective self-test log data structure revision number 1
 SPAN  MIN_LBA  MAX_LBA  CURRENT_TEST_STATUS
    1        0        0  Not_testing
    2        0        0  Not_testing
    3        0        0  Not_testing
    4        0        0  Not_testing
    5        0        0  Not_testing
Selective self-test flags (0x0):
  After scanning selected spans, do NOT read-scan remainder of disk.
If Selective self-test is pending on power-up, resume after 0 minute delay.



