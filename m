Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261737AbVACSRg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261737AbVACSRg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 13:17:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261525AbVACSNy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 13:13:54 -0500
Received: from holomorphy.com ([207.189.100.168]:1181 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261757AbVACSLq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 13:11:46 -0500
Date: Mon, 3 Jan 2005 10:11:44 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: Re: [8/8] fix module_param() type mismatch in drivers/char/n_hdlc.c
Message-ID: <20050103181144.GL29332@holomorphy.com>
References: <20050103172013.GA29332@holomorphy.com> <20050103172303.GB29332@holomorphy.com> <20050103172615.GD29332@holomorphy.com> <20050103172839.GE29332@holomorphy.com> <20050103173406.GF29332@holomorphy.com> <20050103173643.GG29332@holomorphy.com> <20050103173952.GH29332@holomorphy.com> <20050103174521.GI29332@holomorphy.com> <20050103174713.GJ29332@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050103174713.GJ29332@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 03, 2005 at 09:47:13AM -0800, William Lee Irwin III wrote:
> maxframe is a variable of type ssize_t; this patch repairs the warning
> arising from the type mismatch in the module_param() declaration.
> Signed-off-by: William Irwin <wli@holomorphy.com>

I flubbed the testing cycle for that patch only. The following patch
should be applied instead.

Index: mm1-2.6.10/drivers/char/n_hdlc.c
===================================================================
--- mm1-2.6.10.orig/drivers/char/n_hdlc.c	2005-01-03 06:46:06.000000000 -0800
+++ mm1-2.6.10/drivers/char/n_hdlc.c	2005-01-03 09:38:17.000000000 -0800
@@ -177,7 +177,7 @@
 static int debuglevel;
 
 /* max frame size for memory allocations */
-static ssize_t maxframe = 4096;
+static int maxframe = 4096;
 
 /* TTY callbacks */
 
@@ -672,7 +672,7 @@
 		if (debuglevel & DEBUG_LEVEL_INFO)
 			printk (KERN_WARNING
 				"n_hdlc_tty_write: truncating user packet "
-				"from %lu to %Zd\n", (unsigned long) count,
+				"from %lu to %d\n", (unsigned long) count,
 				maxframe );
 		count = maxframe;
 	}
