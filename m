Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263739AbTJCNLF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 09:11:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263740AbTJCNLF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 09:11:05 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:23425 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S263739AbTJCNK7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 09:10:59 -0400
Date: Fri, 3 Oct 2003 14:11:29 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200310031311.h93DBTOG001012@81-2-122-30.bradfords.org.uk>
To: Erik Bourget <erik@midmaine.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <87he2qtrll.fsf@loki.odinnet>
References: <87brsybm41.fsf@loki.odinnet>
 <200310031159.h93BxfYm000758@81-2-122-30.bradfords.org.uk>
 <87he2qtrll.fsf@loki.odinnet>
Subject: Re: CMD680, kernel 2.4.21, and heartache
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >>> Oct 1 07:47:47 mailstore2-1 kernel: hda: dma_intr: status=0x51 { DriveReady
> >>> SeekComplete Error } Oct 1 07:47:47 mailstore2-1 kernel: hda: dma_intr:
> >>> error=0x40 { UncorrectableError }, LBAsect=37694874, high=2, low=4140442,
> >>> sector=35220864
> >>
> >> That is definitely an error from the drive.  If you're absolutely sure
> >> it's not a faulty batch of drives or a cooling issue, maybe you have
> >> power supply problems?  Does SMART give you any useful information?
> >
> > Not power supply problems; two of the machines that have this problem are
> > located in different facilities even.  What's SMART?
> 
> Figured out SMART.  Looks bad:
> 
> mailstore2-1:/home/erik# smartctl -a /dev/hda
> Device: IC35L120AVV207-0  Supports ATA Version 6
> Drive supports S.M.A.R.T. and is enabled
> Check S.M.A.R.T. Passed.
> 
> General Smart Values: 
> Off-line data collection status: (0x85) Offline data collection activity was 
>                                         aborted by an interrupting command
> 
> Self-test execution status:      ( 245) Self-test routine in progess
>                                         50% of test remaining
> 
> Total time to complete off-line 
> data collection:                 (2855) Seconds
> 
> Offline data collection 
> Capabilities:                    (0x1b)SMART EXECUTE OFF-LINE IMMEDIATE
>                                         Automatic timer ON/OFF support
>                                         Suspend Offline Collection upon new
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
> recommended polling time:        (  48) Minutes
> 
> Vendor Specific SMART Attributes with Thresholds:
> Revision Number: 16
> Attribute                    Flag     Value Worst Threshold Raw Value
> (  1)Raw Read Error Rate     0x000b   095   095   060       458761
> (  2)Throughput Performance  0x0005   148   148   050       264
> (  3)Spin Up Time            0x0007   100   100   024       291
> (  4)Start Stop Count        0x0012   100   100   000       6
> (  5)Reallocated Sector Ct   0x0033   100   100   005       7
> (  7)Seek Error Rate         0x000b   100   100   067       0
> (  8)Seek Time Preformance   0x0005   123   123   000       37
> (  9)Power On Hours          0x0012   100   100   000       709
> ( 10)Spin Retry Count        0x0013   100   100   060       0
> ( 12)Power Cycle Count       0x0032   100   100   000       6
> (192)Power-Off Retract Count 0x0032   100   100   050       21
> (193)Load Cycle Count        0x0012   100   100   050       21
> (194)Temperature             0x0002   196   196   000       1441854
> (196)Reallocated Event Count 0x0032   100   100   000       7
> (197)Current Pending Sector  0x0022   100   100   000       3
> (198)Offline Uncorrectable   0x0008   100   100   000       3
> (199)UDMA CRC Error Count    0x000a   200   200   000       0
> SMART Error Log:
> SMART Error Logging Version: 1
> Error Log Data Structure Pointer: 01
> ATA Error Count: 1
> Non-Fatal Count: 0
> 
> Error Log Structure 1:
> DCR   FR   SC   SN   CL   SH   D/H   CR   Timestamp
>  00   00   08   22   1d   3f    e0   25     1851604
>  00   00   08   aa   2b   3f    e0   25     1851604
>  00   00   08   6a   1d   3f    e0   25     1851604
>  00   00   08   02   96   3f    e0   25     1851604
>  00   00   08   9a   2d   3f    e0   25     1851604
>  00   40   08   9a   2d   3f    e2   51     0
> Error condition:   0    Error State:       3
> Number of Hours in Drive Life: 660 (life of the drive in hours)
> 
> Eep.
> 
> Are these errors set by the drive itself,

Yes - the error log is direct from the drive - a faulty controller or
driver won't cause it to report bogus errors that it hasn't logged.

> or could a faulty harddrive
> controller / driver cause them?

Real errors have definitely been logged by that drive.  A broken
controller may concievably have contributed to that.

>  FWIW, I spoke offline to somebody about this
> last week who seemed to think that it was an Alan Cox APIC bug.

Alan is the best person to ask.  Or maybe somebody else will pick up
on this thread.  I'd rather not speculate without knowing more about
the specific machines.

John.
