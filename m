Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261422AbVETNkk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261422AbVETNkk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 09:40:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261430AbVETNkk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 09:40:40 -0400
Received: from run.smurf.noris.de ([192.109.102.41]:45998 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S261422AbVETNkb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 09:40:31 -0400
Date: Fri, 20 May 2005 15:40:12 +0200
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Turn off sibling call optimization w/ frame pointers
Message-ID: <20050520134012.GE16992@kiste.smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.5.6+20040907i
From: Matthias Urlichs <smurf@smurf.noris.de>
X-Smurf-Spam-Score: -2.5 (--)
X-Smurf-Whitelist: +relay_from_hosts
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frame pointers are supposed to enable debuggers to reliably tell
where a call comes from. That is defeated by GCC's sibling call
optimization (aka tail recursion elimination).

This patch turns this optimization off when compiling with frame pointers.

Signed-Off-By: Matthias Urlichs <smurf@smurf.noris.de>

---
Index: Makefile
===================================================================
--- cf96cb2bd8bb633b174549815ad3c45f65ae2848/Makefile  (mode:100644)
+++ df32987da12629d4a4498fc8948bf11b1a49d377/Makefile  (mode:100644)
@@ -518,7 +518,7 @@
 CFLAGS		+= $(call add-align,CONFIG_CC_ALIGN_JUMPS,-jumps)
 
 ifdef CONFIG_FRAME_POINTER
-CFLAGS		+= -fno-omit-frame-pointer
+CFLAGS		+= -fno-omit-frame-pointer $(call cc-option,-fno-optimize-sibling-calls,)
 else
 CFLAGS		+= -fomit-frame-pointer
 endif
