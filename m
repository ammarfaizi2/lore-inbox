Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030406AbWF0WBs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030406AbWF0WBs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 18:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030411AbWF0WBs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 18:01:48 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:6097 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030406AbWF0WBr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 18:01:47 -0400
From: hawkes@sgi.com
To: Tony Luck <tony.luck@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jack Steiner <steiner@sgi.com>, Dan Higgins <djh@sgi.com>, hawkes@sgi.com,
       Jeremy Higdon <jeremy@sgi.com>
Date: Tue, 27 Jun 2006 15:01:39 -0700
Message-Id: <20060627220139.3168.69409.sendpatchset@tomahawk.engr.sgi.com>
Subject: [PATCH] ia64: change usermode HZ to 250
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

include/asm-ia64/param.h defines HZ to be 1024 for usermode use, i.e.,
when the file gets installed as /usr/include/asm/param.h.
As the comment says:
    Technically, this is wrong, but some old apps still refer to it.  
    The proper way to get the HZ value is via sysconf(_SC_CLK_TCK).
At the very least, this technically wrong #define ought to reflect the
current default value (250) used by all arch/ia64 platforms.  No one uses
1024 anymore.  This makes those "old apps" (e.g., usr/bin/iostat) behave
properly for with a default kernel.  (And at some point, the define ought
to be removed altogether, which would expose all the applications that
erroneously expect HZ to be a compile-time constant.)

Signed-off-by: John Hawkes <hawkes@sgi.com>

Index: linux/include/asm-ia64/param.h
===================================================================
--- linux.orig/include/asm-ia64/param.h	2006-06-17 18:49:35.000000000 -0700
+++ linux/include/asm-ia64/param.h	2006-06-27 14:46:53.119407077 -0700
@@ -36,7 +36,7 @@
     * Technically, this is wrong, but some old apps still refer to it.  The proper way to
     * get the HZ value is via sysconf(_SC_CLK_TCK).
     */
-# define HZ 1024
+# define HZ 250
 #endif
 
 #endif /* _ASM_IA64_PARAM_H */
