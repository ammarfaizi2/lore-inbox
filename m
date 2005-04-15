Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261988AbVDOW13@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261988AbVDOW13 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 18:27:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261990AbVDOW13
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 18:27:29 -0400
Received: from smtpout.mac.com ([17.250.248.47]:58588 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S261988AbVDOW0r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 18:26:47 -0400
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Transfer-Encoding: 7bit
Message-Id: <8c5d8e66ebfcfe879244a18068544dc3@mac.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
To: LKML kernel <linux-kernel@vger.kernel.org>
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: SCSI opcode 0x80 and 3ware Escalade 7000 ATA RAID
Date: Fri, 15 Apr 2005 18:26:43 -0400
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been getting the following message in syslog on a couple of my 
servers
recently:

> Apr 15 16:41:18 king kernel: scsi: unknown opcode 0x80

I've tracked it down to the SCSI opcode verification patch that went in 
a
while back.  I also determined that the trigger was our smartd/smartctl 
runs,
which execute tests and get status on a regular basis.  Our kernel is 
latest
Debian kernel-image-2.6.8-686-smp, although I've verified identical 
behavior
with a recent kernel.org kernel.

The below strace run generates exactly 8 warnings every time.

On another (unrelated) note, we also get the following messages at the 
rate
at which our Cisco does IPv6 router-announcement broadcasts.  This is on
every kernel that we have, from 2.4 through 2.6.  Is there something 
wrong
with our setup, or is this just a spurious error?  (NOTE: I don't know 
for
sure that our Cisco's set up properly, we're all new at IPv6 here, and 
we're
not actually relying on the advertising yet, so...)

> Apr 15 18:01:27 king kernel: IPv6 addrconf: prefix with wrong length 49

I'll get a packet trace of necessary.

Thanks for your help!

Here's an example smartctl log (Without the console warnings).
> # strace -o smart.trace smartctl /dev/sda -d 3ware,0 -a
> smartctl version 5.32 Copyright (C) 2002-4 Bruce Allen
> Home page is http://smartmontools.sourceforge.net/
>
> === START OF INFORMATION SECTION ===
> Device Model:     Maxtor 6Y200P0
> Serial Number:    Y60PVCZE
> Firmware Version: YAR41BW0
> Device is:        In smartctl database [for details use: -P show]
> ATA Version is:   7
> ATA Standard is:  ATA/ATAPI-7 T13 1532D revision 0
> Local Time is:    Fri Apr 15 17:25:49 2005 EDT
> SMART support is: Available - device has SMART capability.
> SMART support is: Enabled
>
> === START OF READ SMART DATA SECTION ===
> SMART overall-health self-assessment test result: PASSED
>
> General SMART Values:
> Offline data collection status:  (0x82) Offline data collection 
> activity
>                                         was completed without error.
>                                         Auto Offline Data Collection: 
> Enabled.
> Self-test execution status:      (   0) The previous self-test routine 
> completed
>                                         without error or no self-test 
> has ever
>                                         been run.
> Total time to complete Offline
> data collection:                 ( 243) seconds.
> Offline data collection
> capabilities:                    (0x5b) SMART execute Offline 
> immediate.
>                                         Auto Offline data collection 
> on/off support.
>                                         Suspend Offline collection 
> upon new
>                                         command.
>                                         Offline surface scan supported.
>                                         Self-test supported.
>                                         No Conveyance Self-test 
> supported.
>                                         Selective Self-test supported.
> SMART capabilities:            (0x0003) Saves SMART data before 
> entering
>                                         power-saving mode.
>                                         Supports SMART auto save timer.
> Error logging capability:        (0x01) Error logging supported.
>                                         No General Purpose Logging 
> support.
> Short self-test routine
> recommended polling time:        (   2) minutes.
> Extended self-test routine
> recommended polling time:        (  91) minutes.
>
> SMART Attributes Data Structure revision number: 16
> Vendor Specific SMART Attributes with Thresholds:
> ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE      
> UPDATED  WHEN_FAILED RAW_VALUE
>   3 Spin_Up_Time            0x0027   252   252   063    Pre-fail  
> Always       -       5945
>   4 Start_Stop_Count        0x0032   253   253   000    Old_age   
> Always       -       17
>   5 Reallocated_Sector_Ct   0x0033   253   253   063    Pre-fail  
> Always       -       1
>   6 Read_Channel_Margin     0x0001   253   253   100    Pre-fail  
> Offline      -       0
>   7 Seek_Error_Rate         0x000a   253   252   000    Old_age   
> Always       -       0
>   8 Seek_Time_Performance   0x0027   251   248   187    Pre-fail  
> Always       -       47575
>   9 Power_On_Minutes        0x0032   220   220   000    Old_age   
> Always       -       849h+05m
>  10 Spin_Retry_Count        0x002b   252   252   157    Pre-fail  
> Always       -       0
>  11 Calibration_Retry_Count 0x002b   253   252   223    Pre-fail  
> Always       -       0
>  12 Power_Cycle_Count       0x0032   253   253   000    Old_age   
> Always       -       19
> 192 Power-Off_Retract_Count 0x0032   253   253   000    Old_age   
> Always       -       0
> 193 Load_Cycle_Count        0x0032   253   253   000    Old_age   
> Always       -       0
> 194 Temperature_Celsius     0x0032   253   253   000    Old_age   
> Always       -       12
> 195 Hardware_ECC_Recovered  0x000a   253   252   000    Old_age   
> Always       -       5743
> 196 Reallocated_Event_Count 0x0008   253   253   000    Old_age   
> Offline      -       0
> 197 Current_Pending_Sector  0x0008   253   253   000    Old_age   
> Offline      -       0
> 198 Offline_Uncorrectable   0x0008   253   253   000    Old_age   
> Offline      -       0
> 199 UDMA_CRC_Error_Count    0x0008   199   199   000    Old_age   
> Offline      -       0
> 200 Multi_Zone_Error_Rate   0x000a   253   252   000    Old_age   
> Always       -       0
> 201 Soft_Read_Error_Rate    0x000a   253   251   000    Old_age   
> Always       -       5
> 202 TA_Increase_Count       0x000a   253   252   000    Old_age   
> Always       -       0
> 203 Run_Out_Cancel          0x000b   253   252   180    Pre-fail  
> Always       -       0
> 204 Shock_Count_Write_Opern 0x000a   253   252   000    Old_age   
> Always       -       0
> 205 Shock_Rate_Write_Opern  0x000a   253   252   000    Old_age   
> Always       -       0
> 207 Spin_High_Current       0x002a   252   252   000    Old_age   
> Always       -       0
> 208 Spin_Buzz               0x002a   252   252   000    Old_age   
> Always       -       0
> 209 Offline_Seek_Performnce 0x0024   196   191   000    Old_age   
> Offline      -       0
>  99 Unknown_Attribute       0x0004   253   253   000    Old_age   
> Offline      -       0
> 100 Unknown_Attribute       0x0004   253   253   000    Old_age   
> Offline      -       0
> 101 Unknown_Attribute       0x0004   253   253   000    Old_age   
> Offline      -       0
>
> SMART Error Log Version: 1
> ATA Error Count: 1
>         CR = Command Register [HEX]
>         FR = Features Register [HEX]
>         SC = Sector Count Register [HEX]
>         SN = Sector Number Register [HEX]
>         CL = Cylinder Low Register [HEX]
>         CH = Cylinder High Register [HEX]
>         DH = Device/Head Register [HEX]
>         DC = Device Command Register [HEX]
>         ER = Error register [HEX]
>         ST = Status register [HEX]
> Powered_Up_Time is measured from power on, and printed as
> DDd+hh:mm:SS.sss where DD=days, hh=hours, mm=minutes,
> SS=sec, and sss=millisec. It "wraps" after 49.710 days.
>
> Error 1 occurred at disk power-on lifetime: 4990 hours (207 days + 22 
> hours)
>   When the command that caused the error occurred, the device was in 
> an unknown state.
>
>   After command completion occurred, registers were:
>   ER ST SC SN CL CH DH
>   -- -- -- -- -- -- --
>   40 51 03 bb bc 0c e0  Error: UNC 3 sectors at LBA = 0x000cbcbb = 
> 834747
>
>   Commands leading to the command that caused the error were:
>   CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
>   -- -- -- -- -- -- -- --  ----------------  --------------------
>   25 00 08 bb bc 0c e0 00  23d+08:28:01.392  READ DMA EXT
>   25 00 10 83 bc 0c e0 00  23d+08:28:01.392  READ DMA EXT
>   25 00 08 3b bc 0c e0 00  23d+08:28:01.392  READ DMA EXT
>   25 00 08 33 bc 0c e0 00  23d+08:28:01.392  READ DMA EXT
>   25 00 08 13 bc 0c e0 00  23d+08:28:01.392  READ DMA EXT
>
> SMART Self-test log structure revision number 1
> Num  Test_Description    Status                  Remaining  
> LifeTime(hours)  LBA_of_first_error
> # 1  Short offline       Completed without error       00%     11020   
>       -
> # 2  Short offline       Completed without error       00%     10997   
>       -
> # 3  Short offline       Completed without error       00%     10975   
>       -
> # 4  Short offline       Completed without error       00%     10953   
>       -
> # 5  Short offline       Completed without error       00%     10930   
>       -
> # 6  Extended offline    Completed without error       00%     10909   
>       -
> # 7  Short offline       Completed without error       00%     10885   
>       -
> # 8  Short offline       Completed without error       00%     10863   
>       -
> # 9  Short offline       Completed without error       00%     10841   
>       -
> #10  Short offline       Completed without error       00%     10818   
>       -
> #11  Short offline       Completed without error       00%     10796   
>       -
> #12  Short offline       Completed without error       00%     10774   
>       -
> #13  Extended offline    Completed without error       00%     10754   
>       -
> #14  Short offline       Completed without error       00%     10730   
>       -
> #15  Short offline       Completed without error       00%     10707   
>       -
> #16  Short offline       Completed without error       00%     10685   
>       -
> #17  Short offline       Completed without error       00%     10663   
>       -
> #18  Short offline       Completed without error       00%     10640   
>       -
> #19  Short offline       Completed without error       00%     10618   
>       -
> #20  Extended offline    Completed without error       00%     10597   
>       -
> #21  Short offline       Completed without error       00%     10573   
>       -
>
> SMART Selective self-test log data structure revision number 1
>  SPAN  MIN_LBA  MAX_LBA  CURRENT_TEST_STATUS
>     1        0        0  Not_testing
>     2        0        0  Not_testing
>     3        0        0  Not_testing
>     4        0        0  Not_testing
>     5        0        0  Not_testing
> Selective self-test flags (0x0):
>   After scanning selected spans, do NOT read-scan remainder of disk.
> If Selective self-test is pending on power-up, resume after 0 minute 
> delay.

> # cat smartctl.trace
> execve("/usr/sbin/smartctl", ["smartctl", "/dev/sda", "-d", "3ware,0", 
> "-a"], [/* 19 vars */]) = 0
> uname({sys="Linux", node="king", ...})  = 0
> brk(0)                                  = 0x807d000
> old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, 
> -1, 0) = 0x40017000
> access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or 
> directory)
> open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or 
> directory)
> open("/etc/ld.so.cache", O_RDONLY)      = 3
> fstat64(3, {st_mode=S_IFREG|0644, st_size=23579, ...}) = 0
> old_mmap(NULL, 23579, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40018000
> close(3)                                = 0
> access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or 
> directory)
> open("/lib/tls/libc.so.6", O_RDONLY)    = 3
> read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\360Y\1"..., 
> 512) = 512
> fstat64(3, {st_mode=S_IFREG|0644, st_size=1253924, ...}) = 0
> old_mmap(NULL, 1260140, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 
> 0x4001e000
> old_mmap(0x40147000, 32768, PROT_READ|PROT_WRITE, 
> MAP_PRIVATE|MAP_FIXED, 3, 0x129000) = 0x40147000
> old_mmap(0x4014f000, 10860, PROT_READ|PROT_WRITE, 
> MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x4014f000
> close(3)                                = 0
> old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, 
> -1, 0) = 0x40152000
> set_thread_area({entry_number:-1 -> 6, base_addr:0x401522a0, 
> limit:1048575, seg_32bit:1, contents:0, read_exec_only:0, 
> limit_in_pages:1, seg_not_present:0, useable:1}) = 0
> munmap(0x40018000, 23579)               = 0
> brk(0)                                  = 0x807d000
> brk(0x809e000)                          = 0x809e000
> brk(0)                                  = 0x809e000
> fstat64(1, {st_mode=S_IFREG|0644, st_size=0, ...}) = 0
> mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 
> 0) = 0x40018000
> write(1, "smartctl version 5.32 Copyright "..., 55) = 55
> write(1, "Home page is http://smartmontool"..., 52) = 52
> open("/dev/sda", O_RDONLY|O_NONBLOCK)   = 3
> ioctl(3, FIBMAP, 0xbfffe290)            = 0
> write(1, "=== START OF INFORMATION SECTION"..., 37) = 37
> write(1, "Device Model:     ", 18)      = 18
> write(1, "Maxtor 6Y200P0\n", 15)        = 15
> write(1, "Serial Number:    ", 18)      = 18
> write(1, "Y60PVCZE\n", 9)               = 9
> write(1, "Firmware Version: ", 18)      = 18
> write(1, "YAR41BW0\n", 9)               = 9
> write(1, "Device is:        In smartctl da"..., 66) = 66
> write(1, "ATA Version is:   7\n", 20)   = 20
> write(1, "ATA Standard is:  ATA/ATAPI-7 T1"..., 51) = 51
> time(NULL)                              = 1113600349
> open("/usr/share/zoneinfo/GMT", O_RDONLY) = 4
> fstat64(4, {st_mode=S_IFREG|0644, st_size=56, ...}) = 0
> mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 
> 0) = 0x40019000
> read(4, "TZif\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\1\0\0\0\1\0"..., 
> 4096) = 56
> close(4)                                = 0
> munmap(0x40019000, 4096)                = 0
> open("/etc/localtime", O_RDONLY)        = 4
> fstat64(4, {st_mode=S_IFREG|0644, st_size=1267, ...}) = 0
> mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 
> 0) = 0x40019000
> read(4, "TZif\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\4\0\0\0\4\0"..., 
> 4096) = 1267
> close(4)                                = 0
> munmap(0x40019000, 4096)                = 0
> write(1, "Local Time is:    Fri Apr 15 17:"..., 47) = 47
> write(1, "SMART support is: Available - de"..., 59) = 59
> write(1, "SMART support is: Enabled\n", 26) = 26
> write(1, "\n", 1)                       = 1
> ioctl(3, FIBMAP, 0xbfffe2a0)            = 0
> ioctl(3, FIBMAP, 0xbfffe2a0)            = 0
> ioctl(3, FIBMAP, 0xbfffe2a0)            = 0
> ioctl(3, FIBMAP, 0xbfffe2a0)            = 0
> write(1, "=== START OF READ SMART DATA SEC"..., 41) = 41
> write(1, "SMART overall-health self-assess"..., 57) = 57
> write(1, "\n", 1)                       = 1
> write(1, "General SMART Values:\n", 22) = 22
> write(1, "Offline data collection status: "..., 40) = 40
> write(1, "Offline data collection activity"..., 67) = 67
> write(1, "\t\t\t\t\tAuto Offline Data Collectio"..., 44) = 44
> write(1, "Self-test execution status:     "..., 33) = 33
> write(1, "(   0)\tThe previous self-test ro"..., 53) = 53
> write(1, "without error or no self-test ha"..., 55) = 55
> write(1, "Total time to complete Offline \n", 32) = 32
> write(1, "data collection: \t\t ( 243) secon"..., 36) = 36
> write(1, "Offline data collection\n", 24) = 24
> write(1, "capabilities: \t\t\t (0x5b) ", 25) = 25
> write(1, "SMART execute Offline immediate."..., 33) = 33
> write(1, "\t\t\t\t\tAuto Offline data collectio"..., 50) = 50
> write(1, "\t\t\t\t\tSuspend Offline collection "..., 55) = 55
> write(1, "\t\t\t\t\tOffline surface scan suppor"..., 37) = 37
> write(1, "\t\t\t\t\tSelf-test supported.\n", 26) = 26
> write(1, "\t\t\t\t\tNo Conveyance Self-test sup"..., 40) = 40
> write(1, "\t\t\t\t\tSelective Self-test support"..., 36) = 36
> write(1, "SMART capabilities:            ", 31) = 31
> write(1, "(0x0003)\t", 9)               = 9
> write(1, "Saves SMART data before entering"..., 57) = 57
> write(1, "\t\t\t\t\tSupports SMART auto save ti"..., 37) = 37
> write(1, "Error logging capability:       ", 32) = 32
> write(1, " (0x01)\tError logging supported."..., 33) = 33
> write(1, "\t\t\t\t\tNo General Purpose Logging "..., 41) = 41
> write(1, "Short self-test routine \n", 25) = 25
> write(1, "recommended polling time: \t (   "..., 44) = 44
> write(1, "Extended self-test routine\n", 27) = 27
> write(1, "recommended polling time: \t (  9"..., 44) = 44
> write(1, "\n", 1)                       = 1
> write(1, "SMART Attributes Data Structure "..., 52) = 52
> write(1, "Vendor Specific SMART Attributes"..., 50) = 50
> write(1, "ID# ATTRIBUTE_NAME          FLAG"..., 97) = 97
> write(1, "  3 Spin_Up_Time            ", 28) = 28
> write(1, "0x0027   252   252   063    Pre-"..., 59) = 59
> write(1, "5945\n", 5)                   = 5
> write(1, "  4 Start_Stop_Count        ", 28) = 28
> write(1, "0x0032   253   253   000    Old_"..., 59) = 59
> write(1, "17\n", 3)                     = 3
> write(1, "  5 Reallocated_Sector_Ct   ", 28) = 28
> write(1, "0x0033   253   253   063    Pre-"..., 59) = 59
> write(1, "1\n", 2)                      = 2
> write(1, "  6 Read_Channel_Margin     ", 28) = 28
> write(1, "0x0001   253   253   100    Pre-"..., 59) = 59
> write(1, "0\n", 2)                      = 2
> write(1, "  7 Seek_Error_Rate         ", 28) = 28
> write(1, "0x000a   253   252   000    Old_"..., 59) = 59
> write(1, "0\n", 2)                      = 2
> write(1, "  8 Seek_Time_Performance   ", 28) = 28
> write(1, "0x0027   251   248   187    Pre-"..., 59) = 59
> write(1, "47575\n", 6)                  = 6
> write(1, "  9 Power_On_Minutes        ", 28) = 28
> write(1, "0x0032   220   220   000    Old_"..., 59) = 59
> write(1, "849h+05m\n", 9)               = 9
> write(1, " 10 Spin_Retry_Count        ", 28) = 28
> write(1, "0x002b   252   252   157    Pre-"..., 59) = 59
> write(1, "0\n", 2)                      = 2
> write(1, " 11 Calibration_Retry_Count ", 28) = 28
> write(1, "0x002b   253   252   223    Pre-"..., 59) = 59
> write(1, "0\n", 2)                      = 2
> write(1, " 12 Power_Cycle_Count       ", 28) = 28
> write(1, "0x0032   253   253   000    Old_"..., 59) = 59
> write(1, "19\n", 3)                     = 3
> write(1, "192 Power-Off_Retract_Count ", 28) = 28
> write(1, "0x0032   253   253   000    Old_"..., 59) = 59
> write(1, "0\n", 2)                      = 2
> write(1, "193 Load_Cycle_Count        ", 28) = 28
> write(1, "0x0032   253   253   000    Old_"..., 59) = 59
> write(1, "0\n", 2)                      = 2
> write(1, "194 Temperature_Celsius     ", 28) = 28
> write(1, "0x0032   253   253   000    Old_"..., 59) = 59
> write(1, "12\n", 3)                     = 3
> write(1, "195 Hardware_ECC_Recovered  ", 28) = 28
> write(1, "0x000a   253   252   000    Old_"..., 59) = 59
> write(1, "5743\n", 5)                   = 5
> write(1, "196 Reallocated_Event_Count ", 28) = 28
> write(1, "0x0008   253   253   000    Old_"..., 59) = 59
> write(1, "0\n", 2)                      = 2
> write(1, "197 Current_Pending_Sector  ", 28) = 28
> write(1, "0x0008   253   253   000    Old_"..., 59) = 59
> write(1, "0\n", 2)                      = 2
> write(1, "198 Offline_Uncorrectable   ", 28) = 28
> write(1, "0x0008   253   253   000    Old_"..., 59) = 59
> write(1, "0\n", 2)                      = 2
> write(1, "199 UDMA_CRC_Error_Count    ", 28) = 28
> write(1, "0x0008   199   199   000    Old_"..., 59) = 59
> write(1, "0\n", 2)                      = 2
> write(1, "200 Multi_Zone_Error_Rate   ", 28) = 28
> write(1, "0x000a   253   252   000    Old_"..., 59) = 59
> write(1, "0\n", 2)                      = 2
> write(1, "201 Soft_Read_Error_Rate    ", 28) = 28
> write(1, "0x000a   253   251   000    Old_"..., 59) = 59
> write(1, "5\n", 2)                      = 2
> write(1, "202 TA_Increase_Count       ", 28) = 28
> write(1, "0x000a   253   252   000    Old_"..., 59) = 59
> write(1, "0\n", 2)                      = 2
> write(1, "203 Run_Out_Cancel          ", 28) = 28
> write(1, "0x000b   253   252   180    Pre-"..., 59) = 59
> write(1, "0\n", 2)                      = 2
> write(1, "204 Shock_Count_Write_Opern ", 28) = 28
> write(1, "0x000a   253   252   000    Old_"..., 59) = 59
> write(1, "0\n", 2)                      = 2
> write(1, "205 Shock_Rate_Write_Opern  ", 28) = 28
> write(1, "0x000a   253   252   000    Old_"..., 59) = 59
> write(1, "0\n", 2)                      = 2
> write(1, "207 Spin_High_Current       ", 28) = 28
> write(1, "0x002a   252   252   000    Old_"..., 59) = 59
> write(1, "0\n", 2)                      = 2
> write(1, "208 Spin_Buzz               ", 28) = 28
> write(1, "0x002a   252   252   000    Old_"..., 59) = 59
> write(1, "0\n", 2)                      = 2
> write(1, "209 Offline_Seek_Performnce ", 28) = 28
> write(1, "0x0024   196   191   000    Old_"..., 59) = 59
> write(1, "0\n", 2)                      = 2
> write(1, " 99 Unknown_Attribute       ", 28) = 28
> write(1, "0x0004   253   253   000    Old_"..., 59) = 59
> write(1, "0\n", 2)                      = 2
> write(1, "100 Unknown_Attribute       ", 28) = 28
> write(1, "0x0004   253   253   000    Old_"..., 59) = 59
> write(1, "0\n", 2)                      = 2
> write(1, "101 Unknown_Attribute       ", 28) = 28
> write(1, "0x0004   253   253   000    Old_"..., 59) = 59
> write(1, "0\n", 2)                      = 2
> write(1, "\n", 1)                       = 1
> ioctl(3, FIBMAP, 0xbfffe290)            = 0
> write(1, "SMART Error Log Version: 1\n", 27) = 27
> write(1, "ATA Error Count: 1\n", 19)    = 19
> write(1, "\tCR = Command Register [HEX]\n\tFR"..., 490) = 490
> write(1, "Error 1 occurred at disk power-o"..., 77) = 77
> write(1, "  When the command that caused t"..., 88) = 88
> write(1, "  After command completion occur"..., 121) = 121
> write(1, "  Error: UNC 3 sectors at LBA = "..., 51) = 51
> write(1, "\n\n", 2)                     = 2
> write(1, "  Commands leading to the comman"..., 194) = 194
> write(1, "  25 00 08 bb bc 0c e0 00  23d+0"..., 58) = 58
> write(1, "  25 00 10 83 bc 0c e0 00  23d+0"..., 58) = 58
> write(1, "  25 00 08 3b bc 0c e0 00  23d+0"..., 58) = 58
> write(1, "  25 00 08 33 bc 0c e0 00  23d+0"..., 58) = 58
> write(1, "  25 00 08 13 bc 0c e0 00  23d+0"..., 58) = 58
> write(1, "\n", 1)                       = 1
> ioctl(3, FIBMAP, 0xbfffe2a0)            = 0
> write(1, "SMART Self-test log structure re"..., 48) = 48
> write(1, "Num  Test_Description    Status "..., 96) = 96
> write(1, "# 1  Short offline       Complet"..., 79) = 79
> write(1, "# 2  Short offline       Complet"..., 79) = 79
> write(1, "# 3  Short offline       Complet"..., 79) = 79
> write(1, "# 4  Short offline       Complet"..., 79) = 79
> write(1, "# 5  Short offline       Complet"..., 79) = 79
> write(1, "# 6  Extended offline    Complet"..., 79) = 79
> write(1, "# 7  Short offline       Complet"..., 79) = 79
> write(1, "# 8  Short offline       Complet"..., 79) = 79
> write(1, "# 9  Short offline       Complet"..., 79) = 79
> write(1, "#10  Short offline       Complet"..., 79) = 79
> write(1, "#11  Short offline       Complet"..., 79) = 79
> write(1, "#12  Short offline       Complet"..., 79) = 79
> write(1, "#13  Extended offline    Complet"..., 79) = 79
> write(1, "#14  Short offline       Complet"..., 79) = 79
> write(1, "#15  Short offline       Complet"..., 79) = 79
> write(1, "#16  Short offline       Complet"..., 79) = 79
> write(1, "#17  Short offline       Complet"..., 79) = 79
> write(1, "#18  Short offline       Complet"..., 79) = 79
> write(1, "#19  Short offline       Complet"..., 79) = 79
> write(1, "#20  Extended offline    Complet"..., 79) = 79
> write(1, "#21  Short offline       Complet"..., 79) = 79
> write(1, "\n", 1)                       = 1
> ioctl(3, FIBMAP, 0xbfffe290)            = 0
> write(1, "SMART Selective self-test log da"..., 63) = 63
> write(1, " SPAN  MIN_LBA  MAX_LBA  CURRENT"..., 45) = 45
> write(1, "    1        0        0  Not_tes"..., 37) = 37
> write(1, "    2        0        0  Not_tes"..., 37) = 37
> write(1, "    3        0        0  Not_tes"..., 37) = 37
> write(1, "    4        0        0  Not_tes"..., 37) = 37
> write(1, "    5        0        0  Not_tes"..., 37) = 37
> write(1, "Selective self-test flags (0x0):"..., 33) = 33
> write(1, "  After scanning selected spans,"..., 69) = 69
> write(1, "If Selective self-test is pendin"..., 76) = 76
> write(1, "\n", 1)                       = 1
> munmap(0x40018000, 4096)                = 0
> exit_group(64)                          = ?


Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------

