Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264457AbUBOKvR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 05:51:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264479AbUBOKvR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 05:51:17 -0500
Received: from av5-1-sn3.vrr.skanova.net ([81.228.9.113]:29125 "EHLO
	av5-1-sn3.vrr.skanova.net") by vger.kernel.org with ESMTP
	id S264457AbUBOKvP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 05:51:15 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.3-rc3
References: <Pine.LNX.4.58.0402141931050.14025@home.osdl.org>
	<m2znbk4s8j.fsf@p4.localdomain> <1076838882.6957.48.camel@gaston>
	<1076840755.6949.50.camel@gaston>
From: Peter Osterlund <petero2@telia.com>
Date: 15 Feb 2004 11:51:11 +0100
In-Reply-To: <1076840755.6949.50.camel@gaston>
Message-ID: <m2k72o4nvk.fsf@p4.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> > > It doesn't seem to work on my x86 laptop. The screen goes black when
> > > the framebuffer is enabled early in the boot sequence. The machine
> > > boots normally anyway and I can log in from the network or log in
> > > blindly at the console. I can then start the X server which appears to
> > > work correctly, but switching back to a console still gives me a black
> > > screen. Running "setfont" doesn't fix it. Here is what dmesg reports
> > > when running 2.6.3-rc3:
> > 
> > Did it ever work ? (I need to know if it's a regression or some problem
> > that was already there in the first place). (Hrm... looking at the end
> > of your mail, it indeed seem to be a regression with this version)
> 
> BTW. This is the reason I left the "old" driver in, you can still
> build it if the new ones goes wrong. 

Yes, you can still build the old driver, but it doesn't work unless
you also apply this patch:

--- linux/drivers/video/fbmem.c.old	2004-02-15 11:47:26.000000000 +0100
+++ linux/drivers/video/fbmem.c	2004-02-15 11:43:42.000000000 +0100
@@ -222,6 +222,9 @@
 #ifdef CONFIG_FB_RADEON
 	{ "radeonfb", radeonfb_init, radeonfb_setup },
 #endif
+#ifdef CONFIG_FB_RADEON_OLD
+	{ "radeonfb_old", radeonfb_init, radeonfb_setup },
+#endif
 #ifdef CONFIG_FB_CONTROL
 	{ "controlfb", control_init, control_setup },
 #endif

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
