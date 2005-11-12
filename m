Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750965AbVKLBrt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750965AbVKLBrt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 20:47:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750978AbVKLBrt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 20:47:49 -0500
Received: from smtp.osdl.org ([65.172.181.4]:11496 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750964AbVKLBrs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 20:47:48 -0500
Date: Fri, 11 Nov 2005 17:47:32 -0800
From: Andrew Morton <akpm@osdl.org>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-mm1
Message-Id: <20051111174732.02455c83.akpm@osdl.org>
In-Reply-To: <6bffcb0e0511111730nc8ae355s@mail.gmail.com>
References: <20051106182447.5f571a46.akpm@osdl.org>
	<6bffcb0e0511111631h52ff73e1q@mail.gmail.com>
	<20051111165156.05391fef.akpm@osdl.org>
	<6bffcb0e0511111730nc8ae355s@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
>
> On 12/11/05, Andrew Morton <akpm@osdl.org> wrote:
> > Crap.  This is one of those crashes where the sound people, the PCI people,
> > the ACPI people and the PM people all earnestly hope that it's the other
> > guy's bug and you and I are left with a mess on our hands.
> >
> > Possibly the card didn't get powered up.  I know there's a way to get all
> > those snd_printk()'s to print something, but I never have much success
> > finding the right value for the right /proc file to make it happen.
> >
> > So can you add this please?
> >
> > --- devel/sound/pci/intel8x0.c~a        2005-11-11 16:47:00.000000000 -0800
> > +++ devel-akpm/sound/pci/intel8x0.c     2005-11-11 16:48:13.000000000 -0800
> > @@ -779,6 +779,7 @@ static irqreturn_t snd_intel8x0_interrup
> >         unsigned int i;
> >
> >         status = igetdword(chip, chip->int_sta_reg);
> > +       printk("status: 0x%8x\n", status);
> >         if (status == 0xffffffff)       /* we are not yet resumed */
> >                 return IRQ_NONE;
> >
> > _
> >
> > and let us know what it says?
> >
> > Also, it would be useful if you could disable the sound driver in config
> > and see if you can get it booted.  If so, then generate the `dmesg -s
> > 1000000' output for good and bad kernels and let's see what they look like.
> >
> > Thanks.
> >
> 
> I will try to reproduce it, but according to
> http://klive.cpushare.com/2.6.14-mm1/?order_by=kernel_group&where_machine=all&branch=mm&scheduler=all&smp=all&live=all&ip=all
> I have been using 2.6.14-mm1 about 48 hours with 12 reboots and this
> problem appeared only once.

ah-hah.  This sounds rather like Reuben Farrelly's e100 failure - something
seems to be making PCI initialisation go stupid if CONFIG_PREEMPT is
enabled.

It would be interesting if you could reboot sufficiently often to work out
whether disabling CONFIG_PREEMPT fixes things up.

