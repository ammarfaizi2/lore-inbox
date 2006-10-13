Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751836AbWJMUZT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751836AbWJMUZT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 16:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751882AbWJMUZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 16:25:19 -0400
Received: from vena.lwn.net ([206.168.112.25]:42664 "HELO lwn.net")
	by vger.kernel.org with SMTP id S1751836AbWJMUZR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 16:25:17 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH,RFC] Add __GFP_ZERO to GFP_LEVEL_MASK
cc: akpm@osdl.org
From: Jonathan Corbet <corbet@lwn.net>
Date: Fri, 13 Oct 2006 14:25:16 -0600
Message-ID: <28729.1160771116@lwn.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is a very helpful comment in <linux/gfp.h>:

  /* if you forget to add the bitmask here kernel will crash, period */

Well, my kernel has been crashing (period) at the BUG() in cache_grow();
the offending flag is __GFP_ZERO.  I think it needs to be in
GFP_LEVEL_MASK.  Anybody know a good reason why it's not there now?

jon


Add __GFP_ZERO to GFP_LEVEL_MASK and cut down on those unsightly oopses.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>

--- /k/t/2.6.19-rc2/include/linux/gfp.h	2006-10-13 13:04:17.000000000 -0600
+++ 19-rc2.jc/include/linux/gfp.h	2006-10-13 14:17:10.000000000 -0600
@@ -54,7 +54,8 @@ struct vm_area_struct;
 #define GFP_LEVEL_MASK (__GFP_WAIT|__GFP_HIGH|__GFP_IO|__GFP_FS| \
 			__GFP_COLD|__GFP_NOWARN|__GFP_REPEAT| \
 			__GFP_NOFAIL|__GFP_NORETRY|__GFP_NO_GROW|__GFP_COMP| \
-			__GFP_NOMEMALLOC|__GFP_HARDWALL|__GFP_THISNODE)
+			__GFP_ZERO|__GFP_NOMEMALLOC|__GFP_HARDWALL|\
+			__GFP_THISNODE)
 
 /* This equals 0, but use constants in case they ever change */
 #define GFP_NOWAIT	(GFP_ATOMIC & ~__GFP_HIGH)
