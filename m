Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262156AbUKVQa3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262156AbUKVQa3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 11:30:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262191AbUKVQaM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 11:30:12 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:2833 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261460AbUKVP4X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 10:56:23 -0500
Date: Mon, 22 Nov 2004 16:56:19 +0100
From: Adrian Bunk <bunk@stusta.de>
To: rusty@rustcorp.com.au, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] MODULE_PARM_: remove the __deprecated
Message-ID: <20041122155619.GG19419@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rusty,

I know you will not like this patch, but I consider it important since 
the current beghavior is pretty annoying.

When making patches here and there, I'm touching many different places 
in the kernel. One of the advantages of the 2.6 build system is that 
warnings are very visible - and often a new compile warning indicates 
that something with the patch is wrong.

MODULE_PARM_ might be deprecated.
But there are still over 2000 places in the kernel where it's used.
I consider it _very_ annoying if after changing the kernel, the whole 
screen is swamped with warnings that MODULE_PARM_ is deprecated as it 
still happens in several subsystems. That's quite annoying if you want 
to check whether changing a common header file has any negative effects.

This is not generally against using __deprecated, but currently 
MODULE_PARM_ generates so many warnings that it's really no fun.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm3-modular/include/linux/module.h.old	2004-11-22 15:51:17.000000000 +0100
+++ linux-2.6.10-rc2-mm3-modular/include/linux/module.h	2004-11-22 15:53:29.000000000 +0100
@@ -559,7 +559,7 @@
 	void *addr;
 };
 
-static inline void __deprecated MODULE_PARM_(void) { }
+static inline void MODULE_PARM_(void) { }
 #ifdef MODULE
 /* DEPRECATED: Do not use. */
 #define MODULE_PARM(var,type)						    \

