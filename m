Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265352AbUAPRDo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 12:03:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265379AbUAPRDo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 12:03:44 -0500
Received: from fw.osdl.org ([65.172.181.6]:39335 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265352AbUAPRDn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 12:03:43 -0500
Date: Fri, 16 Jan 2004 09:03:49 -0800
From: Andrew Morton <akpm@osdl.org>
To: Fabian Fenaut <fabian.fenaut@free.fr>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Gerd Knorr <kraxel@bytesex.org>
Subject: Re: 2.6.1-mm4
Message-Id: <20040116090349.73b1fad4.akpm@osdl.org>
In-Reply-To: <200401161449.i0GEnoAv026627@fire-1.osdl.org>
References: <20040115225948.6b994a48.akpm@osdl.org>
	<200401161449.i0GEnoAv026627@fire-1.osdl.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fabian Fenaut <fabian.fenaut@free.fr> wrote:
>
> I got an error compiling -mm4 :
> 
>     [...]
>     CC [M]  drivers/media/video/ir-kbd-gpio.o
>  drivers/media/video/ir-kbd-gpio.c:185: unknown field `name' specified in
>  initializer
>  drivers/media/video/ir-kbd-gpio.c:185: warning: missing braces around
>  initializer
>  drivers/media/video/ir-kbd-gpio.c:185: warning: (near initialization for
>  `driver.drv')
>  drivers/media/video/ir-kbd-gpio.c:186: unknown field `drv' specified in
>  initializer
>  drivers/media/video/ir-kbd-gpio.c:187: unknown field `drv' specified in
>  initializer
>  drivers/media/video/ir-kbd-gpio.c:188: unknown field `gpio_irq'
>  specified in initializer

You must be using an elderly gcc.


diff -puN drivers/media/video/ir-kbd-gpio.c~ir-kbd-gpio-build-fix drivers/media/video/ir-kbd-gpio.c
--- 25/drivers/media/video/ir-kbd-gpio.c~ir-kbd-gpio-build-fix	2004-01-16 09:01:59.000000000 -0800
+++ 25-akpm/drivers/media/video/ir-kbd-gpio.c	2004-01-16 09:02:17.000000000 -0800
@@ -182,9 +182,11 @@ static int ir_probe(struct device *dev);
 static int ir_remove(struct device *dev);
 
 static struct bttv_sub_driver driver = {
-	.drv.name	= DEVNAME,
-	.drv.probe	= ir_probe,
-	.drv.remove	= ir_remove,
+	.drv = {
+		.name	= DEVNAME,
+		.probe	= ir_probe,
+		.remove	= ir_remove,
+	},
 	.gpio_irq       = ir_irq,
 };
 

_

