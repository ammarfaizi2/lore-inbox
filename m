Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751372AbWAWMkE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751372AbWAWMkE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 07:40:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932124AbWAWMkD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 07:40:03 -0500
Received: from aeimail.aei.ca ([206.123.6.84]:18906 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S1751045AbWAWMkA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 07:40:00 -0500
From: Ed Tomlinson <edt@aei.ca>
Organization: me
To: "Barry K. Nathan" <barryn@pobox.com>
Subject: Re: 2.6.16-rc1-mm2
Date: Mon, 23 Jan 2006 07:39:44 -0500
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       reiserfs-dev@namesys.com, jgarzik@pobox.com, linux-scsi@vger.kernel.org
References: <20060120031555.7b6d65b7.akpm@osdl.org> <986ed62e0601211045p4a61a7c2v91d401af86f50d6@mail.gmail.com> <200601211636.24693.edt@aei.ca>
In-Reply-To: <200601211636.24693.edt@aei.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601230739.45525.edt@aei.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Summarizing all this.  There are two problems here.

1. reserifs4 panics when it gets io errors - I remember this was an issue that
needed to be fixed in the R4 code before it moves to mainline...

2. Why does a drive which is fine with 2.6.15-rc5-mm3, return a -5 with 2.6.16-mm3
and above?  Smart reports no problems with the drive hardware.  What has changed 
in the libata/scsi stacks?

Thanks,
Ed Tomlinson

On Saturday 21 January 2006 16:36, Ed Tomlinson wrote:
> On Saturday 21 January 2006 13:45, Barry K. Nathan wrote:
> > On 1/21/06, Ed Tomlinson <edt@aei.ca> wrote:
> > > grover:/var/log# smartctl -i -d ata /dev/sda
> > [snip]
> > > grover:/var/log# smartctl -H -d ata /dev/sda
> > > smartctl version 5.34 [x86_64-unknown-linux-gnu] Copyright (C) 2002-5 Bruce Allen
> > > Home page is http://smartmontools.sourceforge.net/
> > >
> > > === START OF READ SMART DATA SECTION ===
> > > SMART overall-health self-assessment test result: PASSED
> > >
> > > ---
> > >
> > > Hope this helps and that I found the correct places to copy the info.
> > 
> > How about:
> > smartctl -a -d ata /dev/sdagrover:/poola/home/ed# smartctl -a -d ata /dev/sda
> smartctl version 5.34 [x86_64-unknown-linux-gnu] Copyright (C) 2002-5 Bruce Allen
> Home page is http://smartmontools.sourceforge.net/
> 
> === START OF INFORMATION SECTION ===
> Device Model:     Maxtor 6L250S0
> Serial Number:    L50QDF3H
> Firmware Version: BACE1G10
> User Capacity:    251,000,193,024 bytes
> Device is:        Not in smartctl database [for details use: -P showall]
> ATA Version is:   7
> ATA Standard is:  ATA/ATAPI-7 T13 1532D revision 0
> Local Time is:    Sat Jan 21 16:34:26 2006 EST
> SMART support is: Available - device has SMART capability.
> SMART support is: Enabled
> 
> === START OF READ SMART DATA SECTION ===
> SMART overall-health self-assessment test result: PASSED
> 
> General SMART Values:
> Offline data collection status:  (0x80) Offline data collection activity
>                                         was never started.
>                                         Auto Offline Data Collection: Enabled.
> Self-test execution status:      (   0) The previous self-test routine completed
>                                         without error or no self-test has ever
>                                         been run.
> Total time to complete Offline
> data collection:                 (1922) seconds.
> Offline data collection
> capabilities:                    (0x5b) SMART execute Offline immediate.
>                                         Auto Offline data collection on/off support.
>                                         Suspend Offline collection upon new
>                                         command.
>                                         Offline surface scan supported.
>                                         Self-test supported.
>                                         No Conveyance Self-test supported.
>                                         Selective Self-test supported.
> SMART capabilities:            (0x0003) Saves SMART data before entering
>                                         power-saving mode.
>                                         Supports SMART auto save timer.
> Error logging capability:        (0x01) Error logging supported.
>                                         General Purpose Logging supported.
> Short self-test routine
> recommended polling time:        (   2) minutes.
> Extended self-test routine
> recommended polling time:        (  99) minutes.
> 
> SMART Attributes Data Structure revision number: 16
> Vendor Specific SMART Attributes with Thresholds:
> ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE      UPDATED  WHEN_FAILED RAW_VALUE
>   3 Spin_Up_Time            0x0027   252   252   063    Pre-fail  Always       -       571
>   4 Start_Stop_Count        0x0032   253   253   000    Old_age   Always       -       2
>   5 Reallocated_Sector_Ct   0x0033   253   253   063    Pre-fail  Always       -       0
>   6 Read_Channel_Margin     0x0001   253   253   100    Pre-fail  Offline      -       0
>   7 Seek_Error_Rate         0x000a   253   252   000    Old_age   Always       -       0
>   8 Seek_Time_Performance   0x0027   250   240   187    Pre-fail  Always       -       49844
>   9 Power_On_Hours          0x0032   251   251   000    Old_age   Always       -       49644
>  10 Spin_Retry_Count        0x002b   252   252   157    Pre-fail  Always       -       0
>  11 Calibration_Retry_Count 0x002b   252   252   223    Pre-fail  Always       -       0
>  12 Power_Cycle_Count       0x0032   253   253   000    Old_age   Always       -       4
> 192 Power-Off_Retract_Count 0x0032   253   253   000    Old_age   Always       -       0
> 193 Load_Cycle_Count        0x0032   253   253   000    Old_age   Always       -       0
> 194 Temperature_Celsius     0x0032   028   253   000    Old_age   Always       -       29
> 195 Hardware_ECC_Recovered  0x000a   253   252   000    Old_age   Always       -       8656
> 196 Reallocated_Event_Count 0x0008   253   253   000    Old_age   Offline      -       0
> 197 Current_Pending_Sector  0x0008   253   253   000    Old_age   Offline      -       0
> 198 Offline_Uncorrectable   0x0008   253   253   000    Old_age   Offline      -       0
> 199 UDMA_CRC_Error_Count    0x0008   199   199   000    Old_age   Offline      -       0
> 200 Multi_Zone_Error_Rate   0x000a   253   252   000    Old_age   Always       -       0
> 201 Soft_Read_Error_Rate    0x000a   253   252   000    Old_age   Always       -       1
> 202 TA_Increase_Count       0x000a   253   252   000    Old_age   Always       -       0
> 203 Run_Out_Cancel          0x000b   253   252   180    Pre-fail  Always       -       0
> 204 Shock_Count_Write_Opern 0x000a   253   252   000    Old_age   Always       -       0
> 205 Shock_Rate_Write_Opern  0x000a   253   252   000    Old_age   Always       -       0
> 207 Spin_High_Current       0x002a   252   252   000    Old_age   Always       -       0
> 208 Spin_Buzz               0x002a   252   252   000    Old_age   Always       -       0
> 209 Offline_Seek_Performnce 0x0024   242   242   000    Old_age   Offline      -       143
> 210 Unknown_Attribute       0x0032   253   252   000    Old_age   Always       -       0
> 211 Unknown_Attribute       0x0032   253   252   000    Old_age   Always       -       0
> 212 Unknown_Attribute       0x0032   253   252   000    Old_age   Always       -       0
> 
> SMART Error Log Version: 1
> No Errors Logged
> 
> SMART Self-test log structure revision number 1
> No self-tests have been logged.  [To run self-tests, use: smartctl -t]
> 
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
> If Selective self-test is pending on power-up, resume after 0 minute delay.
> 
> 
> > or, if that produces too much output, then at least the following two:
> > smartctl -A -d ata /dev/sda
> > smartctl -l error -d ata /dev/sda
> grover:/poola/home/ed# smartctl -l error -d ata /dev/sda
> smartctl version 5.34 [x86_64-unknown-linux-gnu] Copyright (C) 2002-5 Bruce Allen
> Home page is http://smartmontools.sourceforge.net/
> 
> === START OF READ SMART DATA SECTION ===
> SMART Error Log Version: 1
> No Errors Logged
> 
> 
> > That way we might be able to figure out whether the disk
> > coincidentally started going bad after you updated the kernel.
> 
> I suspect the newer kernel (or kernels) since when I revert to 15-rc5-mm3 all is well.
> 
> Thanks,
> Ed Tomlinson
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
