Return-Path: <linux-kernel-owner+w=401wt.eu-S1751385AbXAUT0y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751385AbXAUT0y (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 14:26:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbXAUT0y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 14:26:54 -0500
Received: from aa013msr.fastwebnet.it ([85.18.95.73]:41471 "EHLO
	aa013msr.fastwebnet.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751385AbXAUT0x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 14:26:53 -0500
Date: Sun, 21 Jan 2007 20:25:52 +0100
From: Paolo Ornati <ornati@fastwebnet.it>
To: Robert Hancock <hancockr@shaw.ca>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       =?ISO-8859-15?B?Qmr2cm4=?= Steinbrink <B.Steinbrink@gmx.de>,
       Jens Axboe <jens.axboe@oracle.com>, Jeff Garzik <jeff@garzik.org>,
       Tejun Heo <htejun@gmail.com>
Subject: Re: SATA exceptions triggered by XFS (since 2.6.18)
Message-ID: <20070121202552.14cc29fe@localhost>
In-Reply-To: <45B3A392.6050609@shaw.ca>
References: <20070121152932.6dc1d9fb@localhost>
	<20070121174023.68402ade@localhost>
	<45B3A392.6050609@shaw.ca>
X-Mailer: Sylpheed-Claws 2.4.0 (GTK+ 2.10.6; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Jan 2007 11:32:02 -0600
Robert Hancock <hancockr@shaw.ca> wrote:

> It looks like what you're getting is an actual NCQ write timing out. 
> That makes the bisect result not very interesting since obviously it 
> wouldn't have issued any NCQ writes before NCQ support was
> implemented. Seeing as how it's also an entirely different driver I
> imagine it's a different problem than what I've been looking at.
> 
> Maybe that drive just has some issues with NCQ? I would be surprised
> at that with a Seagate though..

I don't know. It's a two years old ST380817AS.


# smartctl -a -d ata /dev/sda

smartctl version 5.36 [x86_64-pc-linux-gnu] Copyright (C) 2002-6 Bruce Allen
Home page is http://smartmontools.sourceforge.net/

=== START OF INFORMATION SECTION ===
Model Family:     Seagate Barracuda 7200.7 and 7200.7 Plus family
Device Model:     ST380817AS
Serial Number:    4MR08EK8
Firmware Version: 3.42
User Capacity:    80,026,361,856 bytes
Device is:        In smartctl database [for details use: -P show]
ATA Version is:   6
ATA Standard is:  ATA/ATAPI-6 T13 1410D revision 2
Local Time is:    Sun Jan 21 20:15:40 2007 CET
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

=== START OF READ SMART DATA SECTION ===
SMART overall-health self-assessment test result: PASSED

General SMART Values:
Offline data collection status:  (0x82)	Offline data collection activity
					was completed without error.
					Auto Offline Data Collection: Enabled.
Self-test execution status:      (   0)	The previous self-test routine completed
					without error or no self-test has ever 
					been run.
Total time to complete Offline 
data collection: 		 ( 430) seconds.
Offline data collection
capabilities: 			 (0x5b) SMART execute Offline immediate.
					Auto Offline data collection on/off support.
					Suspend Offline collection upon new
					command.
					Offline surface scan supported.
					Self-test supported.
					No Conveyance Self-test supported.
					Selective Self-test supported.
SMART capabilities:            (0x0003)	Saves SMART data before entering
					power-saving mode.
					Supports SMART auto save timer.
Error logging capability:        (0x01)	Error logging supported.
					No General Purpose Logging support.
Short self-test routine 
recommended polling time: 	 (   1) minutes.
Extended self-test routine
recommended polling time: 	 (  47) minutes.

SMART Attributes Data Structure revision number: 10
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE      UPDATED  WHEN_FAILED RAW_VALUE
  1 Raw_Read_Error_Rate     0x000f   059   049   006    Pre-fail  Always       -       215927244
  3 Spin_Up_Time            0x0003   098   098   000    Pre-fail  Always       -       0
  4 Start_Stop_Count        0x0032   098   098   020    Old_age   Always       -       2182
  5 Reallocated_Sector_Ct   0x0033   100   100   036    Pre-fail  Always       -       0
  7 Seek_Error_Rate         0x000f   083   060   030    Pre-fail  Always       -       204305750
  9 Power_On_Hours          0x0032   097   097   000    Old_age   Always       -       3494
 10 Spin_Retry_Count        0x0013   100   100   097    Pre-fail  Always       -       0
 12 Power_Cycle_Count       0x0032   098   098   020    Old_age   Always       -       2541
194 Temperature_Celsius     0x0022   024   040   000    Old_age   Always       -       24 (Lifetime Min/Max 0/15)
195 Hardware_ECC_Recovered  0x001a   059   049   000    Old_age   Always       -       215927244
197 Current_Pending_Sector  0x0012   100   100   000    Old_age   Always       -       1
198 Offline_Uncorrectable   0x0010   100   100   000    Old_age   Offline      -       1
199 UDMA_CRC_Error_Count    0x003e   200   200   000    Old_age   Always       -       0
200 Multi_Zone_Error_Rate   0x0000   100   253   000    Old_age   Offline      -       0
202 TA_Increase_Count       0x0032   100   253   000    Old_age   Always       -       0

SMART Error Log Version: 1
ATA Error Count: 12 (device log contains only the most recent five errors)
	CR = Command Register [HEX]
	FR = Features Register [HEX]
	SC = Sector Count Register [HEX]
	SN = Sector Number Register [HEX]
	CL = Cylinder Low Register [HEX]
	CH = Cylinder High Register [HEX]
	DH = Device/Head Register [HEX]
	DC = Device Command Register [HEX]
	ER = Error register [HEX]
	ST = Status register [HEX]
Powered_Up_Time is measured from power on, and printed as
DDd+hh:mm:SS.sss where DD=days, hh=hours, mm=minutes,
SS=sec, and sss=millisec. It "wraps" after 49.710 days.

Error 12 occurred at disk power-on lifetime: 2516 hours (104 days + 20 hours)
  When the command that caused the error occurred, the device was active or idle.

  After command completion occurred, registers were:
  ER ST SC SN CL CH DH
  -- -- -- -- -- -- --
  40 51 0d 5b 9d 34 e1  Error: UNC 13 sectors at LBA = 0x01349d5b = 20225371

  Commands leading to the command that caused the error were:
  CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
  -- -- -- -- -- -- -- --  ----------------  --------------------
  c8 00 00 4e 9d 34 e1 00      00:03:03.851  READ DMA
  c8 00 00 4e 9d 34 e1 00      00:03:03.848  READ DMA
  c8 00 00 4e 9d 34 e1 00      00:03:03.846  READ DMA
  c8 00 00 4e 9d 34 e1 00      00:03:03.843  READ DMA
  c8 00 00 4e 9d 34 e1 00      00:03:03.839  READ DMA

Error 11 occurred at disk power-on lifetime: 2516 hours (104 days + 20 hours)
  When the command that caused the error occurred, the device was active or idle.

  After command completion occurred, registers were:
  ER ST SC SN CL CH DH
  -- -- -- -- -- -- --
  40 51 0d 5b 9d 34 e1  Error: UNC 13 sectors at LBA = 0x01349d5b = 20225371

  Commands leading to the command that caused the error were:
  CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
  -- -- -- -- -- -- -- --  ----------------  --------------------
  c8 00 00 4e 9d 34 e1 00      00:03:03.851  READ DMA
  c8 00 00 4e 9d 34 e1 00      00:03:03.848  READ DMA
  c8 00 00 4e 9d 34 e1 00      00:03:03.846  READ DMA
  c8 00 00 4e 9d 34 e1 00      00:03:03.843  READ DMA
  c8 00 00 4e 9d 34 e1 00      00:03:03.839  READ DMA

Error 10 occurred at disk power-on lifetime: 2516 hours (104 days + 20 hours)
  When the command that caused the error occurred, the device was active or idle.

  After command completion occurred, registers were:
  ER ST SC SN CL CH DH
  -- -- -- -- -- -- --
  40 51 0d 5b 9d 34 e1  Error: UNC 13 sectors at LBA = 0x01349d5b = 20225371

  Commands leading to the command that caused the error were:
  CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
  -- -- -- -- -- -- -- --  ----------------  --------------------
  c8 00 00 4e 9d 34 e1 00      00:03:03.851  READ DMA
  c8 00 00 4e 9d 34 e1 00      00:03:03.848  READ DMA
  c8 00 00 4e 9d 34 e1 00      00:03:03.846  READ DMA
  c8 00 00 4e 9d 34 e1 00      00:03:03.843  READ DMA
  c8 00 00 16 9c 34 e1 00      00:03:03.839  READ DMA

Error 9 occurred at disk power-on lifetime: 2516 hours (104 days + 20 hours)
  When the command that caused the error occurred, the device was active or idle.

  After command completion occurred, registers were:
  ER ST SC SN CL CH DH
  -- -- -- -- -- -- --
  40 51 0d 5b 9d 34 e1  Error: UNC 13 sectors at LBA = 0x01349d5b = 20225371

  Commands leading to the command that caused the error were:
  CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
  -- -- -- -- -- -- -- --  ----------------  --------------------
  c8 00 00 4e 9d 34 e1 00      00:03:03.851  READ DMA
  c8 00 00 4e 9d 34 e1 00      00:03:03.848  READ DMA
  c8 00 00 4e 9d 34 e1 00      00:03:03.846  READ DMA
  c8 00 00 16 9c 34 e1 00      00:03:03.843  READ DMA
  c8 00 00 0e 9b 34 e1 00      00:03:03.839  READ DMA

Error 8 occurred at disk power-on lifetime: 2516 hours (104 days + 20 hours)
  When the command that caused the error occurred, the device was active or idle.

  After command completion occurred, registers were:
  ER ST SC SN CL CH DH
  -- -- -- -- -- -- --
  40 51 0d 5b 9d 34 e1  Error: UNC 13 sectors at LBA = 0x01349d5b = 20225371

  Commands leading to the command that caused the error were:
  CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
  -- -- -- -- -- -- -- --  ----------------  --------------------
  c8 00 00 4e 9d 34 e1 00      00:03:03.851  READ DMA
  c8 00 00 4e 9d 34 e1 00      00:03:03.848  READ DMA
  c8 00 00 16 9c 34 e1 00      00:03:03.846  READ DMA
  c8 00 00 0e 9b 34 e1 00      00:03:03.843  READ DMA
  c8 00 00 8e 99 34 e1 00      00:03:03.839  READ DMA

SMART Self-test log structure revision number 1
No self-tests have been logged.  [To run self-tests, use: smartctl -t]


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



-- 
	Paolo Ornati
	Linux 2.6.20-rc5 on x86_64
