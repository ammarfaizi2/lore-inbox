Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757446AbWKWR0n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757446AbWKWR0n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 12:26:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757447AbWKWR0n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 12:26:43 -0500
Received: from aa011msr.fastwebnet.it ([85.18.95.71]:56258 "EHLO
	aa011msr.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1757446AbWKWR0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 12:26:42 -0500
Date: Thu, 23 Nov 2006 18:26:23 +0100
From: Mattia Dongili <malattia@linux.it>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: MCORE2 include/asm/module.h:60:2: error: #error unknown processor family [was Re: 2.6.19-rc6-mm1]
Message-ID: <20061123172623.GG5603@inferi.kami.home>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20061123021703.8550e37e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061123021703.8550e37e.akpm@osdl.org>
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.19-rc5-mm2-1 i686
X-Editor: Vim http://www.vim.org/
X-Disclaimer: Buh!
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2006 at 02:17:03AM -0800, Andrew Morton wrote:
...
> +x86_64-mm-i386-config-core2.patch

hmmm... this one missed to update also include/asm/module.h:
  
  HOSTCC  scripts/genksyms/parse.o
  HOSTCC  scripts/mod/sumversion.o
In file included from include/linux/module.h:22,
                 from include/linux/crypto.h:21,
                 from arch/i386/kernel/asm-offsets.c:7:
include/asm/module.h:60:2: error: #error unknown processor family
  HOSTLD  scripts/genksyms/genksyms
make[1]: *** [arch/i386/kernel/asm-offsets.s] Error 1
make: *** [prepare0] Error 2
make: *** Waiting for unfinished jobs....

If the family name is correct the patch is quite trivial :)

Signed-out-by: Mattia Dongili <malattia@linux.it>
---

diff --git a/include/asm-i386/module.h b/include/asm-i386/module.h
index 424661d..e453565 100644
--- a/include/asm-i386/module.h
+++ b/include/asm-i386/module.h
@@ -26,6 +26,8 @@ struct mod_arch_specific
 #define MODULE_PROC_FAMILY "PENTIUMII "
 #elif defined CONFIG_MPENTIUMIII
 #define MODULE_PROC_FAMILY "PENTIUMIII "
+#elif defined CONFIG_MCORE2
+#define MODULE_PROC_FAMILY "CORE2 "
 #elif defined CONFIG_MPENTIUMM
 #define MODULE_PROC_FAMILY "PENTIUMM "
 #elif defined CONFIG_MPENTIUM4

