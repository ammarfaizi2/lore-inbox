Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261300AbVEQHa2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbVEQHa2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 03:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261314AbVEQHa2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 03:30:28 -0400
Received: from fire.osdl.org ([65.172.181.4]:65246 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261300AbVEQH34 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 03:29:56 -0400
Date: Tue, 17 May 2005 00:29:08 -0700
From: Andrew Morton <akpm@osdl.org>
To: dino@in.ibm.com
Cc: gregoire.favre@gmail.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: What breaks aic7xxx in post 2.6.12-rc2 ?
Message-Id: <20050517002908.005a9ba7.akpm@osdl.org>
In-Reply-To: <20050517071307.GA4794@in.ibm.com>
References: <20050516085832.GA9558@gmail.com>
	<20050517071307.GA4794@in.ibm.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dinakar Guniguntala <dino@in.ibm.com> wrote:
>
> 
> Here's a me too report. 

Better cc linux-scsi.

Are these bugs also present in 2.6.12-rc4?

> This is controller that I have
> 
> 00:0e.0 SCSI storage controller: Adaptec AIC-7896U2/7897U2
> 
> I never used to get warning such as "refuses WIDE negotiation"
> in kernels prior to 2.6.12-rc3-mm3.
> The machine (x86) boots up fine though.
> 
> Here's the relevant dmesg output from 2.6.12-rc4-mm1
> 
> ======================================================================
> 
> scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
>         <Adaptec aic7896/97 Ultra2 SCSI adapter>
>         aic7896/97: Ultra2 Wide Channel B, SCSI Id=7, 32/253 SCBs
> 
>   Vendor: IBM-PSG   Model: ST39103LC     !#  Rev: B227
>   Type:   Direct-Access                      ANSI SCSI revision: 02
> scsi0:A:0:0: Tagged Queuing enabled.  Depth 32
>  target0:0:0: Beginning Domain Validation
> WIDTH IS 1
> (scsi0:A:0): 6.600MB/s transfers (16bit)
>  target0:0:0: Domain Validation skipping write tests
> (scsi0:A:0): 80.000MB/s transfers (40.000MHz, offset 15, 16bit)
>  target0:0:0: Ending Domain Validation
>   Vendor: IBM-PSG   Model: ST39103LC     !#  Rev: B227
>   Type:   Direct-Access                      ANSI SCSI revision: 02
> scsi0:A:1:0: Tagged Queuing enabled.  Depth 32
>  target0:0:1: Beginning Domain Validation
> WIDTH IS 1
> (scsi0:A:1): 6.600MB/s transfers (16bit)
>  target0:0:1: Domain Validation skipping write tests
> (scsi0:A:1): 80.000MB/s transfers (40.000MHz, offset 15, 16bit)
>  target0:0:1: Ending Domain Validation
> (scsi0:A:15:0): refuses WIDE negotiation.  Using 8bit transfers   <============
> scsi0:0:15:0: Attempting to queue an ABORT message
> CDB: 0x12 0x0 0x0 0x0 0x36 0x0
> scsi0: At time of recovery, card was not paused
> >>>>>>>>>>>>>>>>>> Dump Card State Begins <<<<<<<<<<<<<<<<<
> scsi0: Dumping Card State in Data-in phase, at SEQADDR 0x85
> Card was paused
> ACCUM = 0x40, SINDEX = 0xa, DINDEX = 0xe4, ARG_2 = 0x0
> HCNT = 0x36 SCBPTR = 0x0
> SCSISIGI[0x46] ERROR[0x0] SCSIBUSL[0x3] LASTPHASE[0x40]
> SCSISEQ[0x12] SBLKCTL[0xa] SCSIRATE[0x0] SEQCTL[0x10]
> SEQ_FLAGS[0x20] SSTAT0[0x0] SSTAT1[0x2] SSTAT2[0x40]
> SSTAT3[0x0] SIMODE0[0x8] SIMODE1[0xac] SXFRCTL0[0x80]
> DFCNTRL[0x28] DFSTATUS[0x80]
> STACK: 0x0 0x160 0x176 0x83
> SCB count = 4
> Kernel NEXTQSCB = 3
> Card NEXTQSCB = 3
> QINFIFO entries:
> Waiting Queue entries:
> Disconnected Queue entries:
> QOUTFIFO entries:
> Sequencer Free SCB List: 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
> Sequencer SCB Info:
>   0 SCB_CONTROL[0x40] SCB_SCSIID[0xf7] SCB_LUN[0x0] SCB_TAG[0x2]
>   1 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
>   2 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
>   3 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
>   4 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
>   5 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
>   6 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
>   7 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
>   8 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
>   9 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
>  10 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
>  11 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
>  12 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
>  13 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
>  14 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
>  15 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
>  16 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
>  17 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
>  18 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
>  19 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
>  20 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
>  21 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
>  22 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
>  23 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
>  24 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
>  25 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
>  26 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
>  27 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
>  28 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
>  29 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
>  30 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
>  31 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
> Pending list:
>   2 SCB_CONTROL[0x40] SCB_SCSIID[0xf7] SCB_LUN[0x0]
> Kernel Free SCB list: 1 0
> Untagged Q(15): 2
> DevQ(0:0:0): 0 waiting
> DevQ(0:1:0): 0 waiting
> DevQ(0:15:0): 0 waiting
> 
> <<<<<<<<<<<<<<<<< Dump Card State Ends >>>>>>>>>>>>>>>>>>
> scsi0:0:15:0: Device is active, asserting ATN
> Recovery code sleeping
> Recovery code awake
> Timer Expired
> aic7xxx_abort returns 0x2003
> scsi0:0:15:0: Attempting to queue a TARGET RESET message
> CDB: 0x12 0x0 0x0 0x0 0x36 0x0
> aic7xxx_dev_reset returns 0x2003
> Recovery SCB completes
> (scsi0:A:15:0): refuses WIDE negotiation.  Using 8bit transfers
> (scsi0:A:15:0): refuses WIDE negotiation.  Using 8bit transfers
> scsi0:0:15:0: Attempting to queue an ABORT message
> CDB: 0x12 0x0 0x0 0x0 0x36 0x0
> scsi0: At time of recovery, card was not paused
> 
> 
> ======================================================================
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
