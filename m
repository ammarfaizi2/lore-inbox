Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268386AbTCCHJt>; Mon, 3 Mar 2003 02:09:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268396AbTCCHJt>; Mon, 3 Mar 2003 02:09:49 -0500
Received: from natsmtp00.webmailer.de ([192.67.198.74]:21223 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S268386AbTCCHJs>; Mon, 3 Mar 2003 02:09:48 -0500
Date: Mon, 3 Mar 2003 08:18:55 +0100
From: Dominik Brodowski <linux@brodo.de>
To: generica@email.com, linux-kernel@vger.kernel.org
Subject: [PATCH] Re: pcmcia no worky in 2.5.6[32]
Message-ID: <20030303071855.GA1224@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hey,
> 
> since 2.5.62, I've not been able to get pcmcia working.
> 
> Hardware: toshiba 100CS
> 
> I've attached my .config for 2.5.63,
> and a dmesg directly after boot for 2.5.61 and 2.5.63
> 
> any other details needed, please let me know
> 
> thanks,
> 
> 	/ Brett

Could you please try this patch? It *should* fix this problem:

--- linux/drivers/pcmcia/i82365.c.original	2003-02-26 09:45:00.000000000 +0100
+++ linux/drivers/pcmcia/i82365.c	2003-03-03 08:14:29.000000000 +0100
@@ -1628,11 +1628,11 @@
 	request_irq(cs_irq, pcic_interrupt, 0, "i82365", pcic_interrupt);
 #endif
     
-    platform_device_register(&i82365_device);
-
     i82365_data.nsock = sockets;
     i82365_device.dev.class_data = &i82365_data;
-    
+
+    platform_device_register(&i82365_device);
+
     /* Finally, schedule a polling interrupt */
     if (poll_interval != 0) {
 	poll_timer.function = pcic_interrupt_wrapper;

