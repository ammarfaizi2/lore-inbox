Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261520AbREOVBs>; Tue, 15 May 2001 17:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261521AbREOVBk>; Tue, 15 May 2001 17:01:40 -0400
Received: from www.topmail.de ([212.255.16.226]:6287 "HELO www.topmail.de")
	by vger.kernel.org with SMTP id <S261520AbREOVAx>;
	Tue, 15 May 2001 17:00:53 -0400
From: mirabilos <eccesys@topmail.de>
To: <linux-kernel@vger.kernel.org>
Subject: gcc-3 patch (damn myself)
Message-Id: <20010515205953.52379A5A97F@www.topmail.de>
Date: Tue, 15 May 2001 22:59:53 +0200 (MET DST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hrm, I forgot to paste the patch:
--- linux-2.4.4-ac9/arch/i386/config.in.org     Mon May 14 17:22:39 2001
+++ linux-2.4.4-ac9/arch/i386/config.in Tue May 15 18:53:29 2001
@@ -59,8 +59,12 @@
    define_bool CONFIG_X86_XADD y
    define_bool CONFIG_X86_BSWAP y
    define_bool CONFIG_X86_POPAD_OK y
-   define_bool CONFIG_RWSEM_GENERIC_SPINLOCK n
-   define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM y
+   bool '  Use generic rwsem (for gcc-3)' CONFIG_RWSEM_GENERIC_SPINLOCK
+   if [ "$CONFIG_RWSEM_GENERIC_SPINLOCK" = "y" ]; then
+      define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM n
+   else
+      define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM y
+   fi
 fi
 if [ "$CONFIG_M486" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 4
