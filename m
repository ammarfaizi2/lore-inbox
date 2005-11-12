Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750887AbVKLBae@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750887AbVKLBae (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 20:30:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750890AbVKLBae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 20:30:34 -0500
Received: from zproxy.gmail.com ([64.233.162.195]:12879 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750886AbVKLBad convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 20:30:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Pa/AHXiuj3WAR7V9EC/kPzf7XPk77C4zIQzI8icyPFk64evs946YXdAkenra4jQk/72CmU8BDXoNxIcSZOFxOKTTm8tyD537A4cO5+p63c5t6Try0a0wsIa1ljnPM5BEAJZRHmvCvy2ldjFgPmjQ2xTLZ/TZF6aDaybfFrWxAb0=
Message-ID: <6bffcb0e0511111730nc8ae355s@mail.gmail.com>
Date: Sat, 12 Nov 2005 02:30:32 +0100
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.14-mm1
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051111165156.05391fef.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051106182447.5f571a46.akpm@osdl.org>
	 <6bffcb0e0511111631h52ff73e1q@mail.gmail.com>
	 <20051111165156.05391fef.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/05, Andrew Morton <akpm@osdl.org> wrote:
> Crap.  This is one of those crashes where the sound people, the PCI people,
> the ACPI people and the PM people all earnestly hope that it's the other
> guy's bug and you and I are left with a mess on our hands.
>
> Possibly the card didn't get powered up.  I know there's a way to get all
> those snd_printk()'s to print something, but I never have much success
> finding the right value for the right /proc file to make it happen.
>
> So can you add this please?
>
> --- devel/sound/pci/intel8x0.c~a        2005-11-11 16:47:00.000000000 -0800
> +++ devel-akpm/sound/pci/intel8x0.c     2005-11-11 16:48:13.000000000 -0800
> @@ -779,6 +779,7 @@ static irqreturn_t snd_intel8x0_interrup
>         unsigned int i;
>
>         status = igetdword(chip, chip->int_sta_reg);
> +       printk("status: 0x%8x\n", status);
>         if (status == 0xffffffff)       /* we are not yet resumed */
>                 return IRQ_NONE;
>
> _
>
> and let us know what it says?
>
> Also, it would be useful if you could disable the sound driver in config
> and see if you can get it booted.  If so, then generate the `dmesg -s
> 1000000' output for good and bad kernels and let's see what they look like.
>
> Thanks.
>

I will try to reproduce it, but according to
http://klive.cpushare.com/2.6.14-mm1/?order_by=kernel_group&where_machine=all&branch=mm&scheduler=all&smp=all&live=all&ip=all
I have been using 2.6.14-mm1 about 48 hours with 12 reboots and this
problem appeared only once.

Regards,
Michal Piotrowski
