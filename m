Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932277AbWF2TV1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932277AbWF2TV1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 15:21:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932269AbWF2TVZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 15:21:25 -0400
Received: from [141.84.69.5] ([141.84.69.5]:28944 "HELO mailout.stusta.mhn.de")
	by vger.kernel.org with SMTP id S932277AbWF2TVB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 15:21:01 -0400
Date: Thu, 29 Jun 2006 21:20:20 +0200
From: Adrian Bunk <bunk@stusta.de>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] make net/core/skbuff.c:skb_release_data() static
Message-ID: <20060629192020.GR19712@stusta.de>
References: <20060623105623.GT9111@stusta.de> <20060623.040115.108744369.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060623.040115.108744369.davem@davemloft.net>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2006 at 04:01:15AM -0700, David Miller wrote:
> From: Adrian Bunk <bunk@stusta.de>
> Date: Fri, 23 Jun 2006 12:56:23 +0200
> 
> > skb_release_data() no longer has any users in other files.
> > 
> > Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> If you are going to do this, you need to remove the reference
> in arch/x86_64/kernel/functionlist too.
> 
> Thanks.

Corrected patch below.

cu
Adrian


<--  snip  -->


skb_release_data() no longer has any users in other files.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 arch/x86_64/kernel/functionlist |    1 -
 include/linux/skbuff.h          |    1 -
 net/core/skbuff.c               |    2 +-
 3 files changed, 1 insertion(+), 3 deletions(-)

--- linux-2.6.17-mm4-full/include/linux/skbuff.h.old	2006-06-29 15:19:52.000000000 +0200
+++ linux-2.6.17-mm4-full/include/linux/skbuff.h	2006-06-29 15:19:59.000000000 +0200
@@ -1301,7 +1301,6 @@
 extern void	       skb_split(struct sk_buff *skb,
 				 struct sk_buff *skb1, const u32 len);
 
-extern void	       skb_release_data(struct sk_buff *skb);
 extern struct sk_buff *skb_segment(struct sk_buff *skb, int sg);
 
 static inline void *skb_header_pointer(const struct sk_buff *skb, int offset,
--- linux-2.6.17-mm4-full/net/core/skbuff.c.old	2006-06-29 15:20:10.000000000 +0200
+++ linux-2.6.17-mm4-full/net/core/skbuff.c	2006-06-29 15:20:17.000000000 +0200
@@ -279,7 +279,7 @@
 		skb_get(list);
 }
 
-void skb_release_data(struct sk_buff *skb)
+static void skb_release_data(struct sk_buff *skb)
 {
 	if (!skb->cloned ||
 	    !atomic_sub_return(skb->nohdr ? (1 << SKB_DATAREF_SHIFT) + 1 : 1,
--- linux-2.6.17-mm4-full/arch/x86_64/kernel/functionlist.old	2006-06-29 15:20:26.000000000 +0200
+++ linux-2.6.17-mm4-full/arch/x86_64/kernel/functionlist	2006-06-29 15:20:30.000000000 +0200
@@ -384,7 +384,6 @@
 *(.text.__end_that_request_first)
 *(.text.wake_up_bit)
 *(.text.unuse_mm)
-*(.text.skb_release_data)
 *(.text.shrink_icache_memory)
 *(.text.sched_balance_self)
 *(.text.__pmd_alloc)

