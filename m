Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262798AbVDHMcn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262798AbVDHMcn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 08:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262800AbVDHMcn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 08:32:43 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:13196 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262798AbVDHMcW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 08:32:22 -0400
Date: Fri, 8 Apr 2005 14:31:44 +0200
From: Pavel Machek <pavel@suse.cz>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       FrameBuffer Devel <linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [PATCH] pm_message_t corrections still missing from 2.6.12-rc2
Message-ID: <20050408123144.GB1379@elf.ucw.cz>
References: <1112961860.3757.755.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112961860.3757.755.camel@desktop.cunningham.myip.net.au>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Here, for your consideration, are fixups I still have in my tree after
> updating to rc2.
> 
> (USB & Framebuffer lists copied because a reasonable number apply
> there).
> 
> Regards,
> 
> Nigel
> 
> diff -ruNp 840-combined-pm_message_t-patch.patch-old/drivers/base/power/resume.c 840-combined-pm_message_t-patch.patch-new/drivers/base/power/resume.c
> --- 840-combined-pm_message_t-patch.patch-old/drivers/base/power/resume.c	2004-12-10 14:26:51.000000000 +1100
> +++ 840-combined-pm_message_t-patch.patch-new/drivers/base/power/resume.c	2005-04-08 13:41:41.000000000 +1000
> @@ -41,7 +41,7 @@ void dpm_resume(void)
>  		list_add_tail(entry, &dpm_active);
>  
>  		up(&dpm_list_sem);
> -		if (!dev->power.prev_state)
> +		if (!dev->power.prev_state.event)
>  			resume_device(dev);
>  		down(&dpm_list_sem);
>  		put_device(dev);

We do not want these to go anywhere for now. These depend on switching
pm_message_t to struct, and that's 2.6.13 material.

Except that, there are some good fixes (u32->pm_message_t), but they
should be in -mm kernel already.

...except USB. I'm talking with David Brownell about those.

								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
