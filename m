Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266761AbTAZJBE>; Sun, 26 Jan 2003 04:01:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266765AbTAZJBE>; Sun, 26 Jan 2003 04:01:04 -0500
Received: from web20502.mail.yahoo.com ([216.136.226.137]:22583 "HELO
	web20502.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S266761AbTAZJA7>; Sun, 26 Jan 2003 04:00:59 -0500
Message-ID: <20030126091015.9046.qmail@web20502.mail.yahoo.com>
Date: Sun, 26 Jan 2003 01:10:15 -0800 (PST)
From: Manish Lachwani <m_lachwani@yahoo.com>
Subject: Re: FW: PDC202XX DMA loss in 2.4.21-pre3-ac4
To: Andre Hedrick <andre@linux-ide.org>
Cc: Bryan Andersen <bryan@bogonomicon.net>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10301260028420.1744-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

his is the help from smartctl:

smartctl version 2.1 - S.M.A.R.T. Control Program
useage: smartctl -[opts] [device]
Read Only Commands:
                a               Show All S.M.A.R.T.
Information (ATA and SCSI)
                g               Show General
S.M.A.R.T. Attributes (ATA Only)
                v               Show Vendor S.M.A.R.T.
Attributes (ATA Only)
                l               Show S.M.A.R.T. Drive
Error Log (ATA Only
                L               Show S.M.A.R.T. Drive
SelfTest Log (ATA Only)
                i               Show S.M.A.R.T. Drive
Info (ATA and SCSI)
                c               Check S.M.A.R.T.
Status (ATA and SCSI)

Enable / Disable Commands:
                e               Enable S.M.A.R.T. data
collection (ATA and SCSI)
                d               Disable S.M.A.R.T.data
collection (ATA and SCSI)
                t               Enable S.M.A.R.T.
Automatic Offline Test (ATA Only)
                T               Disable S.M.A.R.T.
Automatic Offline Test (ATA Only)

Test Commands:
                O               Execute Off-line data
collectioni(ATA Only)
                S               Execute Short Self
Test (ATA Only)
                s               Execute Short Self
Test (Captive Mode) (ATA Only)
                X               Execute Extended Self
Test (ATA Only)
                x               Execute Extended Self
Test (Captive Mode)(ATA Only)
                A               Execute Self Test
Abort (ATA Only)

Off-line data collection has nothing to do with the
SMART data collection. You enable the offline test,
then run the test and collect the offline data. 

I agree with the fact that we have the lower 24 bits.
However, SMART attributes displayed is appropriately
collected from the drive. Look at the sequence below:

bash# ./smartctl -a /dev/hda
Device: ST380021A  Supports ATA Version 5
Drive supports S.M.A.R.T. and is disabled
Use option -e to enable
bash# ./smartctl -e /dev/hda
bash# ./smartctl -a /dev/hda
Device: ST380021A  Supports ATA Version 5
Drive supports S.M.A.R.T. and is enabled
Check S.M.A.R.T. Passed.

General Smart Values:
Off-line data collection status: (0x82) Offline data
collection activity
                                        completed
without error

Self-test execution status:      (   0) The previous
self-test routine completed
                                        without error
or no self-test has ever
                                        been run

Total time to complete off-line
data collection:                 ( 422) Seconds

Offline data collection
Capabilities:                    (0x1b)SMART EXECUTE
OFF-LINE IMMEDIATE
                                        Automatic
timer ON/OFF support
                                        Suspend
Offline Collection upon new
                                        command
                                        Offline
surface scan supported
                                        Self-test
supported

Smart Capablilities:           (0x0003) Saves SMART
data before entering
                                        power-saving
mode
                                        Supports SMART
auto save timer

Error logging capability:        (0x01) Error logging
supported

Short self-test routine
recommended polling time:        (   1) Minutes

Extended self-test routine
recommended polling time:        (  57) Minutes

Vendor Specific SMART Attributes with Thresholds:
Revision Number: 10
Attribute                    Flag     Value Worst
Threshold Raw Value
(  1)Raw Read Error Rate     0x000f   075   070   034 
     92897937
(  3)Spin Up Time            0x0003   070   070   000 
     0
(  4)Start Stop Count        0x0032   100   100   020 
     3
(  5)Reallocated Sector Ct   0x0033   100   100   036 
     0
(  7)Seek Error Rate         0x000f   079   060   030 
     93809829
(  9)Power On Hours          0x0032   096   096   000 
     4158
( 10)Spin Retry Count        0x0013   100   100   097 
     0
( 12)Power Cycle Count       0x0032   100   100   020 
     261
(194)Temperature             0x0022   028   043   000 
     28
(195)Hardware ECC Recovered  0x001a   075   070   000 
     92897937
(197)Current Pending Sector  0x0012   100   100   000 
     0
(198)Offline Uncorrectable   0x0010   100   100   000 
     0
(199)UDMA CRC Error Count    0x003e   200   200   000 
     0
(200)Unknown Attribute       0x0000   100   253   000 
     0
(202)Unknown Attribute       0x0032   100   253   000 
     0
SMART Error Log:
SMART Error Logging Version: 1
No Errors Logged



--- Andre Hedrick <andre@linux-ide.org> wrote:
> 
> Smart can be enabled by the BIOS, but the BIOS does
> not issue diagnostic
> tests operations.
> 
> > General Smart Values:
> > Off-line data collection status: (0x00) Offline
> data collection activity was
> >                                          never
> started
> 
> was never started --
> 
> > Self-test execution status:      (   0) The
> previous self-test routine completed
> >                                          without
> error or no self-test has ever
> >                                          been run
> 
> Was never executed, "after" the vendor cleared the
> state before shipping.
> 
> They can clear the RO log space that can not be
> gotten to w/o VUO and
> passcodes.
> 
> So show me the sector form the logs.
> You can't!
> 
> WIN_READDMA_EXT == 0x25
> 
> >   08   00   80   aa   4f   8a    e0   25    
> 458636
> 
> You only have the lower 24-bits
> 
> 0x??????8a4faa
> 
> This requires another tool, as the original "smart
> from sff-8035" is
> obsolete.
> 
> 
> Cheers,
> 
> Andre Hedrick
> LAD Storage Consulting Group
> 
> On Sun, 26 Jan 2003, Manish Lachwani wrote:
> 
> > I dont think so. Without SMART data collection
> being
> > enabled, it wont give out the any SMART data at
> all.
> > How, did the SMART data show:
> > 
> > Vendor Specific SMART Attributes with Thresholds:
> > Revision Number: 16
> > Attribute                    Flag     Value Worst
> > Threshold Raw Value
> > (  3)Spin Up Time            0x0027   252   252  
> 063 
> >      0
> > (  4)Start Stop Count        0x0032   253   253  
> 000 
> >      0
> > (  5)Reallocated Sector Ct   0x0033   253   253  
> 063 
> >      0
> > (  6)Read Channel Margin     0x0001   253   253  
> 100 
> >      0
> > (  7)Seek Error Rate         0x000a   253   252  
> 000 
> >      0
> > (  8)Seek Time Preformance   0x0027   244   244  
> 187 
> >      36736
> > (  9)Power On Hours          0x0032   253   253  
> 000 
> >      4341
> > ( 10)Spin Retry Count        0x002b   252   252  
> 223 
> >      0
> > ( 11)Calibration Retry Count 0x002b   252   252  
> 223 
> >      0
> > ( 12)Power Cycle Count       0x0032   253   253  
> 000 
> >      43
> > (192)Power-Off Retract Count 0x0032   253   253  
> 000 
> >      0
> > (193)Load Cycle Count        0x0032   253   253  
> 000 
> >      0
> > (194)Temperature             0x0032   253   253  
> 000 
> >      0
> > (195)Hardware ECC Recovered  0x000a   253   252  
> 000 
> >      221
> > (196)Reallocated Event Count 0x0008   253   253  
> 000 
> >      0
> > (197)Current Pending Sector  0x0008   253   253  
> 000 
> >      0
> > (198)Offline Uncorrectable   0x0008   253   253  
> 000 
> >      0
> > (199)UDMA CRC Error Count    0x0008   199   199  
> 000 
> >      0
> > (200)Unknown Attribute       0x000a   253   252  
> 000 
> >      0
> > (201)Unknown Attribute       0x000a   253   252  
> 000 
> >      0
> > (202)Unknown Attribute       0x000a   253   252  
> 000 
> >      0
> > (203)Unknown Attribute       0x000b   253   252  
> 180 
> >      0
> > (204)Unknown Attribute       0x000a   253   252  
> 000 
> >      0
> > (205)Unknown Attribute       0x000a   253   252  
> 000 
> >      0
> > (207)Unknown Attribute       0x002a   252   252  
> 000 
> >      0
> > (208)Unknown Attribute       0x002a   252   252  
> 000 
> >      0
> > (209)Unknown Attribute       0x0024   253   253  
> 000 
> >      0
> > ( 99)Unknown Attribute       0x0004   253   253  
> 000 
> >      0
> > (100)Unknown Attribute       0x0004   253   253  
> 000 
> >      0
> > (101)Unknown Attribute       0x0004   253   253  
> 000 
> >      0
> > SMART Error Log:
> > SMART Error Logging Version: 1
> > Error Log Data Structure Pointer: 05
> > ATA Error Count: 8
> > Non-Fatal Count: 0
> > 
> > Also, the SMART error log, 
> > 
> > Error Log Structure 5:
> > DCR   FR   SC   SN   CL   SH   D/H   CR  
> Timestamp
> >   08   00   80   aa   4f   8a    e0   25    
> 458636
> >   08   d0   01   00   4f   c2    e0   b0    
> 459147
> >   08   d1   01   01   4f   c2    e0   b0    
> 459147
> >   08   d0   01   00   4f   c2    e0   b0    
> 459148
> >   08   d1   01   01   4f   c2    e0   b0    
> 459148
> >   00   04   01   0b   4f   c2    e0   51    
> 279972
> > 
> > You can retrieve the sector# ...
> > 
> > Thanks
> > Manish
> > 
> > --- Andre Hedrick <andre@linux-ide.org> wrote:
> > > On Sat, 25 Jan 2003, Manish Lachwani wrote:
> > > 
> > > > The "Hardware ECC Recovered" indicates the
> number
> > > of
> > > > ECC errors corrected in the drive. Do one
> thing.
> > > Try
> > > > to swap the drive with the drive on another
> ATA
> > > cable.
> > > > So, swap /dev/hde with /dev/hda (or whatever)
> > > > physically and check if the error follows the
> > > drive or
> > > > the ATA cable. 
> > > > 
> > > > If it follows the drive, you may have to
> replace
> > > the
> > > > drive. Additionally, from the SMART error log
> #5:
> 
=== message truncated ===


__________________________________________________
Do you Yahoo!?
Yahoo! Mail Plus - Powerful. Affordable. Sign up now.
http://mailplus.yahoo.com
