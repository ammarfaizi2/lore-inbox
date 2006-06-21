Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030329AbWFUV6I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030329AbWFUV6I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 17:58:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030327AbWFUV6F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 17:58:05 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:51978 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030325AbWFUV5y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 17:57:54 -0400
Date: Wed, 21 Jun 2006 23:57:53 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Jim Cromie <jim.cromie@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] gpio: make two mutexes static again
Message-ID: <20060621215753.GO9111@stusta.de>
References: <20060621034857.35cfe36f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060621034857.35cfe36f.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2006 at 03:48:57AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.17-rc6-mm2:
>...
> +chardev-gpio-for-scx200-pc-8736x-replace-spinlocks.patch
>...
>  GPIO driver framework.
>...

scx200_gpio_config_lock and pc8736x_gpio_config_lock became global 
without a good reason.
 
Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 arch/i386/kernel/scx200.c   |    2 +-
 drivers/char/pc8736x_gpio.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.17-mm1-full/arch/i386/kernel/scx200.c.old	2006-06-21 22:32:23.000000000 +0200
+++ linux-2.6.17-mm1-full/arch/i386/kernel/scx200.c	2006-06-21 22:32:32.000000000 +0200
@@ -46,7 +46,7 @@
 	.probe = scx200_probe,
 };
 
-DEFINE_MUTEX(scx200_gpio_config_lock);
+static DEFINE_MUTEX(scx200_gpio_config_lock);
 
 static void __devinit scx200_init_shadow(void)
 {
--- linux-2.6.17-mm1-full/drivers/char/pc8736x_gpio.c.old	2006-06-21 22:46:56.000000000 +0200
+++ linux-2.6.17-mm1-full/drivers/char/pc8736x_gpio.c	2006-06-21 22:47:05.000000000 +0200
@@ -32,7 +32,7 @@
 module_param(major, int, 0);
 MODULE_PARM_DESC(major, "Major device number");
 
-DEFINE_MUTEX(pc8736x_gpio_config_lock);
+static DEFINE_MUTEX(pc8736x_gpio_config_lock);
 static unsigned pc8736x_gpio_base;
 static u8 pc8736x_gpio_shadow[4];
 

