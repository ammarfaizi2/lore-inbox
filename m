Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272485AbTHKLLR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 07:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272500AbTHKLLR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 07:11:17 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:62358 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S272485AbTHKLLP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 07:11:15 -0400
Date: Mon, 11 Aug 2003 13:10:56 +0200
From: Pavel Machek <pavel@suse.cz>
To: Pavel Machek <pavel@suse.cz>
Cc: Flameeyes <dgp85@users.sourceforge.net>,
       LKML <linux-kernel@vger.kernel.org>,
       LIRC list <lirc-list@lists.sourceforge.net>
Subject: Re: [PATCH] lirc for 2.5/2.6 kernels - 20030802
Message-ID: <20030811111056.GA400@elf.ucw.cz>
References: <1059820741.3116.24.camel@laurelin> <20030807214311.GC211@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030807214311.GC211@elf.ucw.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > This is the fourth version of my patch for use LIRC drivers under
> > 2.5/2.6 kernels.
> > 
> > As usual, you can find it at
> > http://flameeyes.web.ctonet.it/lirc/patch-lirc-20030802.diff.bz2
> > 
> > I changed the naming scheme, because I tried and the patch applies also
> > in earliers and (probably) futures kernels, and call it only
> > "patch-lirc.diff" will confuse about the versions. I think a datestamp
> > is the best choice for now.
> 
> If you want to get this applied to the official tree (I hope you want
> ;-), you probably should start with smaller patch. I killed all
> drivers but lirc_gpio, to make patch smaller/easier to check.
> 
> Its now small enough to inline, and that's good. 
> 
> Few questions:
> 
> * What does "For now don't try to use as static version" comment in
>   lirc_gpio mean. Does it only work as a module?

Here's fix for that particular uglyness. I tested lirc_gpio and it
actually works here. Good. Please apply this,

								Pavel
--- linux-lirc/drivers/char/lirc/lirc_gpio.c.ofic	2003-08-10 23:44:28.000000000 +0200
+++ linux-lirc/drivers/char/lirc/lirc_gpio.c	2003-08-10 23:45:02.000000000 +0200
@@ -530,13 +530,16 @@
 
 	dprintk(LOGHEAD "module successfully unloaded\n", minor);
 }
-/* Dont try to use it as a static version !  */
 
 MODULE_DESCRIPTION("Driver module for remote control (data from bt848 GPIO port)");
 MODULE_AUTHOR("Artur Lipowski");
 MODULE_LICENSE("GPL");
 
+#ifdef MODULE
 module_init(lirc_gpio_init);
+#else
+late_initcall(lirc_gpio_init);
+#endif
 module_exit(lirc_gpio_exit);
 
 /*

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
