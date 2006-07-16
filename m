Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751018AbWGPTTk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751018AbWGPTTk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 15:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbWGPTTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 15:19:40 -0400
Received: from gate.crashing.org ([63.228.1.57]:56223 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751018AbWGPTTj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 15:19:39 -0400
Subject: Re: crash in aty128_set_lcd_enable on PowerBook
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olaf Hering <olh@suse.de>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
In-Reply-To: <20060716165004.GA16369@suse.de>
References: <20060716163728.GA16228@suse.de>
	 <20060716165004.GA16369@suse.de>
Content-Type: text/plain
Date: Sun, 16 Jul 2006 15:19:09 -0400
Message-Id: <1153077550.5905.33.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-07-16 at 18:50 +0200, Olaf Hering wrote:
>  On Sun, Jul 16, Olaf Hering wrote:
> 
> > 
> > Current Linus tree crashes in aty128_set_lcd_enable() because par->pdev
> > is NULL. This happens since at least a week. Call trace is:
> > 
> > aty128_set_lcd_enable
> > aty128fb_set_par
> > fbcon_init
> > visual_init
> > take_over_console
> > fbcon_takeover
> > notifier_call_chain
> > blocking_notifier_call_chain
> > register_framebuffer
> > aty128fb_probe
> 
> aty128_init calls register_framebuffer() before it assigns pdev.

Yeah, that looks like some serious bogosity in that code. Care to send a
patch ?

>    2028         if (register_framebuffer(info) < 0)
>    2029                 return 0;
>    2030 
>    2031         par->pm_reg = pci_find_capability(pdev, PCI_CAP_ID_PM);
>    2032         par->pdev = pdev;
>    2033         par->asleep = 0;
>    2034         par->lock_blank = 0;
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev

