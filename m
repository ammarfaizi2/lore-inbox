Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268148AbUIPXFX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268148AbUIPXFX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 19:05:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268330AbUIPXFX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 19:05:23 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:30158 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S268148AbUIPXEx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 19:04:53 -0400
Date: Thu, 16 Sep 2004 16:04:09 -0700 (PDT)
From: Ray Bryant <raybry@sgi.com>
To: Ray Bryant <raybry@austin.rr.com>, Andrew Morton <akpm@osdl.org>
Cc: Ray Bryant <raybry@sgi.com>, lse-tech@lists.sourceforge.net,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Zwane Mwaikambo <zwane@linuxpower.ca>, linux-kernel@vger.kernel.org
Message-Id: <20040916230409.23023.97905.94108@tomahawk.engr.sgi.com>
In-Reply-To: <20040916230344.23023.79384.49263@tomahawk.engr.sgi.com>
References: <20040916230344.23023.79384.49263@tomahawk.engr.sgi.com>
Subject: [PATCH 3/3] lockmeter: lockmeter fix for inline in_lock_functions()
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix to lockmeter.c for inline in_lock_functions().
(Only required if in_lock_functions() is modified to be inline.)


Signed-off-by: Ray Bryant <raybry@sgi.com>

Index: linux-2.6.9-rc2-mm1/kernel/lockmeter.c
===================================================================
--- linux-2.6.9-rc2-mm1.orig/kernel/lockmeter.c	2004-09-16 12:29:08.000000000 -0700
+++ linux-2.6.9-rc2-mm1/kernel/lockmeter.c	2004-09-16 12:53:57.000000000 -0700
@@ -1510,13 +1510,3 @@
 	return 0;
 }
 EXPORT_SYMBOL(_spin_trylock_bh);
-
-int in_lock_functions(unsigned long addr)
-{
-	/* Linker adds these: start and end of __lockfunc functions */
-	extern char __lock_text_start[], __lock_text_end[];
-
-	return addr >= (unsigned long)__lock_text_start
-	&& addr < (unsigned long)__lock_text_end;
-}
-EXPORT_SYMBOL(in_lock_functions);

-- 
Best Regards,
Ray
-----------------------------------------------
Ray Bryant                       raybry@sgi.com
The box said: "Requires Windows 98 or better",
           so I installed Linux.
-----------------------------------------------
