Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278958AbRJaBek>; Tue, 30 Oct 2001 20:34:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279024AbRJaBeb>; Tue, 30 Oct 2001 20:34:31 -0500
Received: from smtpsrv1.isis.unc.edu ([152.2.1.138]:8928 "EHLO
	smtpsrv1.isis.unc.edu") by vger.kernel.org with ESMTP
	id <S278958AbRJaBeU>; Tue, 30 Oct 2001 20:34:20 -0500
Date: Tue, 30 Oct 2001 20:34:55 -0500 (EST)
From: "Daniel T. Chen" <crimsun@email.unc.edu>
To: "J . A . Magallon" <jamagallon@able.es>
cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: cdrecord from ext3
In-Reply-To: <20011031001846.A1840@werewolf.able.es>
Message-ID: <Pine.A41.4.21L1.0110302032400.21676-100000@login2.isis.unc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Interesting. I've burnt just fine with `cdrecord -v speed=20 dev=0,0,0
foo.iso` to an ATAPI Yamaha CRW2200 (2.4.13-ac1+freeswap). Lowest FIFO
reports are ~78%. I gave up my Plexwriter 8/20 a while back, so I'd look
at the aic7xxx driver.

---
Dan Chen                 crimsun@email.unc.edu
GPG key: www.cs.unc.edu/~chenda/pubkey.gpg.asc

On Wed, 31 Oct 2001, J . A . Magallon wrote:

> Hi all,
> 
> I have found a strange problem using cdrecord from an ext3 partition.
> When burning a cd image (about 500Mb), with cdrecord -v to see some info,
> after about 150Mb the percentage of fifo filled begins to drop, until the
> burning fails. I though it was related to some buffer/cache issue, but
> then I just copied the image to an ext2 partition (so the cache still
> filled more, just reaching my ram size), and burnt perfect from the
> ext2 partition.
> 
> So it looks like ext3 can not give a sustained read rate (not so much,
> burning was at 8x). Fifo from ext2 never dropped below 99%.
> 
> Is this a bug or the answer is just 'never toast from a journaled fs' ?
> 
> Kernel: 2.4.13-ac5+bproc, controller is an Adaptec
> 
> Controller:
> Adaptec AIC7xxx driver version: 6.2.4
> aic7890/91: Ultra2 Wide Channel A, SCSI Id=7, 32/253 SCBs
> 
> Drives:
> Host: scsi0 Channel: 00 Id: 00 Lun: 00
>   Vendor: IBM      Model: DDYS-T09170N     Rev: S96H
>   Type:   Direct-Access                    ANSI SCSI revision: 03
> Host: scsi0 Channel: 00 Id: 01 Lun: 00
>   Vendor: IBM      Model: DCAS-34330W      Rev: S65A
>   Type:   Direct-Access                    ANSI SCSI revision: 02
> Host: scsi1 Channel: 00 Id: 00 Lun: 00
>   Vendor: CREATIVE Model: CD5230E          Rev: 1.01
>   Type:   CD-ROM                           ANSI SCSI revision: 02
> Host: scsi1 Channel: 00 Id: 01 Lun: 00
>   Vendor: YAMAHA   Model: CRW8424E         Rev: 1.0j
>   Type:   CD-ROM                           ANSI SCSI revision: 02
> 
> Settings:
> Channel A Target 0 Negotiation Settings
>         User: 80.000MB/s transfers (40.000MHz, offset 255, 16bit)
>         Goal: 80.000MB/s transfers (40.000MHz, offset 63, 16bit)
>         Curr: 80.000MB/s transfers (40.000MHz, offset 63, 16bit)
> 		(ext2)
> Channel A Target 1 Negotiation Settings
>         User: 80.000MB/s transfers (40.000MHz, offset 255, 16bit)
>         Goal: 40.000MB/s transfers (20.000MHz, offset 15, 16bit)
>         Curr: 40.000MB/s transfers (20.000MHz, offset 15, 16bit)
> 		(ext3)
> 
> 

