Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945937AbWGOAfz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945937AbWGOAfz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 20:35:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945938AbWGOAfs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 20:35:48 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:29705 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1945937AbWGOAf3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 20:35:29 -0400
Date: Sat, 15 Jul 2006 02:35:27 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Jim Cromie <jim.cromie@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] drivers/char/pc8736x_gpio.c: unexport a static struct
Message-ID: <20060715003527.GG3633@stusta.de>
References: <20060713224800.6cbdbf5d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060713224800.6cbdbf5d.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2006 at 10:48:00PM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.18-rc1-mm1:
>...
> +gpio-rename-exported-vtables-to-better-match.patch
>...
>  Misc fixes and updates and cleanups.
>...

A static struct mustn't be exported.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.18-rc1-mm2-full/drivers/char/pc8736x_gpio.c.old	2006-07-14 22:27:28.000000000 +0200
+++ linux-2.6.18-rc1-mm2-full/drivers/char/pc8736x_gpio.c	2006-07-14 22:27:42.000000000 +0200
@@ -215,19 +215,18 @@
 static struct nsc_gpio_ops pc8736x_gpio_ops = {
 	.owner		= THIS_MODULE,
 	.gpio_config	= pc8736x_gpio_configure,
 	.gpio_dump	= nsc_gpio_dump,
 	.gpio_get	= pc8736x_gpio_get,
 	.gpio_set	= pc8736x_gpio_set,
 	.gpio_change	= pc8736x_gpio_change,
 	.gpio_current	= pc8736x_gpio_current
 };
-EXPORT_SYMBOL(pc8736x_gpio_ops);
 
 static int pc8736x_gpio_open(struct inode *inode, struct file *file)
 {
 	unsigned m = iminor(inode);
 	file->private_data = &pc8736x_gpio_ops;
 
 	dev_dbg(&pdev->dev, "open %d\n", m);
 
 	if (m >= PC8736X_GPIO_CT)

