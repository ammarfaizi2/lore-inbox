Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266721AbTAZHGM>; Sun, 26 Jan 2003 02:06:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266728AbTAZHGM>; Sun, 26 Jan 2003 02:06:12 -0500
Received: from web20509.mail.yahoo.com ([216.136.226.144]:5907 "HELO
	web20509.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S266721AbTAZHGI>; Sun, 26 Jan 2003 02:06:08 -0500
Message-ID: <20030126071524.57299.qmail@web20509.mail.yahoo.com>
Date: Sat, 25 Jan 2003 23:15:24 -0800 (PST)
From: Manish Lachwani <m_lachwani@yahoo.com>
Subject: Re: FW: PDC202XX DMA loss in 2.4.21-pre3-ac4
To: Bryan Andersen <bryan@bogonomicon.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3E33855B.60706@bogonomicon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The "Hardware ECC Recovered" indicates the number of
ECC errors corrected in the drive. Do one thing. Try
to swap the drive with the drive on another ATA cable.
So, swap /dev/hde with /dev/hda (or whatever)
physically and check if the error follows the drive or
the ATA cable. 

If it follows the drive, you may have to replace the
drive. Additionally, from the SMART error log #5:

00   04   01   0b   4f   c2    e0   51     279972

indicates an aborted command (0x04) at the sector
0x0c24f0b. Try to read from that sector doing a "dd"
and see if the dd aborts too. 

If the problem follows the drive, you should then run
a DOS based diagnostic utility (from the Maxtor site)
to determine if there are physical defects on the
drive ...

Thanks
Manish



--- Bryan Andersen <bryan@bogonomicon.net> wrote:
> Manish Lachwani wrote:
>  > 0xd0 indicates that the driver aborted the
> command.
>  > Can you try to get the SMART data from the drive
> using
>  > smartctl?
>  >
>  > use "smartctl -e /dev/hdX" to enable SMART
> collection
>  >
>  > use "smartctl -a /dev/hdX" to collect the SMART
> data
> 
> Ok, so where do I find information on how to decode
> this?
> 
> # smartctl -a /dev/hde
> Device: Maxtor 4G160J8  Supports ATA Version 6
> Drive supports S.M.A.R.T. and is enabled
> Check S.M.A.R.T. Passed.
> 
> General Smart Values:
> Off-line data collection status: (0x00) Offline data
> collection activity was
>                                          never
> started
> 
> Self-test execution status:      (   0) The previous
> self-test routine 
> completed
>                                          without
> error or no self-test 
> has ever
>                                          been run
> 
> Total time to complete off-line
> data collection:                 (  30) Seconds
> 
> Offline data collection
> Capabilities:                    (0x1b)SMART EXECUTE
> OFF-LINE IMMEDIATE
>                                          Automatic
> timer ON/OFF support
>                                          Suspend
> Offline Collection upon new
>                                          command
>                                          Offline
> surface scan supported
>                                          Self-test
> supported
> 
> Smart Capablilities:           (0x0003) Saves SMART
> data before entering
>                                         
> power-saving mode
>                                          Supports
> SMART auto save timer
> 
> Error logging capability:        (0x01) Error
> logging supported
> 
> Short self-test routine
> recommended polling time:        (   2) Minutes
> 
> Extended self-test routine
> recommended polling time:        ( 103) Minutes
> 
> Vendor Specific SMART Attributes with Thresholds:
> Revision Number: 16
> Attribute                    Flag     Value Worst
> Threshold Raw Value
> (  3)Spin Up Time            0x0027   252   252  
> 063       0
> (  4)Start Stop Count        0x0032   253   253  
> 000       0
> (  5)Reallocated Sector Ct   0x0033   253   253  
> 063       0
> (  6)Read Channel Margin     0x0001   253   253  
> 100       0
> (  7)Seek Error Rate         0x000a   253   252  
> 000       0
> (  8)Seek Time Preformance   0x0027   244   244  
> 187       36736
> (  9)Power On Hours          0x0032   253   253  
> 000       4341
> ( 10)Spin Retry Count        0x002b   252   252  
> 223       0
> ( 11)Calibration Retry Count 0x002b   252   252  
> 223       0
> ( 12)Power Cycle Count       0x0032   253   253  
> 000       43
> (192)Power-Off Retract Count 0x0032   253   253  
> 000       0
> (193)Load Cycle Count        0x0032   253   253  
> 000       0
> (194)Temperature             0x0032   253   253  
> 000       0
> (195)Hardware ECC Recovered  0x000a   253   252  
> 000       221
> (196)Reallocated Event Count 0x0008   253   253  
> 000       0
> (197)Current Pending Sector  0x0008   253   253  
> 000       0
> (198)Offline Uncorrectable   0x0008   253   253  
> 000       0
> (199)UDMA CRC Error Count    0x0008   199   199  
> 000       0
> (200)Unknown Attribute       0x000a   253   252  
> 000       0
> (201)Unknown Attribute       0x000a   253   252  
> 000       0
> (202)Unknown Attribute       0x000a   253   252  
> 000       0
> (203)Unknown Attribute       0x000b   253   252  
> 180       0
> (204)Unknown Attribute       0x000a   253   252  
> 000       0
> (205)Unknown Attribute       0x000a   253   252  
> 000       0
> (207)Unknown Attribute       0x002a   252   252  
> 000       0
> (208)Unknown Attribute       0x002a   252   252  
> 000       0
> (209)Unknown Attribute       0x0024   253   253  
> 000       0
> ( 99)Unknown Attribute       0x0004   253   253  
> 000       0
> (100)Unknown Attribute       0x0004   253   253  
> 000       0
> (101)Unknown Attribute       0x0004   253   253  
> 000       0
> SMART Error Log:
> SMART Error Logging Version: 1
> Error Log Data Structure Pointer: 05
> ATA Error Count: 8
> Non-Fatal Count: 0
> 
> Error Log Structure 1:
> DCR   FR   SC   SN   CL   SH   D/H   CR   Timestamp
>   00   db   00   00   4f   c2    00   b0     201
>   00   d8   00   00   4f   c2    00   b0     201
>   00   da   00   00   4f   c2    00   b0     201
>   00   d9   00   00   4f   c2    00   b0     201
>   00   fe   00   00   00   00    00   ef     201
>   00   04   50   42   97   23    00   51     5
> 
> Error Log Structure 2:
> DCR   FR   SC   SN   CL   SH   D/H   CR   Timestamp
>   08   00   80   2a   4e   8a    e0   25     458636
>   08   00   80   aa   4e   8a    e0   25     458636
>   08   00   80   2a   4f   8a    e0   25     458636
>   08   00   80   aa   4f   8a    e0   25     458636
>   08   d0   01   00   4f   c2    e0   b0     459147
>   00   04   01   0b   4f   c2    e0   51     279972
> 
> Error Log Structure 3:
> DCR   FR   SC   SN   CL   SH   D/H   CR   Timestamp
>   08   00   80   aa   4e   8a    e0   25     458636
>   08   00   80   2a   4f   8a    e0   25     458636
>   08   00   80   aa   4f   8a    e0   25     458636
>   08   d0   01   00   4f   c2    e0   b0     459147
>   08   d1   01   01   4f   c2    e0   b0     459147
>   00   04   01   0b   4f   c2    e0   51     279972
> 
> Error Log Structure 4:
> DCR   FR   SC   SN   CL   SH   D/H   CR   Timestamp
>   08   00   80   2a   4f   8a    e0   25     458636
>   08   00   80   aa   4f   8a    e0   25     458636
>   08   d0   01   00   4f   c2    e0   b0     459147
>   08   d1   01   01   4f   c2    e0   b0     459147
>   08   d0   01   00   4f   c2    e0   b0     459148
>   00   04   01   0b   4f   c2    e0   51     279972
> 
> Error Log Structure 5:
> DCR   FR   SC   SN   CL   SH   D/H   CR   Timestamp
>   08   00   80   aa   4f   8a    e0   25     458636
>   08   d0   01   00   4f   c2    e0   b0     459147
>   08   d1   01   01   4f   c2    e0   b0     459147
>   08   d0   01   00   4f   c2    e0   b0     459148
>   08   d1   01   01   4f   c2    e0   b0     459148
>   00   04   01   0b   4f   c2    e0   51     279972
> 
> 
> - Bryan
> 


__________________________________________________
Do you Yahoo!?
Yahoo! Mail Plus - Powerful. Affordable. Sign up now.
http://mailplus.yahoo.com
