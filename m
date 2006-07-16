Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751293AbWGPQuH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293AbWGPQuH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 12:50:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751597AbWGPQuH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 12:50:07 -0400
Received: from ns1.suse.de ([195.135.220.2]:43934 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751281AbWGPQuG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 12:50:06 -0400
Date: Sun, 16 Jul 2006 18:50:04 +0200
From: Olaf Hering <olh@suse.de>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: crash in aty128_set_lcd_enable on PowerBook
Message-ID: <20060716165004.GA16369@suse.de>
References: <20060716163728.GA16228@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20060716163728.GA16228@suse.de>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Sun, Jul 16, Olaf Hering wrote:

> 
> Current Linus tree crashes in aty128_set_lcd_enable() because par->pdev
> is NULL. This happens since at least a week. Call trace is:
> 
> aty128_set_lcd_enable
> aty128fb_set_par
> fbcon_init
> visual_init
> take_over_console
> fbcon_takeover
> notifier_call_chain
> blocking_notifier_call_chain
> register_framebuffer
> aty128fb_probe

aty128_init calls register_framebuffer() before it assigns pdev.

   2028         if (register_framebuffer(info) < 0)
   2029                 return 0;
   2030 
   2031         par->pm_reg = pci_find_capability(pdev, PCI_CAP_ID_PM);
   2032         par->pdev = pdev;
   2033         par->asleep = 0;
   2034         par->lock_blank = 0;


