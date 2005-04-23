Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262186AbVDWXxY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262186AbVDWXxY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 19:53:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262187AbVDWXxY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 19:53:24 -0400
Received: from fire.osdl.org ([65.172.181.4]:64211 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262186AbVDWXxU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 19:53:20 -0400
Date: Sat, 23 Apr 2005 16:49:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [2.6 patch] unexport is_console_locked
Message-Id: <20050423164948.652cc82b.akpm@osdl.org>
In-Reply-To: <20050415151045.GK5456@stusta.de>
References: <20050415151045.GK5456@stusta.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:
>
> I didn't find any possible modular usage in the kernel.
> 

Is needed for WARN_CONSOLE_UNLOCKED().

It just happens that WARN_CONSOLE_UNLOCKED() is currently only using in
vt.c, which just happens to not support modular usage.

But disabling this export would make WARN_CONSOLE_UNLOCKED() pretty useless
for driver development.

So I'd suggest that we either leave this symbol exported for driver
developers or we nuke WARN_CONSOLE_UNLOCKED() altogether.

Ben, do you still want it?


> --- linux-2.6.11-rc5-mm1-full/kernel/printk.c.old	2005-03-04 00:58:16.000000000 +0100
> +++ linux-2.6.11-rc5-mm1-full/kernel/printk.c	2005-03-04 00:58:22.000000000 +0100
> @@ -675,7 +675,6 @@
>  {
>  	return console_locked;
>  }
> -EXPORT_SYMBOL(is_console_locked);
>  
>  /**
>   * release_console_sem - unlock the console system
