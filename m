Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135990AbREBBnN>; Tue, 1 May 2001 21:43:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136493AbREBBnD>; Tue, 1 May 2001 21:43:03 -0400
Received: from [209.191.64.160] ([209.191.64.160]:29957 "HELO linuxninja.org")
	by vger.kernel.org with SMTP id <S135990AbREBBmx>;
	Tue, 1 May 2001 21:42:53 -0400
From: tpepper@vato.org
Date: Tue, 1 May 2001 18:42:40 -0700
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.4 breaks VMware
Message-ID: <20010501184240.A28442@cb.vato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Despite VMware's webpage claiming compatibility issues with 2.4.x kernels I'd
been using it without any problem until I upgraded to 2.4.4.  I couldn't use
their precompiled modules of course but compiling to match the running kernel
worked fine previously.

This patch replaces a wee bit of code vmware wanted in include/linux/skbuff.h
although I'm guessing it was removed for a reason and vmware should be patched
to use the new method.

--- skbuff.h.orig       Tue May  1 18:41:50 2001
+++ skbuff.h    Tue May  1 18:41:55 2001
@@ -244,6 +244,11 @@
 
 /* Internal */
 #define skb_shinfo(SKB)                ((struct skb_shared_info *)((SKB)->end))
+/* for vmware */
+static inline atomic_t *skb_datarefp(struct sk_buff *skb)
+{
+	return (atomic_t *)(skb->end);
+}
 
 /**
  *     skb_queue_empty - check if a queue is empty


Tim
