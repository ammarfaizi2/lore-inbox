Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964873AbWGHRML@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964873AbWGHRML (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 13:12:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964901AbWGHRML
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 13:12:11 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:14471 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964873AbWGHRMK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 13:12:10 -0400
Subject: Re: INFO: possible irq lock inversion dependency detected
From: Arjan van de Ven <arjan@infradead.org>
To: Arne Ahrend <aahrend@web.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <791933691@web.de>
References: <791933691@web.de>
Content-Type: text/plain
Date: Sat, 08 Jul 2006 19:12:08 +0200
Message-Id: <1152378728.3120.75.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-07-08 at 18:25 +0200, Arne Ahrend wrote:
> 2.6.17-mm6 produces the following warning, but appears to be working perfectly fine.
> 
> 
> Cheers,

Another private skb queue.. I'm starting to think that the patch below
is going to be needed... Ingo ?


Arne: Can you try this patch and verify it makes the message go away?

---
 include/linux/skbuff.h |    1 -
 1 file changed, 1 deletion(-)

Index: linux-2.6.17-mm6/include/linux/skbuff.h
===================================================================
--- linux-2.6.17-mm6.orig/include/linux/skbuff.h
+++ linux-2.6.17-mm6/include/linux/skbuff.h
@@ -609,7 +609,6 @@ extern struct lock_class_key skb_queue_l
 static inline void skb_queue_head_init(struct sk_buff_head *list)
 {
 	spin_lock_init(&list->lock);
-	lockdep_set_class(&list->lock, &skb_queue_lock_key);
 	list->prev = list->next = (struct sk_buff *)list;
 	list->qlen = 0;
 }


