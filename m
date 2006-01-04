Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751262AbWADOvk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751262AbWADOvk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 09:51:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750817AbWADOvk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 09:51:40 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:65287 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751262AbWADOvj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 09:51:39 -0500
Date: Wed, 4 Jan 2006 15:51:38 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] i386: enable 4k stacks by default
Message-ID: <20060104145138.GN3831@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables 4k stacks by default.

4k stacks have become a well-tested feature used fore a long time in 
Fedora and even in RHEL 4.

There are no known problems in in-kernel code with 4k stacks still 
present after Neil's patch that went into -mm nearly two months ago.

Defaulting to 4k stacks in -mm kernel will give some more testing 
coverage and should show whether there are really no problems left.

Keeping the option for now should make the people happy who want to use 
the experimental -mm kernel but don't trust the well-tested 4k stacks.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.15-rc5-mm3-full/arch/i386/Kconfig.debug.old	2006-01-04 11:43:55.000000000 +0100
+++ linux-2.6.15-rc5-mm3-full/arch/i386/Kconfig.debug	2006-01-04 11:44:14.000000000 +0100
@@ -53,8 +53,8 @@
 	  If in doubt, say "N".
 
 config 4KSTACKS
-	bool "Use 4Kb for kernel stacks instead of 8Kb"
-	depends on DEBUG_KERNEL
+	bool "Use 4Kb for kernel stacks instead of 8Kb" if DEBUG_KERNEL
+	default y
 	help
 	  If you say Y here the kernel will use a 4Kb stacksize for the
 	  kernel stack attached to each process/thread. This facilitates
