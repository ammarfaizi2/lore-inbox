Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262275AbVD1V5Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262275AbVD1V5Y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 17:57:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262276AbVD1V5U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 17:57:20 -0400
Received: from zproxy.gmail.com ([64.233.162.193]:5919 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262275AbVD1V44 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 17:56:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FWpJ0dfJqouaPrwEj6rYHlENawx5ovtcMxmW03MRlIX2MJJkIxXLltQkFPrfsexk2+bPvCKLnSnGDvikXutzuWATELpEjIat2EhCElwsPLNR4QePg20BdpTjiYJdNDAin40tclaj19CwEEKS+5TPYHUc5M3uYB29PFbAOVcEuuQ=
Message-ID: <63f5296805042814562248b3a2@mail.gmail.com>
Date: Thu, 28 Apr 2005 23:56:56 +0200
From: Marcello Maggioni <hayarms@gmail.com>
Reply-To: Marcello Maggioni <hayarms@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
Subject: Re: [PATCH] Timeout at bootTime with NEC3500A (and others) when inserted a CD in it.
In-Reply-To: <63f529680504260719283a6a96@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <63f529680504260719283a6a96@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2005/4/26, Marcello Maggioni <hayarms@gmail.com>:
> Hi all,
> 
> I've attached a patch intended for solving boottime issues with this
> and other drives when a CD/DVD is inserted .
> 
> Problem: Some drives (NEC 3500 , TDK 1616N , Mad-dog MD-16XDVD9, RICOH
> MP5163DA , Memorex DVD9 drive and IO-DATA's too for sure) , if a
> CD/DVD is inserted into the tray when the system is booted and if
> before the OS bootup the BIOS checked for the presence of a bootable
> CD/DVD into the drive , during the IDE probe phase the drive may
> result busy and remain so for the next 25/30 seconds . This cause the
> drive to be skipped during the booting phase and not begin usable
> until the next reboot (if the reboot goes well and the drive doesn't
> timeout again ).
> 
> Solution: Rising the timeout time from 10 seconds to 35 seconds
> (during these 35 seconds  every drive should wake up for sure
> according to the tests I've done) .
> 
> Here the simple patch :
> 
> --- drivers/ide/ide-probe.c.orig        2005-04-26 15:04:46.000000000 +0200
> +++ drivers/ide/ide-probe.c     2005-04-26 15:04:14.000000000 +0200
> @@ -638,13 +638,13 @@
>         SELECT_DRIVE(&hwif->drives[0]);
>         hwif->OUTB(8, hwif->io_ports[IDE_CONTROL_OFFSET]);
>         mdelay(2);
> -       rc = ide_wait_not_busy(hwif, 10000);
> +       rc = ide_wait_not_busy(hwif, 35000);
>         if (rc)
>                 return rc;
>         SELECT_DRIVE(&hwif->drives[1]);
>         hwif->OUTB(8, hwif->io_ports[IDE_CONTROL_OFFSET]);
>         mdelay(2);
> -       rc = ide_wait_not_busy(hwif, 10000);
> +       rc = ide_wait_not_busy(hwif, 35000);
> 
>         /* Exit function with master reselected (let's be sane) */
>         SELECT_DRIVE(&hwif->drives[0]);
> 
> Greets,
> 
> Maggioni Marcello
> 

I have a question to ask.

What would be the negative effect of rising this timeout time?

Thanks

Bye

Marcello
