Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945936AbWGOAfZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945936AbWGOAfZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 20:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945938AbWGOAfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 20:35:24 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:28425 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1945935AbWGOAfU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 20:35:20 -0400
Date: Sat, 15 Jul 2006 02:35:19 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, arjan@linux.intel.com
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       netdev@vger.kernel.org
Subject: [-mm patch] remove net/core/skbuff.c:skb_queue_lock_key
Message-ID: <20060715003519.GF3633@stusta.de>
References: <20060713224800.6cbdbf5d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060713224800.6cbdbf5d.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2006 at 10:48:00PM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.18-rc1-mm1:
>...
> +lockdep-split-the-skb_queue_head_init-lock-class.patch
> 
>  lockdep-versus-net fix.
>...

skb_queue_lock_key is no longer used.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 include/linux/skbuff.h |    2 --
 net/core/skbuff.c      |    7 -------
 2 files changed, 9 deletions(-)

--- linux-2.6.18-rc1-mm2-full/include/linux/skbuff.h.old	2006-07-14 22:15:15.000000000 +0200
+++ linux-2.6.18-rc1-mm2-full/include/linux/skbuff.h	2006-07-14 22:15:23.000000000 +0200
@@ -604,8 +604,6 @@
 	return list_->qlen;
 }
 
-extern struct lock_class_key skb_queue_lock_key;
-
 /*
  * This function creates a split out lock class for each invocation;
  * this is needed for now since a whole lot of users of the skb-queue
--- linux-2.6.18-rc1-mm2-full/net/core/skbuff.c.old	2006-07-14 22:15:30.000000000 +0200
+++ linux-2.6.18-rc1-mm2-full/net/core/skbuff.c	2006-07-14 22:15:38.000000000 +0200
@@ -71,13 +71,6 @@
 static kmem_cache_t *skbuff_fclone_cache __read_mostly;
 
 /*
- * lockdep: lock class key used by skb_queue_head_init():
- */
-struct lock_class_key skb_queue_lock_key;
-
-EXPORT_SYMBOL(skb_queue_lock_key);
-
-/*
  *	Keep out-of-line to prevent kernel bloat.
  *	__builtin_return_address is not used because it is not always
  *	reliable.

