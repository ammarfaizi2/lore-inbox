Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261577AbULFSYq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261577AbULFSYq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 13:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261601AbULFSYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 13:24:45 -0500
Received: from the.earth.li ([193.201.200.66]:34024 "EHLO the.earth.li")
	by vger.kernel.org with ESMTP id S261577AbULFSYi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 13:24:38 -0500
Date: Mon, 6 Dec 2004 18:24:38 +0000
From: Jonathan McDowell <noodles@earth.li>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-parport@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] parport_pc MODULE_PARM fix
Message-ID: <20041206182438.GM10285@earth.li>
References: <20041206180242.GJ10285@earth.li> <41B49A63.6030104@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41B49A63.6030104@osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2004 at 09:44:03AM -0800, Randy.Dunlap wrote:
> Jonathan McDowell wrote:
> > ps2, epp, ecp or ecpepp)");
> >-MODULE_PARM(init_mode, "s");
> >+module_param_string(init_mode, init_mode, 7, 0);
> > #endif
> I think that it should be:
> 
> module_param(init_mode, charp, 0);
> 
> and leave 'init_mode' as a char *, not a char array.
> 
> Can you test that change and resubmit the patch (if it works :) ?

Even better; that does the trick too. Extremely trivial patch below.

Signed-Off-By: Jonathan McDowell <noodles@earth.li>

-----
--- drivers/parport/parport_pc.c.orig	2004-12-06 17:44:08.000000000 +0000
+++ drivers/parport/parport_pc.c	2004-12-06 18:18:43.000000000 +0000
@@ -3157,7 +3157,7 @@
 #ifdef CONFIG_PCI
 static int __init parport_init_mode_setup(char *str)
 {
-	printk(KERN_DEBUG "parport_pc.c: Specified parameter parport_init_mode=%s\n", str);
+	DPRINTK(KERN_DEBUG "parport_pc.c: Specified parameter parport_init_mode=%s\n", str);
 
 	if (!strcmp (str, "spp"))
 		parport_init_mode=1;
@@ -3193,7 +3193,7 @@
 #endif
 #ifdef CONFIG_PCI
 MODULE_PARM_DESC(init_mode, "Initialise mode for VIA VT8231 port (spp, ps2, epp, ecp or ecpepp)");
-MODULE_PARM(init_mode, "s");
+module_param(init_mode, charp, 0);
 #endif
 
 static int __init parse_parport_params(void)
-----

J.

-- 
/-\                             | 101 things you can't have too much
|@/  Debian GNU/Linux Developer |       of : 19 - A Good Thing.
\-                              |
