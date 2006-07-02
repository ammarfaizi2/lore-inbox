Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750989AbWGBNaf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750989AbWGBNaf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 09:30:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751230AbWGBNaf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 09:30:35 -0400
Received: from titanium.sabren.com ([67.19.173.4]:38576 "EHLO
	titanium.sabren.com") by vger.kernel.org with ESMTP
	id S1750989AbWGBNae (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 09:30:34 -0400
Date: Sun, 2 Jul 2006 15:30:30 +0200
From: Grzegorz Adam Hankiewicz <gradha@titanium.sabren.com>
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Linux kernel 2.6.10 sata_nv.c stops working on my hardware
Message-ID: <20060702133030.GA2606@noir>
Reply-To: linux-kernel@vger.kernel.org
Mail-Followup-To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <20060626192309.GA10711@noir> <DBFABB80F7FD3143A911F9E6CFD477B00E48CF38@hqemmail02.nvidia.com> <20060627213451.GA2443@noir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060627213451.GA2443@noir>
X-Accept-Language: es,en
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006-06-27, Grzegorz Adam Hankiewicz <gradha@titanium.sabren.com> wrote:
> On 2006-06-26, Allen Martin <AMartin@nvidia.com> wrote:
> >  static struct ata_port_info nv_port_info = {
> >         .sht            = &nv_sht,
> >         .host_flags     = ATA_FLAG_SATA |
> > -                         ATA_FLAG_SATA_RESET |
> > +                         /* ATA_FLAG_SATA_RESET | */
> >                           ATA_FLAG_SRST |
> >                           ATA_FLAG_NO_LEGACY,
> >         .pio_mask       = NV_PIO_MASK,
> 
> Actually the change you proposed works on my system. A 2.6.10
> with the ATA_FLAG_SATA_RESET works.  I did the same to a 2.6.16
> kernel but there it didn't work. I guess something else was
> introduced between 2.6.10 and 2.6.16.  I'll start recompiling
> again everything from 2.6.10 up to 2.6.16 with that flag turned
> on to see where it stops working again.

I recompiled all kernels from 2.6.11 to 2.6.16 with the
ATA_FLAG_SATA_RESET and was able to boot up to 2.6.12.  2.6.13 would
hang mounting ext3. This is bad news though, a sata_nv.c diff between
2.6.12 and 2.6.13 shows no changes. Which I guess it means there's
nothing wrong with sata_nv.c.

I would understand now that the ATA_FLAG_SATA_RESET introduced in
2.6.10 just highlighted another bug somewhere else which affects
my machine, and I would need to look at other changes between 2.6.9
and 2.6.10. What should I do now?

Another thing I have discovered is that if I boot with a Knoppix
5 (kernel 2.6.17 I believe) and mount the sata drives read only,
there is no problem with them. I can read their whole contents,
really fast, without hiccups. It's at the point of using fdisk on
them or trying to mount them as writeable that the commands hang.
