Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261316AbVCYAwL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261316AbVCYAwL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 19:52:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261282AbVCYAvc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 19:51:32 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:6673 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261328AbVCYAiT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 19:38:19 -0500
Date: Fri, 25 Mar 2005 01:38:16 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] remove exports for oem modules
Message-ID: <20050325003816.GK3966@stusta.de>
References: <20050324044114.5aa5b166.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050324044114.5aa5b166.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2005 at 04:41:14AM -0800, Andrew Morton wrote:
>...
> Chages since 2.6.12-rc1-mm1:
>...
> -revert-allow-oem-written-modules-to-make-calls-to-ia64-oem-sal-functions.patch
> 
>  Drop this - the modules are now in the kernel.
>...

As already discussed, there's still no module using this in the kernel.

The part of this patch that still applies is below.


<--  snip  -->


These module exports have no GPL'ed callers.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.12-rc1-mm2-full/arch/ia64/kernel/sal.c.old	2005-03-25 01:31:22.000000000 +0100
+++ linux-2.6.12-rc1-mm2-full/arch/ia64/kernel/sal.c	2005-03-25 01:34:24.000000000 +0100
@@ -273,7 +273,6 @@
 	SAL_CALL(*isrvp, oemfunc, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
 	return 0;
 }
-EXPORT_SYMBOL(ia64_sal_oemcall);
 
 int
 ia64_sal_oemcall_nolock(struct ia64_sal_retval *isrvp, u64 oemfunc, u64 arg1,
@@ -286,17 +285,3 @@
 			arg7);
 	return 0;
 }
-EXPORT_SYMBOL(ia64_sal_oemcall_nolock);
-
-int
-ia64_sal_oemcall_reentrant(struct ia64_sal_retval *isrvp, u64 oemfunc,
-			   u64 arg1, u64 arg2, u64 arg3, u64 arg4, u64 arg5,
-			   u64 arg6, u64 arg7)
-{
-	if (oemfunc < IA64_SAL_OEMFUNC_MIN || oemfunc > IA64_SAL_OEMFUNC_MAX)
-		return -1;
-	SAL_CALL_REENTRANT(*isrvp, oemfunc, arg1, arg2, arg3, arg4, arg5, arg6,
-			   arg7);
-	return 0;
-}
-EXPORT_SYMBOL(ia64_sal_oemcall_reentrant);

