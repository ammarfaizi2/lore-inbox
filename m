Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282945AbRLXWjG>; Mon, 24 Dec 2001 17:39:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283244AbRLXWi4>; Mon, 24 Dec 2001 17:38:56 -0500
Received: from confused.landsberger.com ([216.160.68.107]:52740 "EHLO
	mephistopheles.landsberger.com") by vger.kernel.org with ESMTP
	id <S282945AbRLXWir>; Mon, 24 Dec 2001 17:38:47 -0500
Subject: Re: IDE CDROM locks the system hard on media error
From: Brian Landsberger <brian@landsberger.com>
To: Stanislav Meduna <stano@meduna.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200112242128.fBOLSPa08269@meduna.org>
In-Reply-To: <200112242128.fBOLSPa08269@meduna.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.0.99+cvs.2001.12.18.08.57 (Preview Release)
Date: 24 Dec 2001 14:37:56 -0800
Message-Id: <1009233476.1733.7.camel@fux0r.landsberger.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do you have multiple CD/DVD-R/ROM/R's? This happened today to me when I
was installing Myth II and Quake III at the same time. 

First CDROM according to "cat /proc/ide/hdc/model" is pretty generic:
ATAPI 48X CDROM

Second CD-RW according to "cat /proc/ide/hdd/model" is a: LITE-ON
LTR-16102B

Some stuff ala syslog:

Dec 24 13:26:33 fux0r kernel: cdrom: open failed.
Dec 24 13:26:45 fux0r kernel: cdrom: open failed.
Dec 24 13:29:22 fux0r su(pam_unix)[27872]: session closed for user root
Dec 24 13:31:25 fux0r kernel: scsi : aborting command due to timeout :
pid 34319, scsi1, channel 0, id 0, lun 0 Read (10) 00 00 00 00 42 00 00
01 00 
Dec 24 13:31:25 fux0r kernel: hdc: timeout waiting for DMA
Dec 24 13:31:25 fux0r kernel: ide_dmaproc: chipset supported
ide_dma_timeout func only: 14
Dec 24 13:31:25 fux0r kernel: scsi : aborting command due to timeout :
pid 34321, scsi1, channel 0, id 1, lun 0 Read (10) 00 00 00 c2 e7 00 00
01 00 
Dec 24 13:31:26 fux0r kernel: hdc: status timeout: status=0xd0 { Busy }
Dec 24 13:31:26 fux0r kernel: hdc: drive not ready for command
Dec 24 13:31:30 fux0r kernel: hdc: ATAPI reset complete
Dec 24 13:31:31 fux0r kernel: hdc: irq timeout: status=0xc0 { Busy }
Dec 24 13:31:31 fux0r kernel: hdc: ATAPI reset complete

the next thing we see is syslogd restarting (after rebooting)

Thanks,
Brian




On Mon, 2001-12-24 at 13:28, Stanislav Meduna wrote:
> Hello,
> 
> > > I am using vanilla 2.4.17, hdc=ide-scsi, my drive is Mitsumi CR-4804TE,
> > > motherboard is Abit BP6 SMP, Intel PIIX4 IDE controller.
> > 
> > Does turning off or restricting the DMA mode using either
> > one of these help?
> >     hdparm -d0 -c1 /dev/hdc 
> 
> This seems to help - I tried the most problematic CD several times,
> got the error messages, but it did not froze.
> 
> Thanks - I didn't even know that it defaults to DMA on CD-ROMs...
> 
> >     hdparm -d 1 -X 34 /dev/hdc
> 
> This drive cannot do more than mdma1 (at least according to hdparm -i).
> 
> Regards
> -- 
>                                        Stano
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


