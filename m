Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266777AbTAZJvh>; Sun, 26 Jan 2003 04:51:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266792AbTAZJvg>; Sun, 26 Jan 2003 04:51:36 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:52745
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S266777AbTAZJvd>; Sun, 26 Jan 2003 04:51:33 -0500
Date: Sun, 26 Jan 2003 01:42:35 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Manish Lachwani <manish@Zambeel.com>
cc: Manish Lachwani <m_lachwani@yahoo.com>,
       Bryan Andersen <bryan@bogonomicon.net>, linux-kernel@vger.kernel.org
Subject: RE: FW: PDC202XX DMA loss in 2.4.21-pre3-ac4
In-Reply-To: <233C89823A37714D95B1A891DE3BCE5202AB1D12@xch-b.win.zambeel.com>
Message-ID: <Pine.LNX.4.10.10301260125510.1744-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Manish,

So you come back now as "Zambeel", is this to impress me?
Or has Zambeel modified "MY" driver and is shipping the driver with out
the source code?  Since you are using "smartsuite-2.1", it is not designed
to submit 48-bit commands.

Well do you know what a "General Purpose Log" is ?
This is where the 48-bit logging features are stored.
See during one of the 6 annual meetings each year, the commitee debated
the issue of how to deal with 48-bit logs.  Given there was new class of
logs created for AV Streaming, we elected to use those and preserve as
much of the expected behavor in the legacy logs.

So if the error happened with a 28-bit DMA Read then the full log would be
present in the 28-bit logs, but the error happend with a 48-bit DMA Read,
and the result is stuffed into a 48-bit general purpose log.

You are using a 48-bit drive and issuing 28-bit Smart commands; therefore,
you can not extract the useful data being sought.  

Remind me not to deploy Zambeel products to any of my customers.

Yeah "smartctl" does not work, but reading the correct 48-bit logs does.

All I stated was you are using the wrong tool to extract the needed
information.

Regards,

Andre Hedrick
LAD Storage Consulting Group


On Sun, 26 Jan 2003, Manish Lachwani wrote:

> Yes, and I agree that SMART can be enabled by the BIOS. However, if SMART is
> not enabled, then "smartctl -a /dev/hdX" wont return any values for the
> SMART attributes ...
> 
> Thanks
> Manish
> 
> -----Original Message-----
> From: Andre Hedrick [mailto:andre@linux-ide.org]
> Sent: Sunday, January 26, 2003 12:49 AM
> To: Manish Lachwani
> Cc: Bryan Andersen; linux-kernel@vger.kernel.org
> Subject: Re: FW: PDC202XX DMA loss in 2.4.21-pre3-ac4
> 
> 
> 
> Smart can be enabled by the BIOS, but the BIOS does not issue diagnostic
> tests operations.
> 
> > General Smart Values:
> > Off-line data collection status: (0x00) Offline data collection activity
> was
> >                                          never started
> 
> was never started --
> 
> > Self-test execution status:      (   0) The previous self-test routine
> completed
> >                                          without error or no self-test has
> ever
> >                                          been run
> 
> Was never executed, "after" the vendor cleared the state before shipping.
> 
> They can clear the RO log space that can not be gotten to w/o VUO and
> passcodes.
> 
> So show me the sector form the logs.
> You can't!
> 
> WIN_READDMA_EXT == 0x25
> 
> >   08   00   80   aa   4f   8a    e0   25     458636
> 
> You only have the lower 24-bits
> 
> 0x??????8a4faa
> 
> This requires another tool, as the original "smart from sff-8035" is
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
> > I dont think so. Without SMART data collection being
> > enabled, it wont give out the any SMART data at all.
> > How, did the SMART data show:
> > 
> > Vendor Specific SMART Attributes with Thresholds:
> > Revision Number: 16
> > Attribute                    Flag     Value Worst
> > Threshold Raw Value
> > (  3)Spin Up Time            0x0027   252   252   063 
> >      0
> > (  4)Start Stop Count        0x0032   253   253   000 
> >      0
> > (  5)Reallocated Sector Ct   0x0033   253   253   063 
> >      0
> > (  6)Read Channel Margin     0x0001   253   253   100 
> >      0
> > (  7)Seek Error Rate         0x000a   253   252   000 
> >      0
> > (  8)Seek Time Preformance   0x0027   244   244   187 
> >      36736
> > (  9)Power On Hours          0x0032   253   253   000 
> >      4341
> > ( 10)Spin Retry Count        0x002b   252   252   223 
> >      0
> > ( 11)Calibration Retry Count 0x002b   252   252   223 
> >      0
> > ( 12)Power Cycle Count       0x0032   253   253   000 
> >      43
> > (192)Power-Off Retract Count 0x0032   253   253   000 
> >      0
> > (193)Load Cycle Count        0x0032   253   253   000 
> >      0
> > (194)Temperature             0x0032   253   253   000 
> >      0
> > (195)Hardware ECC Recovered  0x000a   253   252   000 
> >      221
> > (196)Reallocated Event Count 0x0008   253   253   000 
> >      0
> > (197)Current Pending Sector  0x0008   253   253   000 
> >      0
> > (198)Offline Uncorrectable   0x0008   253   253   000 
> >      0
> > (199)UDMA CRC Error Count    0x0008   199   199   000 
> >      0
> > (200)Unknown Attribute       0x000a   253   252   000 
> >      0
> > (201)Unknown Attribute       0x000a   253   252   000 
> >      0
> > (202)Unknown Attribute       0x000a   253   252   000 
> >      0
> > (203)Unknown Attribute       0x000b   253   252   180 
> >      0
> > (204)Unknown Attribute       0x000a   253   252   000 
> >      0
> > (205)Unknown Attribute       0x000a   253   252   000 
> >      0
> > (207)Unknown Attribute       0x002a   252   252   000 
> >      0
> > (208)Unknown Attribute       0x002a   252   252   000 
> >      0
> > (209)Unknown Attribute       0x0024   253   253   000 
> >      0
> > ( 99)Unknown Attribute       0x0004   253   253   000 
> >      0
> > (100)Unknown Attribute       0x0004   253   253   000 
> >      0
> > (101)Unknown Attribute       0x0004   253   253   000 
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
> > DCR   FR   SC   SN   CL   SH   D/H   CR   Timestamp
> >   08   00   80   aa   4f   8a    e0   25     458636
> >   08   d0   01   00   4f   c2    e0   b0     459147
> >   08   d1   01   01   4f   c2    e0   b0     459147
> >   08   d0   01   00   4f   c2    e0   b0     459148
> >   08   d1   01   01   4f   c2    e0   b0     459148
> >   00   04   01   0b   4f   c2    e0   51     279972
> > 
> > You can retrieve the sector# ...
> > 
> > Thanks
> > Manish
> > 
> > --- Andre Hedrick <andre@linux-ide.org> wrote:
> > > On Sat, 25 Jan 2003, Manish Lachwani wrote:
> > > 
> > > > The "Hardware ECC Recovered" indicates the number
> > > of
> > > > ECC errors corrected in the drive. Do one thing.
> > > Try
> > > > to swap the drive with the drive on another ATA
> > > cable.
> > > > So, swap /dev/hde with /dev/hda (or whatever)
> > > > physically and check if the error follows the
> > > drive or
> > > > the ATA cable. 
> > > > 
> > > > If it follows the drive, you may have to replace
> > > the
> > > > drive. Additionally, from the SMART error log #5:
> > > > 
> > > > 00   04   01   0b   4f   c2    e0   51     279972
> > > 
> > > NO!
> > >        command aborted
> > >             amount to transfer == 1 sector
> > >                  have to dig through notes to decode
> > > ...
> > >                       lcyl smart passcode
> > >                            hcyl smart passcode
> > >                                  primary device
> > >                                      
> > > ready_seek_error
> > > 
> > > 
> > > It barfed the command ...
> > > 
> > > try -e first
> > > 
> > > Cheers,
> > > 
> > > Andre Hedrick
> > > LAD Storage Consulting Group
> > > 
> > > 
> > > 
> > 
> > 
> > __________________________________________________
> > Do you Yahoo!?
> > Yahoo! Mail Plus - Powerful. Affordable. Sign up now.
> > http://mailplus.yahoo.com
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


