Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265999AbUBQFce (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 00:32:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266016AbUBQFce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 00:32:34 -0500
Received: from mx1.redhat.com ([66.187.233.31]:21971 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265999AbUBQFcY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 00:32:24 -0500
Date: Mon, 16 Feb 2004 21:32:20 -0800
From: "David S. Miller" <davem@redhat.com>
To: David Dillow <dave@thedillows.org>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Non-PCI build broken on sparc64, maybe others
Message-Id: <20040216213220.594052c7.davem@redhat.com>
In-Reply-To: <1076993402.21443.5.camel@ori.thedillows.org>
References: <1076993402.21443.5.camel@ori.thedillows.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 Feb 2004 23:50:03 -0500
David Dillow <dave@thedillows.org> wrote:

> I believe this changeset in Linus's tree:
 ...
> breaks builds that do not include PCI support.

Indeed, thanks for catching this David.  This patch should fix it
and I'll be pushing this to Linus.

Thanks again.

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/02/16 21:28:29-08:00 davem@nuts.davemloft.net 
#   [SPARC64]: Fix non-PCI build, reported by David Dillow.
# 
# include/asm-sparc64/dma-mapping.h
#   2004/02/16 21:25:35-08:00 davem@nuts.davemloft.net +21 -1
#   [SPARC64]: Fix non-PCI build, reported by David Dillow.
# 
diff -Nru a/include/asm-sparc64/dma-mapping.h b/include/asm-sparc64/dma-mapping.h
--- a/include/asm-sparc64/dma-mapping.h	Mon Feb 16 21:28:51 2004
+++ b/include/asm-sparc64/dma-mapping.h	Mon Feb 16 21:28:51 2004
@@ -1,5 +1,25 @@
+#ifndef _ASM_SPARC64_DMA_MAPPING_H
+#define _ASM_SPARC64_DMA_MAPPING_H
+
 #include <linux/config.h>
 
 #ifdef CONFIG_PCI
 #include <asm-generic/dma-mapping.h>
-#endif
+#else
+
+static inline void *dma_alloc_coherent(struct device *dev, size_t size,
+			 dma_addr_t *dma_handle, int flag)
+{
+	BUG();
+	return NULL;
+}
+
+static inline void dma_free_coherent(struct device *dev, size_t size,
+		       void *vaddr, dma_addr_t dma_handle)
+{
+	BUG();
+}
+
+#endif /* PCI */
+
+#endif /* _ASM_SPARC64_DMA_MAPPING_H */
