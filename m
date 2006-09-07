Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751094AbWIGIoI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751094AbWIGIoI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 04:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbWIGIoI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 04:44:08 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:5048 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1751094AbWIGIoD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 04:44:03 -0400
Message-ID: <44FFDC37.7030805@sw.ru>
Date: Thu, 07 Sep 2006 12:45:43 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, dev@openvz.org,
       linux-ia64@vger.kernel.org,
       Fernando Vazquez <fernando@intellilink.co.jp>
Subject: Re: [patch 04/37] fix compilation error on IA64
References: <20060906224631.999046890@quad.kroah.org> <20060906225512.GE15922@kroah.com>
In-Reply-To: <20060906225512.GE15922@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg,

The patch from Fernando Vazquez is incomplete.
The first hunk is from Fernando's patch which fixes IA64 compilation.
But there are some archs which do not include asm-generic/mman.h
and thus will have arch_mmap_check undefined.

Signed-Off-By: Kirill Korotaev <dev@sw.ru>

--- a/include/asm-ia64/mman.h
+++ b/include/asm-ia64/mman.h
@@ -9,10 +9,12 @@
  */
 
 #ifdef __KERNEL__
+#ifndef __ASSEMBLY__
 #define arch_mmap_check	ia64_map_check_rgn
 int ia64_map_check_rgn(unsigned long addr, unsigned long len,
 		unsigned long flags);
 #endif
+#endif
 
 #include <asm-generic/mman.h>
 
diff --git a/include/asm-alpha/mman.h b/include/asm-alpha/mman.h
index 5f24c75..51cf354 100644
--- a/include/asm-alpha/mman.h
+++ b/include/asm-alpha/mman.h
@@ -52,4 +52,10 @@ #define MADV_DOFORK	11		/* do inherit ac
 #define MAP_ANON	MAP_ANONYMOUS
 #define MAP_FILE	0
 
+#ifdef __KERNEL__
+#ifndef arch_mmap_check
+#define arch_mmap_check(addr, len, flags)	(0)
+#endif
+#endif
+
 #endif /* __ALPHA_MMAN_H__ */
diff --git a/include/asm-mips/mman.h b/include/asm-mips/mman.h
index 046cf68..f19e858 100644
--- a/include/asm-mips/mman.h
+++ b/include/asm-mips/mman.h
@@ -75,4 +75,10 @@ #define MADV_DOFORK	11		/* do inherit ac
 #define MAP_ANON	MAP_ANONYMOUS
 #define MAP_FILE	0
 
+#ifdef __KERNEL__
+#ifndef arch_mmap_check
+#define arch_mmap_check(addr, len, flags)	(0)
+#endif
+#endif
+
 #endif /* _ASM_MMAN_H */
diff --git a/include/asm-parisc/mman.h b/include/asm-parisc/mman.h
index 0ef15ee..9829b31 100644
--- a/include/asm-parisc/mman.h
+++ b/include/asm-parisc/mman.h
@@ -59,4 +59,10 @@ #define MAP_ANON	MAP_ANONYMOUS
 #define MAP_FILE	0
 #define MAP_VARIABLE	0
 
+#ifdef __KERNEL__
+#ifndef arch_mmap_check
+#define arch_mmap_check(addr, len, flags)	(0)
+#endif
+#endif
+
 #endif /* __PARISC_MMAN_H__ */


