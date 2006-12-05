Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968352AbWLEFI7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968352AbWLEFI7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 00:08:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968358AbWLEFI7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 00:08:59 -0500
Received: from www.tuxrocks.com ([64.62.190.123]:2374 "EHLO tuxrocks.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S968352AbWLEFI7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 00:08:59 -0500
Message-ID: <4574FEDF.2010205@tuxrocks.com>
Date: Mon, 04 Dec 2006 23:08:47 -0600
From: Frank Sorenson <frank@tuxrocks.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: art@usfltd.com
CC: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: [PATCH] Re: 2.6.19 git compile error - "current_is_keventd"	[drivers/net/phy/libphy.ko]
 undefined
References: <20061204180731.jeedbekf4f0g8ww0@69.222.0.225>
In-Reply-To: <20061204180731.jeedbekf4f0g8ww0@69.222.0.225>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

art@usfltd.com wrote:
> to: linux-kernel@vger.kernel.org
> cc: torvalds@osdl.org
> 
> 2006/12/04/18:00 CST
> 
>   Building modules, stage 2.
> Kernel: arch/x86_64/boot/bzImage is ready  (#2)
>   MODPOST 1256 modules
> WARNING: "current_is_keventd" [drivers/net/phy/libphy.ko] undefined!
> make[1]: *** [__modpost] Error 1
> make: *** [modules] Error 2
> 
> xboom

Here's a patch with the easy fix, but I'm not certain it's a permanent fix.

Frank

This patch fixes a compile error when CONFIG_PHYLIB is a module.

Signed-off-by: Frank Sorenson <frank@tuxrocks.com>

---
  kernel/workqueue.c |    1 +
  1 file changed, 1 insertion(+)

Index: linux-2.6.19-fs1/kernel/workqueue.c
===================================================================
--- linux-2.6.19-fs1.orig/kernel/workqueue.c	2006-12-04 
22:21:06.000000000 -0600
+++ linux-2.6.19-fs1/kernel/workqueue.c	2006-12-04 22:59:55.000000000 -0600
@@ -608,6 +608,7 @@
  	return ret;

  }
+EXPORT_SYMBOL_GPL(current_is_keventd);

  #ifdef CONFIG_HOTPLUG_CPU
  /* Take the work from this (downed) CPU. */
