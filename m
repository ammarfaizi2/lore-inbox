Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964887AbVKCK7o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964887AbVKCK7o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 05:59:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964897AbVKCK7o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 05:59:44 -0500
Received: from nproxy.gmail.com ([64.233.182.206]:13957 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964887AbVKCK7n convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 05:59:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qD9exTbJoOhNIKSQPSzSGCTPR+7A6cR7/NXluNKdAu13Ksg1b2gv3R0FShI1cZtHeNd3VBCYha7lMsOvOu9pHMdMfVcQr3j8e75Las6L078LeZac51jNdjkLN2xdeomGgCNp+ji3+k4xXl4ktBNkotBSicLiPT5QI3H+PWqff3g=
Message-ID: <58cb370e0511030259i24580f3am9c2211f644fab99b@mail.gmail.com>
Date: Thu, 3 Nov 2005 11:59:39 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] Incorrect device link for ide-cs
Cc: linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
       Jens Axboe <axboe@suse.de>
In-Reply-To: <4369E4BF.4010706@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4369D693.4040500@suse.de>
	 <58cb370e0511030157l5e47a15h25832fb98e46173a@mail.gmail.com>
	 <4369E4BF.4010706@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/3/05, Hannes Reinecke <hare@suse.de> wrote:
> Bartlomiej Zolnierkiewicz wrote:
> > Hi,
> >
> >>      hw_regs_t hw;
> >>      memset(&hw, 0, sizeof(hw));
> >> -    ide_init_hwif_ports(&hw, io, ctl, NULL);
> >> +    ide_std_init_ports(&hw, io, ctl);
> >
> > Could you separate this into another patch?
> >
> > This change fixes ide-cs for some archs but OTOH we should verify that
> > there are no ide-cs specific hacks in ide_init_hwif_ports() on other archs.
> >
> Oops, you are correct. The main reason why I did this is this comment in
> include/linux/ide.h:
>  * ide_init_hwif_ports() is OBSOLETE and will be removed in 2.7 series.
>
> Arch specific codes are in:
> cris/v10
> arm/sa1100
> arch-m68knommu

I'm more worried about indirect PPC32 hacks...

...
#ifdef CONFIG_PPC32
        if (ppc_ide_md.ide_init_hwif)
                ppc_ide_md.ide_init_hwif(hw, io_addr, ctl_addr, irq);
#endif
...

> Neither of which is using the irq parameter anyway, so it would make
> sense to remove that interface completely.
>
> Updated patch attached.

Thanks,
Bartlomiej
