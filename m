Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266749AbTAZISX>; Sun, 26 Jan 2003 03:18:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266755AbTAZISX>; Sun, 26 Jan 2003 03:18:23 -0500
Received: from web20514.mail.yahoo.com ([216.136.173.246]:37766 "HELO
	web20514.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S266749AbTAZISV>; Sun, 26 Jan 2003 03:18:21 -0500
Message-ID: <20030126082737.13370.qmail@web20514.mail.yahoo.com>
Date: Sun, 26 Jan 2003 00:27:37 -0800 (PST)
From: Manish Lachwani <m_lachwani@yahoo.com>
Subject: Re: FW: PDC202XX DMA loss in 2.4.21-pre3-ac4
To: Andre Hedrick <andre@linux-ide.org>
Cc: Bryan Andersen <bryan@bogonomicon.net>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10301252349550.1744-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I dont think so. Without SMART data collection being
enabled, it wont give out the any SMART data at all.
How, did the SMART data show:

Vendor Specific SMART Attributes with Thresholds:
Revision Number: 16
Attribute                    Flag     Value Worst
Threshold Raw Value
(  3)Spin Up Time            0x0027   252   252   063 
     0
(  4)Start Stop Count        0x0032   253   253   000 
     0
(  5)Reallocated Sector Ct   0x0033   253   253   063 
     0
(  6)Read Channel Margin     0x0001   253   253   100 
     0
(  7)Seek Error Rate         0x000a   253   252   000 
     0
(  8)Seek Time Preformance   0x0027   244   244   187 
     36736
(  9)Power On Hours          0x0032   253   253   000 
     4341
( 10)Spin Retry Count        0x002b   252   252   223 
     0
( 11)Calibration Retry Count 0x002b   252   252   223 
     0
( 12)Power Cycle Count       0x0032   253   253   000 
     43
(192)Power-Off Retract Count 0x0032   253   253   000 
     0
(193)Load Cycle Count        0x0032   253   253   000 
     0
(194)Temperature             0x0032   253   253   000 
     0
(195)Hardware ECC Recovered  0x000a   253   252   000 
     221
(196)Reallocated Event Count 0x0008   253   253   000 
     0
(197)Current Pending Sector  0x0008   253   253   000 
     0
(198)Offline Uncorrectable   0x0008   253   253   000 
     0
(199)UDMA CRC Error Count    0x0008   199   199   000 
     0
(200)Unknown Attribute       0x000a   253   252   000 
     0
(201)Unknown Attribute       0x000a   253   252   000 
     0
(202)Unknown Attribute       0x000a   253   252   000 
     0
(203)Unknown Attribute       0x000b   253   252   180 
     0
(204)Unknown Attribute       0x000a   253   252   000 
     0
(205)Unknown Attribute       0x000a   253   252   000 
     0
(207)Unknown Attribute       0x002a   252   252   000 
     0
(208)Unknown Attribute       0x002a   252   252   000 
     0
(209)Unknown Attribute       0x0024   253   253   000 
     0
( 99)Unknown Attribute       0x0004   253   253   000 
     0
(100)Unknown Attribute       0x0004   253   253   000 
     0
(101)Unknown Attribute       0x0004   253   253   000 
     0
SMART Error Log:
SMART Error Logging Version: 1
Error Log Data Structure Pointer: 05
ATA Error Count: 8
Non-Fatal Count: 0

Also, the SMART error log, 

Error Log Structure 5:
DCR   FR   SC   SN   CL   SH   D/H   CR   Timestamp
  08   00   80   aa   4f   8a    e0   25     458636
  08   d0   01   00   4f   c2    e0   b0     459147
  08   d1   01   01   4f   c2    e0   b0     459147
  08   d0   01   00   4f   c2    e0   b0     459148
  08   d1   01   01   4f   c2    e0   b0     459148
  00   04   01   0b   4f   c2    e0   51     279972

You can retrieve the sector# ...

Thanks
Manish

--- Andre Hedrick <andre@linux-ide.org> wrote:
> On Sat, 25 Jan 2003, Manish Lachwani wrote:
> 
> > The "Hardware ECC Recovered" indicates the number
> of
> > ECC errors corrected in the drive. Do one thing.
> Try
> > to swap the drive with the drive on another ATA
> cable.
> > So, swap /dev/hde with /dev/hda (or whatever)
> > physically and check if the error follows the
> drive or
> > the ATA cable. 
> > 
> > If it follows the drive, you may have to replace
> the
> > drive. Additionally, from the SMART error log #5:
> > 
> > 00   04   01   0b   4f   c2    e0   51     279972
> 
> NO!
>        command aborted
>             amount to transfer == 1 sector
>                  have to dig through notes to decode
> ...
>                       lcyl smart passcode
>                            hcyl smart passcode
>                                  primary device
>                                      
> ready_seek_error
> 
> 
> It barfed the command ...
> 
> try -e first
> 
> Cheers,
> 
> Andre Hedrick
> LAD Storage Consulting Group
> 
> 
> 


__________________________________________________
Do you Yahoo!?
Yahoo! Mail Plus - Powerful. Affordable. Sign up now.
http://mailplus.yahoo.com
