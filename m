Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263347AbTJVIkq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 04:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263452AbTJVIkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 04:40:45 -0400
Received: from cpc1-cmbg5-6-0-cust223.cmbg.cable.ntl.com ([81.104.201.223]:35576
	"EHLO flat") by vger.kernel.org with ESMTP id S263347AbTJVIko (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 04:40:44 -0400
Date: Wed, 22 Oct 2003 09:40:46 +0100
From: Charlie Baylis <cb-lkml@fish.zetnet.co.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.0-test4] IDE power management
Message-ID: <20031022084046.GA5957@flat>
References: <20030829184919.GA21155@xaqithis.com> <1062315980.32736.41.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1062315980.32736.41.camel@gaston>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 31, 2003 at 09:46:21AM +0200, Benjamin Herrenschmidt wrote:
> 
> > hda: start_power_step(step: 0)
> > hda: start_power_step(step: 1)
> > hda: complete_power_step(step: 1, stat: 50, err:0)
> > hda: completing PM request, suspend
> > hda: a request made it's way while we are power managing
> > --- power down/up occurs here
> > hda: Wakeup request inited, waiting for !BSY...
> > hda: start_power_step(step: 1000)
> > hda: completing PM request, resume
> > ...
> > hda: lost interrupt
> > 
> > The hard disk won't allow any accesses any more.
> > 
> > APM suspend to RAM doesn't work properly on this machine, so I haven't
> > tested that.
> 
> I'm afraid we may have APM junk getting in our way. It would be
> interesting to check out what is the request that made its way while
> power managing, though I usually consider this is harmless...
> 
> The lost interrupt problem may or may not be related, it could well
> be an IRQ routing problem as well. Did you have DMA enabled ? What
> happens if you disable that before suspend ? You can also add some
> printk to piix_config_drive_xfer_rate() in piix.c to check if that
> is properly getting called and doesn't fail.

I didn't get time to do this before the disk in my laptop died. I've put it a
new disk and installed 2.6.0-test7, and IDE now seems to works after a resume.

I think the disk is still spinning down before suspend (it's difficult to tell,
because I can hardly hear the new disk) and this needs to be fixed at some
point.

Regards
Charlie
