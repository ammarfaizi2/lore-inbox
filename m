Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261342AbVEQIYv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261342AbVEQIYv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 04:24:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261345AbVEQIYv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 04:24:51 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:39888 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261326AbVEQIYS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 04:24:18 -0400
Date: Tue, 17 May 2005 14:04:36 +0530
From: Dinakar Guniguntala <dino@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: gregoire.favre@gmail.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: What breaks aic7xxx in post 2.6.12-rc2 ?
Message-ID: <20050517083436.GB4794@in.ibm.com>
Reply-To: dino@in.ibm.com
References: <20050516085832.GA9558@gmail.com> <20050517071307.GA4794@in.ibm.com> <20050517002908.005a9ba7.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050517002908.005a9ba7.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2005 at 12:29:08AM -0700, Andrew Morton wrote:
> Better cc linux-scsi.

  Thanks

> Are these bugs also present in 2.6.12-rc4?

Yes, I tried a vanilla 2.6.12-rc4 and I get the same output.
I get this from 2.6.12-rc3 onwards. 

Maybe something from the following changeset of 2.6.12-rc3 ??

jejb@titanic.il.steeleye.com:
    [PATCH] finally fix 53c700 to use the generic iomem infrastructure
    [PATCH] Convert i2o to compat_ioctl
    [PATCH] Convert i2o to compat_ioctl
    aic7xxx: add support for the SPI transport class
    aic7xxx: convert to SPI transport class Domain Validation
    lpfc: add Emulex FC driver version 8.0.28
    qla2xxx: fix compiler warning in qla_attr.c
    scsi: add DID_REQUEUE to the error handling
    scsi: add DID_REQUEUE to the error handling
    updates for CFQ oops fix
    zfcp: add point-2-point support
    zfcp: add point-2-point support


	-Dinakar


> > This is controller that I have
> > 
> > 00:0e.0 SCSI storage controller: Adaptec AIC-7896U2/7897U2
> > 
> > I never used to get warning such as "refuses WIDE negotiation"
> > in kernels prior to 2.6.12-rc3-mm3.
> > The machine (x86) boots up fine though.
> > 
> > Here's the relevant dmesg output from 2.6.12-rc4-mm1
> > 
> > ======================================================================
> > 
> > scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
> >         <Adaptec aic7896/97 Ultra2 SCSI adapter>
> >         aic7896/97: Ultra2 Wide Channel B, SCSI Id=7, 32/253 SCBs
> > 
> >   Vendor: IBM-PSG   Model: ST39103LC     !#  Rev: B227
> >   Type:   Direct-Access                      ANSI SCSI revision: 02
> > scsi0:A:0:0: Tagged Queuing enabled.  Depth 32
> >  target0:0:0: Beginning Domain Validation
> > WIDTH IS 1
> > (scsi0:A:0): 6.600MB/s transfers (16bit)
> >  target0:0:0: Domain Validation skipping write tests
> > (scsi0:A:0): 80.000MB/s transfers (40.000MHz, offset 15, 16bit)
> >  target0:0:0: Ending Domain Validation
> >   Vendor: IBM-PSG   Model: ST39103LC     !#  Rev: B227
> >   Type:   Direct-Access                      ANSI SCSI revision: 02
> > scsi0:A:1:0: Tagged Queuing enabled.  Depth 32
> >  target0:0:1: Beginning Domain Validation
> > WIDTH IS 1
> > (scsi0:A:1): 6.600MB/s transfers (16bit)
> >  target0:0:1: Domain Validation skipping write tests
> > (scsi0:A:1): 80.000MB/s transfers (40.000MHz, offset 15, 16bit)
> >  target0:0:1: Ending Domain Validation
> > (scsi0:A:15:0): refuses WIDE negotiation.  Using 8bit transfers   <============
> > scsi0:0:15:0: Attempting to queue an ABORT message
> > CDB: 0x12 0x0 0x0 0x0 0x36 0x0
> > scsi0: At time of recovery, card was not paused
> > >>>>>>>>>>>>>>>>>> Dump Card State Begins <<<<<<<<<<<<<<<<<
> > scsi0: Dumping Card State in Data-in phase, at SEQADDR 0x85
> > Card was paused
> > ACCUM = 0x40, SINDEX = 0xa, DINDEX = 0xe4, ARG_2 = 0x0
> > HCNT = 0x36 SCBPTR = 0x0
> > SCSISIGI[0x46] ERROR[0x0] SCSIBUSL[0x3] LASTPHASE[0x40]
> > SCSISEQ[0x12] SBLKCTL[0xa] SCSIRATE[0x0] SEQCTL[0x10]
> > SEQ_FLAGS[0x20] SSTAT0[0x0] SSTAT1[0x2] SSTAT2[0x40]
> > SSTAT3[0x0] SIMODE0[0x8] SIMODE1[0xac] SXFRCTL0[0x80]
> > DFCNTRL[0x28] DFSTATUS[0x80]
> > STACK: 0x0 0x160 0x176 0x83
> > SCB count = 4
> > Kernel NEXTQSCB = 3
> > Card NEXTQSCB = 3
> > QINFIFO entries:
> > Waiting Queue entries:
> > Disconnected Queue entries:
> > QOUTFIFO entries:
> > Sequencer Free SCB List: 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
> > Sequencer SCB Info:
> >   0 SCB_CONTROL[0x40] SCB_SCSIID[0xf7] SCB_LUN[0x0] SCB_TAG[0x2]
> >   1 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
> >   2 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
> >   3 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
> >   4 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
> >   5 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
> >   6 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
> >   7 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
> >   8 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
> >   9 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
> >  10 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
> >  11 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
> >  12 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
> >  13 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
> >  14 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
> >  15 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
> >  16 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
> >  17 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
> >  18 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
> >  19 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
> >  20 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
> >  21 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
> >  22 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
> >  23 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
> >  24 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
> >  25 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
> >  26 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
> >  27 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
> >  28 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
> >  29 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
> >  30 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
> >  31 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
> > Pending list:
> >   2 SCB_CONTROL[0x40] SCB_SCSIID[0xf7] SCB_LUN[0x0]
> > Kernel Free SCB list: 1 0
> > Untagged Q(15): 2
> > DevQ(0:0:0): 0 waiting
> > DevQ(0:1:0): 0 waiting
> > DevQ(0:15:0): 0 waiting
> > 
> > <<<<<<<<<<<<<<<<< Dump Card State Ends >>>>>>>>>>>>>>>>>>
> > scsi0:0:15:0: Device is active, asserting ATN
> > Recovery code sleeping
> > Recovery code awake
> > Timer Expired
> > aic7xxx_abort returns 0x2003
> > scsi0:0:15:0: Attempting to queue a TARGET RESET message
> > CDB: 0x12 0x0 0x0 0x0 0x36 0x0
> > aic7xxx_dev_reset returns 0x2003
> > Recovery SCB completes
> > (scsi0:A:15:0): refuses WIDE negotiation.  Using 8bit transfers
> > (scsi0:A:15:0): refuses WIDE negotiation.  Using 8bit transfers
> > scsi0:0:15:0: Attempting to queue an ABORT message
> > CDB: 0x12 0x0 0x0 0x0 0x36 0x0
> > scsi0: At time of recovery, card was not paused
> > 
> > 
> > ======================================================================
