Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129394AbRBWTyM>; Fri, 23 Feb 2001 14:54:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129134AbRBWTyC>; Fri, 23 Feb 2001 14:54:02 -0500
Received: from ns.arraycomm.com ([199.74.167.5]:47788 "HELO
	bastion.arraycomm.com") by vger.kernel.org with SMTP
	id <S129193AbRBWTxs>; Fri, 23 Feb 2001 14:53:48 -0500
Message-Id: <5.0.2.1.2.20010223114332.00acae50@pop.arraycomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Date: Fri, 23 Feb 2001 11:51:57 -0800
To: "Ricardo Galli" <gallir@uib.es>, <linux-kernel@vger.kernel.org>
From: Jasmeet Sidhu <jsidhu@arraycomm.com>
Subject: Re: Via UDMA5 3/4/5 is not functional!
In-Reply-To: <LOEGIBFACGNBNCDJMJMOAEOACEAA.gallir@uib.es>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CRC errors are due to faulty cables.  Go buy some cables that are 
good.  I've had this problem and the only fix is to use better 
cables.  Infact, If you get really bad cables, on lets say hdc which is on 
the same controller as hda, then when the kernel resets the harddrive 
giving crc errors hdc, hda will also hang and you will get DMA 
timeouts.  This will leave your machine in a frozen state, much like the 
BSOD of the windows world...

Here is what happens when one of the drives has a bad cable...

In this setup, hdo and hdm are both master IBM DLTA drives connected to a 
Promise ATA100 controller.  Both drives are masters as there are no slave 
drives configured in this setup. The promise controller has 2 ide channels, 
ide0 would be /dev/hdm and /dev/hdn and ide1 would be then /dev/hdo and 
/dev/hdp.  As said above, only masters /dev/hdm and /dev/hdo are 
used.  When /dev/hdo has DMA problems, mainly CRC, the kernel will try to 
fix the controller by sending a reset, which also takes /dev/hdm down with it.

Feb 20 22:37:29 bertha kernel: hdo: dma_intr: status=0x51 { DriveReady 
SeekComplete Error }
Feb 20 22:37:29 bertha kernel: hdo: dma_intr: error=0x84 { DriveStatusError 
BadCRC }
Feb 20 22:37:29 bertha kernel: hdo: dma_intr: status=0x51 { DriveReady 
SeekComplete Error }
Feb 20 22:37:29 bertha kernel: hdo: dma_intr: error=0x84 { DriveStatusError 
BadCRC }
Feb 20 22:37:29 bertha kernel: hdo: dma_intr: status=0x51 { DriveReady 
SeekComplete Error }
Feb 20 22:37:29 bertha kernel: hdo: dma_intr: error=0x84 { DriveStatusError 
BadCRC }
Feb 20 22:37:29 bertha kernel: hdo: dma_intr: status=0x51 { DriveReady 
SeekComplete Error }
Feb 20 22:37:29 bertha kernel: hdo: dma_intr: error=0x84 { DriveStatusError 
BadCRC }
Feb 20 22:37:29 bertha kernel: hdo: dma_intr: status=0x51 { DriveReady 
SeekComplete Error }
Feb 20 22:37:29 bertha kernel: hdo: dma_intr: error=0x84 { DriveStatusError 
BadCRC }
Feb 20 22:37:29 bertha kernel: hdo: dma_intr: status=0x51 { DriveReady 
SeekComplete Error }
Feb 20 22:37:29 bertha kernel: hdo: dma_intr: error=0x84 { DriveStatusError 
BadCRC }
Feb 20 22:37:29 bertha kernel: ide7: reset: success
Feb 20 22:37:49 bertha kernel: hdm: timeout waiting for DMA
Feb 20 22:37:49 bertha kernel: ide_dmaproc: chipset supported 
ide_dma_timeout func only: 14
Feb 20 22:37:49 bertha kernel: hdm: irq timeout: status=0x52 { DriveReady 
SeekComplete Index }
Feb 20 22:37:59 bertha kernel: hdm: timeout waiting for DMA
Feb 20 22:37:59 bertha kernel: ide_dmaproc: chipset supported 
ide_dma_timeout func only: 14
Feb 20 22:37:59 bertha kernel: hdm: irq timeout: status=0x50 { DriveReady 
SeekComplete }
Feb 20 22:38:19 bertha kernel: hdm: timeout waiting for DMA
Feb 20 22:38:19 bertha kernel: ide_dmaproc: chipset supported 
ide_dma_timeout func only: 14
Feb 20 22:38:19 bertha kernel: hdm: irq timeout: status=0x50 { DriveReady 
SeekComplete }
Feb 20 22:38:39 bertha kernel: hdm: timeout waiting for DMA
Feb 20 22:38:39 bertha kernel: ide_dmaproc: chipset supported 
ide_dma_timeout func only: 14
Feb 20 22:38:39 bertha kernel: hdm: irq timeout: status=0x50 { DriveReady 
SeekComplete }
Feb 20 22:38:39 bertha kernel: hdm: DMA disabled
Feb 20 22:38:39 bertha kernel: ide6: reset: success


At 04:38 PM 2/22/2001 +0100, Ricardo Galli wrote:
> > Then I tried kernel 2.4.1. I issued exactly the same hdparm command.
> > i got in syslog the message: "ide0: Speed warnings UDMA 3/4/5 is not
> > functional"!
>
>
>I had the same problem.
>
>Add
>append="ide0=ata66 ide1=ata66 ide0=autotune ide1=autotune hda=autotune
>hdb=autotune hdc=autotune"
>to lilo.conf.
>
>
>BTW, I am having now CRC errors in IDE1 on the VIA, IDE0 it's ok at udma5
>and 30MB/sec.
>
>Regards,
>
>--ricardo
>http://m3d.uib.es/~gallir/
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/


- - -
Jasmeet Sidhu
Unix Systems Administrator
ArrayComm, Inc.
jsidhu@arraycomm.com
www.arraycomm.com


