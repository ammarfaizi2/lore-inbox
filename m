Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268170AbUIPSd0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268170AbUIPSd0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 14:33:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268239AbUIPScZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 14:32:25 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:33173 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S268250AbUIPSaM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 14:30:12 -0400
Subject: Re: [PATCH] reduce [compat]_do_execve stack usage
From: Alex Williamson <alex.williamson@hp.com>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <200409151705.11356.vda@port.imtp.ilyichevsk.odessa.ua>
References: <200409151705.11356.vda@port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain
Organization: LOSL
Date: Thu, 16 Sep 2004 12:30:22 -0600
Message-Id: <1095359422.5527.22.camel@tdi>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.94.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


   Looks like a couple struct to pointer conversions were missed.
Current bk won't build for me w/o this:

===== fs/compat.c 1.41 vs edited =====
--- 1.41/fs/compat.c	2004-09-14 17:24:46 -06:00
+++ edited/fs/compat.c	2004-09-16 12:19:26 -06:00
@@ -1399,11 +1399,11 @@
 	if (retval < 0)
 		goto out_mm;
 
-	bprm.argc = compat_count(argv, bprm->p / sizeof(compat_uptr_t));
+	bprm->argc = compat_count(argv, bprm->p / sizeof(compat_uptr_t));
 	if ((retval = bprm->argc) < 0)
 		goto out_mm;
 
-	bprm.envc = compat_count(envp, bprm->p / sizeof(compat_uptr_t));
+	bprm->envc = compat_count(envp, bprm->p / sizeof(compat_uptr_t));
 	if ((retval = bprm->envc) < 0)
 		goto out_mm;
 


-- 
Alex Williamson                             HP Linux & Open Source Lab

