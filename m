Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751094AbWFLG4l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751094AbWFLG4l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 02:56:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751389AbWFLG4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 02:56:41 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:54439 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751094AbWFLG4k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 02:56:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:subject:content-type:content-transfer-encoding:from;
        b=KWloRC+c5ztmenWhMlmbp8AS/C6a9/o0HZ7U7u1BLWhFYafgwCeD9z++hfVNrzWsmQv3o8aQhHfyT2128nWBdNyJZnuatqR/3Djgc2XLkr6dHhQMXf4mDuWTgRfZsMj5Mb9zzeaC21dArQ0JQRSDoduoOul34GZGjoBv+7bdOZU=
Message-ID: <448D1117.8010407@innova-card.com>
Date: Mon, 12 Jun 2006 09:00:39 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: apw@shadowen.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [SPARSEMEM] confusing uses of SPARSEM_EXTREME (try #2)
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From: Franck Bui-Huu <fbh.work@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Is it me or the use of CONFIG_SPARSEMEM_EXTREME is really confusing in
mm/sparce.c ? Shouldn't we use CONFIG_SPARSEMEM_STATIC instead like
the following patch suggests ?

-- >8 --
Subject: [PATCH] Remove confusing uses of SPARSEMEM_EXTREME

CONFIG_SPARSEMEM_EXTREME is used in sparce.c whereas
CONFIG_SPARSEMEM_STATIC seems to be more appropriate.

Signed-off-by: Franck Bui-Huu <vagabon.xyz@gmail.com> 

---

include/linux/mmzone.h |    2 +-
mm/sparse.c            |    6 +++---
2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index ebfc238..35f38b0 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -551,7 +551,7 @@ #define SECTION_NR_TO_ROOT(sec)	((sec) /
 #define NR_SECTION_ROOTS	(NR_MEM_SECTIONS / SECTIONS_PER_ROOT)
 #define SECTION_ROOT_MASK	(SECTIONS_PER_ROOT - 1)
 
-#ifdef CONFIG_SPARSEMEM_EXTREME
+#ifndef CONFIG_SPARSEMEM_STATIC
 extern struct mem_section *mem_section[NR_SECTION_ROOTS];
 #else
 extern struct mem_section mem_section[NR_SECTION_ROOTS][SECTIONS_PER_ROOT];
diff --git a/mm/sparse.c b/mm/sparse.c
index 0a51f36..341d935 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -16,7 +16,7 @@ #include <asm/dma.h>
  *
  * 1) mem_section	- memory sections, mem_map's for valid memory
  */
-#ifdef CONFIG_SPARSEMEM_EXTREME
+#ifndef CONFIG_SPARSEMEM_STATIC
 struct mem_section *mem_section[NR_SECTION_ROOTS]
 	____cacheline_internodealigned_in_smp;
 #else
@@ -25,7 +25,7 @@ struct mem_section mem_section[NR_SECTIO
 #endif
 EXPORT_SYMBOL(mem_section);
 
-#ifdef CONFIG_SPARSEMEM_EXTREME
+#ifndef CONFIG_SPARSEMEM_STATIC
 static struct mem_section *sparse_index_alloc(int nid)
 {
 	struct mem_section *section = NULL;
@@ -67,7 +67,7 @@ out:
 	spin_unlock(&index_init_lock);
 	return ret;
 }
-#else /* !SPARSEMEM_EXTREME */
+#else /* SPARSEMEM_STATIC */
 static inline int sparse_index_init(unsigned long section_nr, int nid)
 {
 	return 0;
-- 
1.3.3.g8701
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

