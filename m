Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262876AbVBCUaK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262876AbVBCUaK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 15:30:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263778AbVBCUaJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 15:30:09 -0500
Received: from wproxy.gmail.com ([64.233.184.199]:21329 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262876AbVBCU3s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 15:29:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=k2yzCuOs3QIHm0AW27FT0+hZjDqPuv45gDZTzlE/PpXyxbBX7hzNwh4moQxtcMTIjoMkvQIGetMHvvqwSOTdsYU/tqZ1dNMX3mFnOq6By4W9M3pDtuJwxwjMkcksMcC2crKfdUSpgW2D5blbkYEmKntmQYDAV0NqSHWKJRccL+8=
Message-ID: <58cb370e05020312296060f4bf@mail.gmail.com>
Date: Thu, 3 Feb 2005 21:29:43 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: via82cxxx resume failure.
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1105953931.26551.314.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1105953931.26551.314.camel@hades.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the delay.

On Mon, 17 Jan 2005 09:25:30 +0000, David Woodhouse <dwmw2@infradead.org> wrote:
> On resume from sleep, via_set_speed() doesn't reinstate the correct DMA
> mode, because it thinks the drive is already configured correctly. This
> one-line hack is sufficient to make it refrain from dying a horrible
> death immediately after resume, but presumably has other problems...

I applied this to libata-dev so it gets some testing in -mm.

> ===== drivers/ide/pci/via82cxxx.c 1.24 vs edited =====
> --- 1.24/drivers/ide/pci/via82cxxx.c    Mon Aug  9 18:00:46 2004
> +++ edited/drivers/ide/pci/via82cxxx.c  Tue Oct 26 22:48:59 2004
> @@ -328,7 +328,7 @@
>         struct ide_timing t, p;
>         unsigned int T, UT;
> 
> -       if (speed != XFER_PIO_SLOW && speed != drive->current_speed)
> +       //      if (speed != XFER_PIO_SLOW && speed != drive->current_speed)
>                 if (ide_config_drive_speed(drive, speed))
>                         printk(KERN_WARNING "ide%d: Drive %d didn't "
>                                 "accept speed setting. Oh, well.\n",
>
