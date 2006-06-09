Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030313AbWFIUGX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030313AbWFIUGX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 16:06:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030470AbWFIUGX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 16:06:23 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:35475 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1030313AbWFIUGW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 16:06:22 -0400
Date: Fri, 9 Jun 2006 22:05:50 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "s.a." <sancelot@free.fr>
cc: linux-kernel@vger.kernel.org
Subject: Re: Caching kernel messages at boot w/PATCH
In-Reply-To: <448991CD.9070404@free.fr>
Message-ID: <Pine.LNX.4.61.0606092157080.8951@yvahk01.tjqt.qr>
References: <448991CD.9070404@free.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hi,
>Is there a way to hide the kernel messages from the screen at boot ?
>Best Regards
>Steph
>
Except for the sole "quiet" flag, I have this in my kernel tree:

AS_13-conlevel.diff
diff --fast -Ndpru linux-2.6.17-rc6~/kernel/printk.c linux-2.6.17-rc6+/kernel/printk.c
--- linux-2.6.17-rc6~/kernel/printk.c	2006-06-06 02:57:02.000000000 +0200
+++ linux-2.6.17-rc6+/kernel/printk.c	2006-06-08 22:24:16.847058000 +0200
@@ -697,6 +697,14 @@ int __init add_preferred_console(char *n
 	return 0;
 }
 
+static __init int set_conlevel(char *str) {
+    if(*str >= '0' && *str <= '9')
+        *console_printk = *str - '0';
+    return 1;
+}
+
+__setup("conlevel=", set_conlevel);
+
 /**
  * acquire_console_sem - lock the console system for exclusive use.
  *
#<<eof>>

It allows one to finely specify how much noise or silence the user wants.
conlevel=4 makes it quite silent (still shows some minor erros [1]), and 
decreasing that of course will make it even more silent.

[1]
sda: asking for cache data failed
sda: assuming drive cache: write through
piix4_smbus 0000:00:07.3: Host SMBus controller not enabled!

These three are then gone for me with conlevel=3. dmesg still 
records all messages (a good thing(tm)).


Jan Engelhardt
-- 
