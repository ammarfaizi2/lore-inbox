Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261871AbTHaHrZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 03:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261897AbTHaHrY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 03:47:24 -0400
Received: from pentafluge.infradead.org ([213.86.99.235]:47777 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261871AbTHaHrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 03:47:23 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: cb-lkml@fish.zetnet.co.uk
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20030829184919.GA21155@xaqithis.com>
References: <20030829184919.GA21155@xaqithis.com>
Message-Id: <1062315980.32736.41.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Sun, 31 Aug 2003 09:46:21 +0200
X-SA-Exim-Mail-From: benh@kernel.crashing.org
Subject: Re: [2.6.0-test4] IDE power management
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-SA-Exim-Version: 3.0+cvs (built Mon Aug 18 15:53:30 BST 2003)
X-SA-Exim-Scanned: Yes
X-Pentafluge-Mail-From: <benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> hda: start_power_step(step: 0)
> hda: start_power_step(step: 1)
> hda: complete_power_step(step: 1, stat: 50, err:0)
> hda: completing PM request, suspend
> hda: a request made it's way while we are power managing
> --- power down/up occurs here
> hda: Wakeup request inited, waiting for !BSY...
> hda: start_power_step(step: 1000)
> hda: completing PM request, resume
> ...
> hda: lost interrupt
> 
> The hard disk won't allow any accesses any more.
> 
> APM suspend to RAM doesn't work properly on this machine, so I haven't
> tested that.

I'm afraid we may have APM junk getting in our way. It would be
interesting to check out what is the request that made its way while
power managing, though I usually consider this is harmless...

The lost interrupt problem may or may not be related, it could well
be an IRQ routing problem as well. Did you have DMA enabled ? What
happens if you disable that before suspend ? You can also add some
printk to piix_config_drive_xfer_rate() in piix.c to check if that
is properly getting called and doesn't fail.

Ben.


