Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261433AbVAXEBI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261433AbVAXEBI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 23:01:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261434AbVAXEBI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 23:01:08 -0500
Received: from gate.crashing.org ([63.228.1.57]:54448 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261433AbVAXEBE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 23:01:04 -0500
Subject: Re: Radeon framebuffer weirdness in -mm2
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Matt Mackall <mpm@selenic.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
In-Reply-To: <20050121060928.GI12076@waste.org>
References: <20050120232122.GF3867@waste.org>
	 <20050120153921.11d7c4fa.akpm@osdl.org> <20050120234844.GF12076@waste.org>
	 <20050120160123.14f13ca6.akpm@osdl.org> <20050121035758.GH12076@waste.org>
	 <20050120200530.4d5871f9.akpm@osdl.org>
	 <20050120200711.4313dbcc.akpm@osdl.org>  <20050121060928.GI12076@waste.org>
Content-Type: text/plain
Date: Mon, 24 Jan 2005 15:00:37 +1100
Message-Id: <1106539238.5210.16.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-01-20 at 22:09 -0800, Matt Mackall wrote:

> 
> It's something in this batch. Which is good, as I'd be a bit
> disappointed if the "vt leakage" were somehow attributable to the fb
> layer. More bisection after dinner.

Regarding the radeonfb reboot problem, can you try this patch on
top of -mm2 ?

--- linux-work.orig/drivers/video/aty/radeon_base.c	2005-01-24 12:19:09.000000000 +1100
+++ linux-work/drivers/video/aty/radeon_base.c	2005-01-24 14:59:14.000000000 +1100
@@ -2435,13 +2435,16 @@
  
 	radeonfb_pm_exit(rinfo);
 
+#if 0
 	/* restore original state
 	 * 
-	 * Doesn't quite work yet, possibly because of the PPC hacking
-	 * I do on startup, disable for now. --BenH
+	 * Doesn't quite work yet, I suspect if we come from a legacy
+	 * VGA mode (or worse, text mode), we need to do some VGA black
+	 * magic here that I know nothing about. --BenH
 	 */
         radeon_write_mode (rinfo, &rinfo->init_state, 1);
- 
+ #endif
+
 	del_timer_sync(&rinfo->lvds_timer);
 
 #ifdef CONFIG_MTRR


