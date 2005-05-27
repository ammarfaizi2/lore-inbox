Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262458AbVE0M4o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262458AbVE0M4o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 08:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262459AbVE0MyZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 08:54:25 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:16054 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262458AbVE0MyC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 08:54:02 -0400
Date: Fri, 27 May 2005 14:07:27 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: [patch] swsusp: only allow it when it makes sense
Message-ID: <20050527120727.GB2088@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Show swsuspend only on .config where it can compile.
I got this on PPC32 && SMP:

kernel/power/smp.c:24: error: storage size of `ctxt' isn't known

Also mark swsusp as no longer experimental.

Signed-off-by: Olaf Hering <olh@suse.de>
Signed-off-by: Pavel Machek <pavel@suse.cz>

--- /data/l/clean-cg//kernel/power/Kconfig	2005-04-27 14:53:49.000000000 +0200
+++ linux-good/kernel/power/Kconfig	2005-05-26 15:54:48.000000000 +0200
@@ -27,8 +27,8 @@
 	like suspend support.
 
 config SOFTWARE_SUSPEND
-	bool "Software Suspend (EXPERIMENTAL)"
-	depends on EXPERIMENTAL && PM && SWAP
+	bool "Software Suspend"
+	depends on PM && SWAP && ((X86 && SMP) || ((FVR || PPC32 || X86) && !SMP))
 	---help---
 	  Enable the possibility of suspending the machine.
 	  It doesn't need APM.

