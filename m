Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261308AbVEZLQT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261308AbVEZLQT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 07:16:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261309AbVEZLQT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 07:16:19 -0400
Received: from ns1.suse.de ([195.135.220.2]:47073 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261308AbVEZLQQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 07:16:16 -0400
Date: Thu, 26 May 2005 13:16:14 +0200
From: Olaf Hering <olh@suse.de>
To: Pavel Machek <pavel@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] show swsuspend only on .config where it can compile
Message-ID: <20050526111614.GA25685@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

show swsuspend only on .config where it can compile.
I got this on PPC32 && SMP

kernel/power/smp.c:24: error: storage size of `ctxt' isn't known

Signed-off-by: Olaf Hering <olh@suse.de>

Index: linux-2.6.12-rc5-olh/kernel/power/Kconfig
===================================================================
--- linux-2.6.12-rc5-olh.orig/kernel/power/Kconfig
+++ linux-2.6.12-rc5-olh/kernel/power/Kconfig
@@ -28,7 +28,7 @@ config PM_DEBUG
 
 config SOFTWARE_SUSPEND
 	bool "Software Suspend (EXPERIMENTAL)"
-	depends on EXPERIMENTAL && PM && SWAP
+	depends on EXPERIMENTAL && PM && SWAP && (X86 && SMP) || ((FVR || PPC32 || X86) && !SMP)
 	---help---
 	  Enable the possibility of suspending the machine.
 	  It doesn't need APM.
