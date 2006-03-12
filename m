Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751166AbWCLGbI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751166AbWCLGbI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 01:31:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751451AbWCLGbI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 01:31:08 -0500
Received: from smtpout.mac.com ([17.250.248.85]:60352 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1750851AbWCLGbG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 01:31:06 -0500
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Transfer-Encoding: 7bit
Message-Id: <8F526C0E-4BED-427F-8F3E-B9AE9BE66B14@mac.com>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
To: LKML Kernel <linux-kernel@vger.kernel.org>
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: [2.6.15] PDC202XX error: "no DRQ after issuing MULTWRITE_EXT"
Date: Sun, 12 Mar 2006 01:30:46 -0500
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I upgraded my kernel from a Debian linux-image-2.6.12-1-powerpc  
kernel (with a patch to the powermac IDE driver to prevent  
deactivating empty interfaces) to a Debian linux-image-2.6.15-powerpc  
kernel and started getting the following message in the logs.  It  
refers to a Samsung PATA drive attached to the secondary channel on a  
Sonnet Tempo ATA/100.  The card is a rebranded FirmTek UltraTek/100  
which is actually a PDC20268 with a Mac-bootable firmware ROM.

hda: status timeout: status=0xd0 { Busy }
PDC202XX: Secondary channel reset.
hdi: no DRQ after issuing MULTWRITE_EXT
ide4: reset: success

The message seems to occur randomly, and does not coincide with the  
routine SMART testing of the drive (triggered by smartd) or the  
routing SMART status monitoring run from a custom Perl curses  
application.  The output of "smartctl -a /dev/hdi" is attached.  You  
will notice that all diagnostics appear to be perfectly OK, and  
repeated checks of the RAID for internal consistency all indicate  
correctness, so it's not an urgent data-corruption issue, but I  
believe it merits further investigation.

Thanks for your time!

Cheers,
Kyle Moffett

smartctl version 5.34 [powerpc-unknown-linux-gnu] Copyright (C)  
2002-5 Bruce Allen
Home page is http://smartmontools.sourceforge.net/

=== START OF INFORMATION SECTION ===
Device Model:     SAMSUNG SP0822N
Serial Number:    S06QJ10Y946116
Firmware Version: WA100-32
User Capacity:    80,060,424,192 bytes
Device is:        In smartctl database [for details use: -P show]
ATA Version is:   6
ATA Standard is:  ATA/ATAPI-6 T13 1410D revision 1
Local Time is:    Sun Mar 12 00:56:28 2006 EST
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

=== STARRT OF READ SMART DATA SECTION ===
SMART overall-health self-assessment test result: PASSED

General SMART Values:
Offline data collection status:  (0x82) Offline data collection activity
                                         was completed without error.
                                         Auto Offline Data  
Collection: Enabled.
Self-test execution status:      (   0) The previous self-test  
routine completed
                                         without error or no self- 
test has ever
                                         been run.
Total time to complete Offline
data collection:                 (1980) seconds
Offline data collection
capabilities:                    (0x5b) SMART execute Offline immediate.
                                         Auto Offline data collection  
on/off suppport.
                                         Suspend Offline collection  
upon new
                                         command.
                                         Offline surface scan supported.
                                         Self-test supported.
                                         No Conveyance Self-test  
supported.
                                         Selective Self-test supported.
SMART capabilities:            (0x0003) Saves SMART data before entering
                                         power-saving mode.
                                         Supports SMART auto save timer.
Error logging capability:        (0x01) Error logging supported.
                                         No General Purpose Logging  
support.
Short self-test routine
recommended polling time:        (   2) minutes.
Extended self-test routine
recommended polling time:        (  33) minutes.

SMART Attributes Data Structure revision number: 17
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE       
UPDATED  WHEN_FAILED RAW_VALUE
   1 Raw_Read_Error_Rate     0x000f   100   099   051    Pre-fail   
Always       -       0
   3 Spin_Up_Time            0x0007   252   252   011    Pre-fail   
Always       -       0
   4 Start_Stop_Count        0x0032   252   252   000    Old_age    
Always       -       0
   5 Reallocated_Sector_Ct   0x0033   252   252   011    Pre-fail   
Always       -       0
   7 Seek_Error_Rate         0x000f   252   252   051    Pre-fail   
Always       -       0
   8 Seek_Time_Performance   0x0025   092   092   015    Pre-fail   
Offline      -       3730
   9 Power_On_Half_Minutes   0x0032   099   099   000    Old_age    
Always       -       29h+25m
  10 Spin_Retry_Count        0x0033   252   252   051    Pre-fail   
Always       -       0
  11 Calibration_Retry_Count 0x0012   252   252   000    Old_age    
Always       -       0
  12 Power_Cycle_Count       0x0032   252   252   000    Old_age    
Always       -       0
190 Unknown_Attribute       0x0022   142   133   000    Old_age    
Always       -       37
194 Temperature_Celsius     0x0022   145   133   000    Old_age    
Always       -       36
195 Hardware_ECC_Recovered  0x001a   100   100   000    Old_age    
Always       -       0
196 Reallocated_Event_Count 0x0032   252   252   000    Old_age    
Always       -       0
197 Current_Pending_Sector  0x0012   252   252   000    Old_age    
Always       -       0
198 Offline_Uncorrectable   0x0030   252   252   000    Old_age    
Offline      -       0
199 UDMA_CRC_Error_Count    0x003e   199   199   000    Old_age    
Always       -       173
200 Multi_Zone_Error_Rate   0x000a   100   100   000    Old_age    
Always       -       0
201 Soft_Read_Error_Rate    0x000a   100   100   000    Old_age    
Always       -       0

Warning! SMART ATA Error Log Structure error: invalid SMART checksum.
SMART Error Log Version: 1
No Errors Logged

SMART Self-test log structure revision number 0
Warning: ATA Specification requires self-test log structure revision  
number = 1
Num  Test_Description    Status                  Remaining  LifeTime 
(hours)  LBA_of_first_error
# 1  Short offline       Completed without error       00%       
3511         -
# 2  Short offline       Completed without error       00%       
3487         -
# 3  Short offline       Completed without error       00%       
3463         -
# 4  Short offline       Completed without error       00%       
3439         -
# 5  Short offline       Completed without error       00%       
3415         -
# 6  Short offline       Completed without error       00%       
3391         -
# 7  Extended offline    Completed without error       00%       
3367         -
# 8  Short offline       Completed without error       00%       
3343         -
# 9  Short offline       Completed without error       00%       
3319         -
#10  Short offline       Completed without error       00%       
3295         -
#11  Short offline       Completed without error       00%       
3271         -
#12  Short offline       Completed without error       00%       
3247         -
#13  Short offline       Completed without error       00%       
3223         -
#14  Extended offline    Completed without error       00%       
3200         -
#15  Short offline       Completed without error       00%       
3175         -
#16  Short offline       Completed without error       00%       
3151         -
#17  Short offline       Completed without error       00%       
3127         -
#18  Short offline       Completed without error       00%       
3103         -
#19  Short offline       Completed without error       00%       
3080         -
#20  Short offline       Completed without error       00%       
3056         -
#21  Extended offline    Completed without error       00%       
3032         -

SMART Selective Self-Test Log Data Structure Revision Number (0)  
should be 1
SMART Selective self-test log data structure revision number 0
Warning: ATA Specification requires selective self-test log data  
structure revision number = 1
  SPAN         MIN_LBA          MAX_LBA  CURRENT_TESET_STATUS
     1               0                0  Not_testing
     2               0                0  Not_testing
     3 281479271677952                0  Not_testing
     4               0  281479271767952  Not_testing
     5          604800                4  Not_testing
Selective self-test flags (0x0):
   After scanning selected spans, do NOT read-scan remainder of disk.
If Selective self-test is pending on power-up, resume after 0 minute  
delay.

