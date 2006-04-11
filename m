Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932271AbWDKDXp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932271AbWDKDXp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 23:23:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932272AbWDKDXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 23:23:45 -0400
Received: from mga01.intel.com ([192.55.52.88]:28445 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S932271AbWDKDXp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 23:23:45 -0400
X-IronPort-AV: i="4.04,109,1144047600"; 
   d="scan'208"; a="22404022:sNHT18413843"
Subject: [PATCH] inline function prefix with __always_inline invsyscall
	function
From: "mao, bibo" <bibo.mao@intel.com>
To: ak@suse.de
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Tue, 11 Apr 2006 11:13:16 +0800
Message-Id: <1144725196.9974.10.camel@maobb.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In vsyscall function do_vgettimeofday(), some functions are declared as
inlined, which is hint for gcc to compile the function inlined but it
not forced. Sometimes compiler does not compiler the function as
inlined, So here inline is replaced by __always_inline prefix.

It does not happen in gcc compiler actually, but it possibly happens.

Signed-off-by: bibo mao <bibo.mao@intel.com>


diff -Nruap linux-2.6.17-rc1-mm1.org/include/asm-x86_64/io.h
linux-2.6.17-rc1-mm1/include/asm-x86_64/io.h
--- linux-2.6.17-rc1-mm1.org/include/asm-x86_64/io.h	2006-04-07
15:13:06.000000000 +0800
+++ linux-2.6.17-rc1-mm1/include/asm-x86_64/io.h	2006-04-07
15:37:03.000000000 +0800
@@ -177,7 +177,7 @@ static inline __u16 __readw(const volati
 {
 	return *(__force volatile __u16 *)addr;
 }
-static inline __u32 __readl(const volatile void __iomem *addr)
+static __always_inline __u32 __readl(const volatile void __iomem *addr)
 {
 	return *(__force volatile __u32 *)addr;
 }
diff -Nruap linux-2.6.17-rc1-mm1.org/include/linux/seqlock.h
linux-2.6.17-rc1-mm1/include/linux/seqlock.h
--- linux-2.6.17-rc1-mm1.org/include/linux/seqlock.h	2006-04-07
15:13:06.000000000 +0800
+++ linux-2.6.17-rc1-mm1/include/linux/seqlock.h	2006-04-07
15:16:13.000000000 +0800
@@ -73,7 +73,7 @@ static inline int write_tryseqlock(seqlo
 }
 
 /* Start of read calculation -- fetch last complete writer token */
-static inline unsigned read_seqbegin(const seqlock_t *sl)
+static __always_inline unsigned read_seqbegin(const seqlock_t *sl)
 {
 	unsigned ret = sl->sequence;
 	smp_rmb();
@@ -88,7 +88,7 @@ static inline unsigned read_seqbegin(con
  *    
  * Using xor saves one conditional branch.
  */
-static inline int read_seqretry(const seqlock_t *sl, unsigned iv)
+static __always_inline int read_seqretry(const seqlock_t *sl, unsigned
iv)
 {
 	smp_rmb();
 	return (iv & 1) | (sl->sequence ^ iv);
