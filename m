Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262363AbSKTUMc>; Wed, 20 Nov 2002 15:12:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262371AbSKTUMb>; Wed, 20 Nov 2002 15:12:31 -0500
Received: from imrelay-2.zambeel.com ([209.240.48.8]:17668 "EHLO
	imrelay-2.zambeel.com") by vger.kernel.org with ESMTP
	id <S262363AbSKTUMW>; Wed, 20 Nov 2002 15:12:22 -0500
Message-ID: <233C89823A37714D95B1A891DE3BCE5202AB196E@xch-a.win.zambeel.com>
From: Manish Lachwani <manish@Zambeel.com>
To: "'Steven Timm'" <timm@fnal.gov>, Manish Lachwani <manish@Zambeel.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: AMD 760MPX dma_intr: error=0x40 { UncorrectableError }
Date: Wed, 20 Nov 2002 12:19:11 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

whoops !! sorry abt this

SMART

> > > Error Log Structure 5:
> > > DCR   FR   SC   SN   CL   SH   D/H   CR   Timestamp
> > >  00   00   d8   57   09   ab    f2   c8     40285
> > >  00   00   d0   5f   09   ab    f2   c8     40290
> > >  00   00   c8   67   09   ab    f2   c8     40296
> > >  00   00   c0   6f   09   ab    f2   c8     40301
> > >  00   00   b8   77   09   ab    f2   c8     40306
> > >  00   40   00   7d   09   ab    f2   51     922746
> > > Error condition:  33    Error State:       3
> > > Number of Hours in Drive Life: 1021 (life of the drive in hours)

looking at the latest error log, ECC (0x40) occurred on sector 0x2ab097d.
This equates to 44763517 decimal. Since each sector is 512 bytes, the total
to skip is 22918920704 bytes. Write to this location using dd and the sector
will be remapped ...

Thanks
Manish 

-----Original Message-----
From: Steven Timm [mailto:timm@fnal.gov]
Sent: Wednesday, November 20, 2002 12:01 PM
To: Manish Lachwani
Subject: RE: AMD 760MPX dma_intr: error=0x40 { UncorrectableError }


Manish...the smartctl information was at the end of my previous
E-mail.  It's also still at the end of this one.  If you need other
info, please let me know.

Thanks

Steve Timm


------------------------------------------------------------------
Steven C. Timm (630) 840-8525  timm@fnal.gov  http://home.fnal.gov/~timm/
Fermilab Computing Division/Operating Systems Support
Scientific Computing Support Group--Computing Farms Operations

On Wed, 20 Nov 2002, Manish Lachwani wrote:

> Steve,
>
> Doing dd will fill up the disk with zeros. When there is a bad sector,
> writing to that sector will remap the sector. This is the house keeping
job
> of every drive. Thats why I suggested writing to those sectors. But, you
> cannot write to all the sectors. This is very time consuming. You only
write
> to the bad sector. You can get the bad sector info using smartctl.
>
> So, download smartsuite freeware. Run smartctl on the drive and send me
the
> SMART info. I can explain u the formula to get the bad LBA ...
>
> Thanks
> Manish
>
> -----Original Message-----
> From: Steven Timm [mailto:timm@fnal.gov]
> Sent: Wednesday, November 20, 2002 10:52 AM
> To: Manish Lachwani
> Subject: RE: AMD 760MPX dma_intr: error=0x40 { UncorrectableError }
>
>
> Hi Manish
>
> These errors typically happen with the transport of a huge
> tarball from the network writing it onto the disk,
> or reading it back and pushing it out over the network.
>
> This is the only error episode this machine had to date
> in 1 1/2 months of power-on so far.
>
> Also, in an earlier response to you, I believe I mixed the two
> threads I had going on.  These new machines with 760MPX chipset
> and seagate drives don't have reproducible sector numbers
> when they have sector errors.  The ones with serverworks chipset
> do have reproducible sector numbers.
>
> Also, is the dd if=/dev/zero of=/dev/hda
> equivalent to the "Zero fill" that's done by the hardware
> diagnostics, or not?
>
> Thanks a lot for your help. You have lots of good ideas.
>
>
> Steve Timm
>
>
> Below is output of smart data
>
> [root@fnd0355 /root]# smartctl -a /dev/hdb
> Device: ST380021A  Supports ATA Version 5
> Drive supports S.M.A.R.T. and is enabled
> Check S.M.A.R.T. Passed.
>
> General Smart Values:
> Off-line data collection status: (0x82) Offline data collection activity
>                                         completed without error
>
> Self-test execution status:      (   0) The previous self-test routine
> completed                                        without error or no
> self-test has ever
>                                         been run
>
> Total time to complete off-line
> data collection:                 ( 422) Seconds
>
> Offline data collection
> Capabilities:                    (0x1b)SMART EXECUTE OFF-LINE IMMEDIATE
>                                         Automatic timer ON/OFF support
>                                         Suspend Offline Collection upon
> new
>                                         command
>                                         Offline surface scan supported
>                                         Self-test supported
>
> Smart Capablilities:           (0x0003) Saves SMART data before entering
>                                         power-saving mode
>                                         Supports SMART auto save timer
>
> Error logging capability:        (0x01) Error logging supported
>
> Short self-test routine
> recommended polling time:        (   1) Minutes
>
> Extended self-test routine
> recommended polling time:        (  57) Minutes
>
> Vendor Specific SMART Attributes with Thresholds:
> Revision Number: 10
> Attribute                    Flag     Value Worst Threshold Raw Value
> (  1)Raw Read Error Rate     0x000f   080   076   034       168233406
> (  3)Spin Up Time            0x0003   085   085   000       0
> (  4)Start Stop Count        0x0032   100   100   020       2
> (  5)Reallocated Sector Ct   0x0033   100   100   036       2
> (  7)Seek Error Rate         0x000f   076   072   030       46592133
> (  9)Power On Hours          0x0032   100   100   000       819
> ( 10)Spin Retry Count        0x0013   100   100   097       0
> ( 12)Power Cycle Count       0x0032   100   100   020       4
> (194)Temperature             0x0022   024   049   000       24
> (195)Hardware ECC Recovered  0x001a   080   076   000       168233406
> (197)Current Pending Sector  0x0012   100   100   000       2
> (198)Offline Uncorrectable   0x0010   100   100   000       2
> (199)UDMA CRC Error Count    0x003e   200   200   000       0
> (200)Unknown Attribute       0x0000   100   253   000       0
> (202)Unknown Attribute       0x0032   100   253   000       0
> SMART Error Log:
> SMART Error Logging Version: 1
> Error Log Data Structure Pointer: 05
> ATA Error Count: 20
> Non-Fatal Count: 0
>
> Error Log Structure 1:
> DCR   FR   SC   SN   CL   SH   D/H   CR   Timestamp
>  00   00   a8   87   48   1c    f2   c8     34312
>  00   00   a0   8f   48   1c    f2   c8     34317
>  00   00   98   97   48   1c    f2   c8     34323
>  00   00   90   9f   48   1c    f2   c8     34328
>  00   00   88   a7   48   1c    f2   c8     34333
>  00   40   00   bc   48   1c    f2   51     922746
> Error condition:  33    Error State:       3
> Number of Hours in Drive Life: 777 (life of the drive in hours)
>
> Error Log Structure 2:
> DCR   FR   SC   SN   CL   SH   D/H   CR   Timestamp
>  00   00   a0   8f   48   1c    f2   c8     34317
>  00   00   98   97   48   1c    f2   c8     34323
>  00   00   90   9f   48   1c    f2   c8     34328
>  00   00   88   a7   48   1c    f2   c8     34333
>  00   00   80   af   48   1c    f2   c8     34339
>  00   40   00   bc   48   1c    f2   51     922746
> Error condition:  33    Error State:       3
> Number of Hours in Drive Life: 777 (life of the drive in hours)
>
> Error Log Structure 3:
> DCR   FR   SC   SN   CL   SH   D/H   CR   Timestamp
>  00   00   98   97   48   1c    f2   c8     34323
>  00   00   90   9f   48   1c    f2   c8     34328
>  00   00   88   a7   48   1c    f2   c8     34333
>  00   00   80   af   48   1c    f2   c8     34339
>  00   00   78   b7   48   1c    f2   c8     34344
>  00   40   00   bc   48   1c    f2   51     922746
> Error condition:  33    Error State:       3
> Number of Hours in Drive Life: 777 (life of the drive in hours)
>
> Error Log Structure 4:
> DCR   FR   SC   SN   CL   SH   D/H   CR   Timestamp
>  00   00   08   97   48   1c    f2   c8     34428
>  00   00   08   9f   48   1c    f2   c8     34428
>  00   00   08   a7   48   1c    f2   c8     34428
>  00   00   08   af   48   1c    f2   c8     34428
>  00   00   08   b7   48   1c    f2   c8     34428
>  00   40   00   bc   48   1c    f2   51     922746
> Error condition:  33    Error State:       3
> Number of Hours in Drive Life: 777 (life of the drive in hours)
>
> Error Log Structure 5:
> DCR   FR   SC   SN   CL   SH   D/H   CR   Timestamp
>  00   00   08   af   48   1c    f2   c8     34428
>  00   00   08   b7   48   1c    f2   c8     34428
>  00   00   f8   cf   a9   22    f2   c8     34433
>  00   00   08   c7   aa   22    f2   c8     34433
>  00   00   08   b7   48   1c    f2   c8     34433
>  00   40   00   bc   48   1c    f2   51     922746
> Error condition:  33    Error State:       3
> Number of Hours in Drive Life: 777 (life of the drive in hours)
>
> ---------------------------------------------------------------------
>
> And here's the error log we have on this drive so far.
>
> Nov 18 12:07:35 fnd0355 kernel: hdb: dma_intr: status=0x51 { DriveReady
> SeekComplete Error }
> Nov 18 12:07:46 fnd0355 kernel: hdb: dma_intr: error=0x10 {
> SectorIdNotFound },
> LBAsect=35408060, sector=1880272
> Nov 18 12:07:46 fnd0355 kernel: hdb: dma_intr: status=0x51 { DriveReady
> SeekComplete Error }
> Nov 18 12:07:46 fnd0355 kernel: hdb: dma_intr: error=0x40 {
> UncorrectableError }, LBAsect=35408060, sector=1880272
> Nov 18 12:07:46 fnd0355 kernel: end_request: I/O error, dev 03:42 (hdb),
> sector
> 1880272
> Nov 18 12:07:46 fnd0355 kernel: hdb: dma_intr: status=0x51 { DriveReady
> SeekComplete Error }
> Nov 18 12:07:46 fnd0355 kernel: hdb: dma_intr: error=0x40 {
> UncorrectableError }, LBAsect=35408060, sector=1880280
> Nov 18 12:07:46 fnd0355 kernel: end_request: I/O error, dev 03:42 (hdb),
> sector
> 1880280
> Nov 18 12:07:46 fnd0355 kernel: hdb: dma_intr: status=0x51 { DriveReady
> SeekComplete Error }
> Nov 18 12:07:46 fnd0355 kernel: hdb: dma_intr: error=0x40 {
> UncorrectableError
> Nov 18 12:07:46 fnd0355 kernel: hdb: dma_intr: error=0x40 {
> UncorrectableError }, LBAsect=35408060, sector=1880288
> Nov 18 12:07:46 fnd0355 kernel: end_request: I/O error, dev 03:42 (hdb),
> sector
> 1880288
> Nov 18 12:07:51 fnd0355 kernel: hdb: dma_intr: status=0x51 { DriveReady
> SeekComplete Error }
> Nov 18 12:07:51 fnd0355 kernel: hdb: dma_intr: error=0x40 {
> UncorrectableError }, LBAsect=35408060, sector=1880296
> Nov 18 12:07:51 fnd0355 kernel: end_request: I/O error, dev 03:42 (hdb),
> sector
> 1880296
> Nov 18 12:07:56 fnd0355 kernel: hdb: dma_intr: status=0x51 { DriveReady
> SeekComplete Error }
> Nov 18 12:07:56 fnd0355 kernel: hdb: dma_intr: error=0x40 {
> UncorrectableError }, LBAsect=35408060, sector=1880304
> Nov 18 12:07:56 fnd0355 kernel: end_request: I/O error, dev 03:42 (hdb),
> sector
> 1880304
> Nov 18 12:08:02 fnd0355 kernel: hdb: dma_intr: status=0x51 { DriveReady
> SeekComplete Error }
> Nov 18 12:08:07 fnd0355 kernel: hdb: dma_intr: error=0x40 {
> UncorrectableError }, LBAsect=35408060, sector=1880312
> Nov 18 12:08:12 fnd0355 kernel: end_request: I/O error, dev 03:42 (hdb),
> sector
> 1880312
> Nov 18 12:08:17 fnd0355 kernel: hdb: dma_intr: status=0x51 { DriveReady
> SeekComp
>  lete Error }
> Nov 18 12:08:17 fnd0355 kernel: hdb: dma_intr: error=0x40 {
> UncorrectableError }, LBAsect=35408060, sector=1880320
> Nov 18 12:08:23 fnd0355 kernel: end_request: I/O error, dev 03:42 (hdb),
> sector
> 1880320
> Nov 18 12:08:23 fnd0355 kernel: hdb: dma_intr: status=0x51 { DriveReady
> SeekComplete Error }
> Nov 18 12:08:28 fnd0355 kernel: hdb: dma_intr: error=0x40 {
> UncorrectableError }, LBAsect=35408060, sector=1880328
> Nov 18 12:08:39 fnd0355 kernel: end_request: I/O error, dev 03:42 (hdb),
> sector
> 1880328
> Nov 18 12:08:44 fnd0355 kernel: hdb: dma_intr: status=0x51 { DriveReady
> SeekComplete Error }
> Nov 18 12:08:49 fnd0355 kernel: hdb: dma_intr: error=0x40 {
> UncorrectableError }, LBAsect=35408060, sector=1880336
> Nov 18 12:08:54 fnd0355 kernel: end_request: I/O error, dev 03:42 (hdb),
> sector
> 1880336
> Nov 18 12:09:00 fnd0355 kernel: hdb: dma_intr: status=0x51 { DriveReady
> SeekComplete Error }
> Nov 18 12:09:00 fnd0355 kernel: hdb: dma_intr: error=0x40 {
> UncorrectableError }, LBAsect=35408060, sector=1880344
> Nov 18 12:09:00 fnd0355 kernel: end_request: I/O error, dev 03:42 (hdb),
> sector
> Nov 18 12:09:00 fnd0355 kernel: end_request: I/O error, dev 03:42 (hdb),
> sector
> 1880344
> Nov 18 12:09:00 fnd0355 kernel: hdb: dma_intr: status=0x51 { DriveReady
> SeekComplete Error }
> Nov 18 12:09:00 fnd0355 kernel: hdb: dma_intr: error=0x40 {
> UncorrectableError }, LBAsect=35408060, sector=1880352
> Nov 18 12:09:00 fnd0355 kernel: end_request: I/O error, dev 03:42 (hdb),
> sector
> 1880352
> Nov 18 12:09:00 fnd0355 kernel: hdb: dma_intr: status=0x51 { DriveReady
> SeekComplete Error }
> Nov 18 12:09:00 fnd0355 kernel: hdb: dma_intr: error=0x40 {
> UncorrectableError }, LBAsect=35408060, sector=1880360
> Nov 18 12:09:00 fnd0355 kernel: end_request: I/O error, dev 03:42 (hdb),
> sector
> 1880360
> Nov 18 12:09:00 fnd0355 kernel: hdb: dma_intr: status=0x51 { DriveReady
> SeekComplete Error }
> Nov 18 12:09:00 fnd0355 kernel: hdb: dma_intr: error=0x40 {
> UncorrectableError }, LBAsect=35408060, sector=1880368
> Nov 18 12:09:00 fnd0355 kernel: end_request: I/O error, dev 03:42 (hdb),
> sector
> 1880368
> Nov 18 12:09:00 fnd0355 kernel: hdb: dma_intr: status=0x51 { DriveReady
> SeekComplete Error }
> Nov 18 12:09:00 fnd0355 kernel: hdb: dma_intr: error=0x40 {
> UncorrectableError }
> Nov 18 12:09:00 fnd0355 kernel: hdb: dma_intr: error=0x40 {
> UncorrectableError }, LBAsect=35408060, sector=1880376
> Nov 18 12:09:00 fnd0355 kernel: end_request: I/O error, dev 03:42 (hdb),
> sector
> 1880376
> Nov 18 12:09:00 fnd0355 kernel: hdb: dma_intr: status=0x51 { DriveReady
> SeekComplete Error }
> Nov 18 12:09:00 fnd0355 kernel: hdb: dma_intr: error=0x40 {
> UncorrectableError }, LBAsect=35408060, sector=1880384
> Nov 18 12:09:00 fnd0355 kernel: end_request: I/O error, dev 03:42 (hdb),
> sector
> 1880384
> Nov 18 12:09:00 fnd0355 kernel: hdb: dma_intr: status=0x51 { DriveReady
> SeekComplete Error }
> Nov 18 12:09:00 fnd0355 kernel: hdb: dma_intr: error=0x40 {
> UncorrectableError }, LBAsect=35408060, sector=1880392
> Nov 18 12:09:00 fnd0355 kernel: end_request: I/O error, dev 03:42 (hdb),
> sector
> 1880392
> Nov 18 12:09:00 fnd0355 kernel: hdb: dma_intr: status=0x51 { DriveReady
> SeekComplete Error }
> Nov 18 12:09:00 fnd0355 kernel: hdb: dma_intr: error=0x40 {
> UncorrectableError }, LBAsect=35408060, sector=1880400
> Nov 18 12:09:00 fnd0355 kernel: end_request: I/O error, dev 03:42 (hdb),
> sector
> 1880400
>  ete Error }
> Nov 18 12:10:23 fnd0355 kernel: hdb: dma_intr: error=0x40 {
> UncorrectableError }, LBAsect=35408060, sector=1880400
> Nov 18 12:10:23 fnd0355 kernel: end_request: I/O error, dev 03:42 (hdb),
> sector
> 1880400
> Nov 18 12:10:28 fnd0355 kernel: hdb: dma_intr: status=0x51 { DriveReady
> SeekComplete Error }
> Nov 18 12:10:28 fnd0355 kernel: hdb: dma_intr: error=0x40 {
> UncorrectableError }, LBAsect=35408060, sector=1880400
> Nov 18 12:10:28 fnd0355 kernel: end_request: I/O error, dev 03:42 (hdb),
> sector
> 1880400
>
>
>
> ------------------------------------------------------------------
> Steven C. Timm (630) 840-8525  timm@fnal.gov  http://home.fnal.gov/~timm/
> Fermilab Computing Division/Operating Systems Support
> Scientific Computing Support Group--Computing Farms Operations
>
> On Wed, 20 Nov 2002, Manish Lachwani wrote:
>
> > you should do this. For example, the drive is hda and the raw device is
> > rhda. Then, you could remap using:
> >
> > dd if=/dev/zero of=/dev/rhda
> >
> > This will basically write accross the whole disk and is very time
> consuming.
> > However, you need to get the SMART data first from the drive using
> smartctl
> > and determine which sector needs to be remapped from SMART error log.
Then
> > you could do :
> >
> > dd if=/dev/zero of=/dev/rhda skip=<sectors obtained from above>
> >
> > Send me the SMART data and I will tell you the sector number ...
> >
> > Thanks
> > Manish
> >
> >
> >
> > -----Original Message-----
> > From: Steven Timm [mailto:timm@fnal.gov]
> > Sent: Wednesday, November 20, 2002 6:23 AM
> > To: Manish Lachwani
> > Cc: linux-kernel@vger.kernel.org
> > Subject: RE: AMD 760MPX dma_intr: error=0x40 { UncorrectableError }
> >
> >
> > Our boxes are actually running pretty cool (45C, with drives at the
> > front) and the drives seem
> > to be well mounted.  The power supply, and the power itself should
> > be OK.
> >
> > Thanks for the hint on remapping the sectors... what technique
> > would you use to do this?  Would zero-fill from the seagate
> > diagnostics work or should we use something else?
> >
> > Steve Timm
> >
> >
> > ------------------------------------------------------------------
> > Steven C. Timm (630) 840-8525  timm@fnal.gov
http://home.fnal.gov/~timm/
> > Fermilab Computing Division/Operating Systems Support
> > Scientific Computing Support Group--Computing Farms Operations
> >
> > On Tue, 19 Nov 2002, Manish Lachwani wrote:
> >
> > > I have seen this errors on Seagate ST380021A 80 GB drive on a large
> scale
> > in
> > > our storage systems that make use of 3ware controllers. Seagate claims
> the
> > > following reasons:
> > >
> > > 1. Weak Power supply
> > > 2. tempeature and heat
> > > 3. vibration
> > >
> > > Although, the maxtor 160 GB drives do not show such problems at all.
> Such
> > > problems can be eliminated though. From the SMART data, get the bad
> > sectors
> > > and remap them by writing to the raw device. Those pending sectors
will
> > get
> > > remapped. However, the problems will persist with these drives. In our
> > > boxes, the operating temperature is abt 55 C ...
> > >
> > > -----Original Message-----
> > > From: Steven Timm [mailto:timm@fnal.gov]
> > > Sent: Tuesday, November 19, 2002 1:37 PM
> > > To: linux-kernel@vger.kernel.org
> > > Subject: AMD 760MPX dma_intr: error=0x40 { UncorrectableError }
> > >
> > >
> > >
> > > I have recently observed a large frequency of this error on
> > > a bunch of compute servers with brand new disks.
> > >
> > > Nov 15 01:42:52 fnd0172 kernel: hdb: dma_intr: status=0x51 {
DriveReady
> > > SeekComplete Error }
> > > Nov 15 01:42:52 fnd0172 kernel: hdb: dma_intr: error=0x40 {
> > > UncorrectableError }, LBAsect=44763517, sector=11235856
> > > Nov 15 01:42:52 fnd0172 kernel: end_request: I/O error, dev 03:42
(hdb),
> > > sector 11235856
> > >
> > > Configuration is the following:
> > > Tyan 2466 motherboard which has AMD760MPX chipset, dual Athlon MP2000+
> > > processors  (supports UltraATA100)
> > >
> > > hda=Seagate ST340016A 40 GB drive, ext2 FS
> > > hdb=Seagate ST380021A 80 GB drive, ext2 FS.
> > >
> > > There are many entries in this mailing list saying that
> > > the above error is a sign of a bad disk.  Seagate diagnostics
> > > say so too.. It is just hard to believe that 30 hard drives could
> > > go bad in less than a month.
> > >
> > > I know errors of this type were common on machines with Serverworks
> > > OSB4 chipsets.  Has anyone else heard of this error happening on
> > > non-serverworks chipsets such as VIA or AMD?  And is the drive
> > > really bad or will a low level format clear the bad blocks
> > > and let the drive operate again?
> > >
> > > Steve Timm
> > >
> > > ------------------------------------------------------------------
> > >
> > > SMART shows the following error structure:
> > >
> > > SMART Error Log:
> > > SMART Error Logging Version: 1
> > > Error Log Data Structure Pointer: 03
> > > ATA Error Count: 13
> > > Non-Fatal Count: 0
> > >
> > > Error Log Structure 1:
> > > DCR   FR   SC   SN   CL   SH   D/H   CR   Timestamp
> > >  00   00   08   57   09   ab    f2   c8     40315
> > >  00   00   08   5f   09   ab    f2   c8     40315
> > >  00   00   08   67   09   ab    f2   c8     40315
> > >  00   00   08   6f   09   ab    f2   c8     40315
> > >  00   00   08   77   09   ab    f2   c8     40315
> > >  00   40   00   7d   09   ab    f2   51     922746
> > > Error condition:  33    Error State:       3
> > > Number of Hours in Drive Life: 1021 (life of the drive in hours)
> > >
> > > Error Log Structure 2:
> > > DCR   FR   SC   SN   CL   SH   D/H   CR   Timestamp
> > >  00   00   08   07   d5   55    f1   ca     40320
> > >  00   00   08   3f   00   5c    f1   ca     40320
> > >  00   00   08   97   33   5d    f1   ca     40320
> > >  00   00   08   87   97   0f    f2   ca     40320
> > >  00   00   08   77   09   ab    f2   c8     40320
> > >  00   40   00   7d   09   ab    f2   51     922746
> > > Error condition:  33    Error State:       3
> > > Number of Hours in Drive Life: 1021 (life of the drive in hours)
> > >
> > > Error Log Structure 3:
> > > DCR   FR   SC   SN   CL   SH   D/H   CR   Timestamp
> > >  00   00   28   bf   8f   52    f1   c8     23662
> > >  00   00   98   e7   8f   52    f1   c8     23662
> > >  00   00   68   ff   9a   52    f1   c8     23662
> > >  00   00   d8   67   9b   52    f1   c8     23662
> > >  00   00   28   07   a3   52    f1   c8     23662
> > >  00   40   00   25   a3   52    f1   51     1124073
> > > Error condition: 161    Error State:       3
> > > Number of Hours in Drive Life: 1040 (life of the drive in hours)
> > >
> > > Error Log Structure 4:
> > > DCR   FR   SC   SN   CL   SH   D/H   CR   Timestamp
> > >  00   00   e0   4f   09   ab    f2   c8     40280
> > >  00   00   d8   57   09   ab    f2   c8     40285
> > >  00   00   d0   5f   09   ab    f2   c8     40290
> > >  00   00   c8   67   09   ab    f2   c8     40296
> > >  00   00   c0   6f   09   ab    f2   c8     40301
> > >  00   40   00   7d   09   ab    f2   51     922746
> > > Error condition:  33    Error State:       3
> > > Number of Hours in Drive Life: 1021 (life of the drive in hours)
> > >
> > > Error Log Structure 5:
> > > DCR   FR   SC   SN   CL   SH   D/H   CR   Timestamp
> > >  00   00   d8   57   09   ab    f2   c8     40285
> > >  00   00   d0   5f   09   ab    f2   c8     40290
> > >  00   00   c8   67   09   ab    f2   c8     40296
> > >  00   00   c0   6f   09   ab    f2   c8     40301
> > >  00   00   b8   77   09   ab    f2   c8     40306
> > >  00   40   00   7d   09   ab    f2   51     922746
> > > Error condition:  33    Error State:       3
> > > Number of Hours in Drive Life: 1021 (life of the drive in hours)
> > >
> > >
> > >
> > > Steven C. Timm (630) 840-8525  timm@fnal.gov
> http://home.fnal.gov/~timm/
> > > Fermilab Computing Division/Operating Systems Support
> > > Scientific Computing Support Group--Computing Farms Operations
> > >
> > > -
> > > To unsubscribe from this list: send the line "unsubscribe
linux-kernel"
> in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > Please read the FAQ at  http://www.tux.org/lkml/
> > >
> >
>
