Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275224AbSIUAYU>; Fri, 20 Sep 2002 20:24:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275270AbSIUAYU>; Fri, 20 Sep 2002 20:24:20 -0400
Received: from p50887F27.dip.t-dialin.net ([80.136.127.39]:32446 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S275224AbSIUAYT>; Fri, 20 Sep 2002 20:24:19 -0400
Date: Fri, 20 Sep 2002 18:29:56 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Zach Brown <zab@zabbo.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] list_head debugging?
In-Reply-To: <20020920165304.A4588@bitchcake.off.net>
Message-ID: <Pine.LNX.4.44.0209201825330.342-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf/Steudnitz; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Before Fri, 20 Sep 2002, Zach Brown wrote:

--- ./list.h.debug	Thu Sep 19 15:58:47 2002
+++ ./list.h	Fri Sep 20 13:43:21 2002
@@ -21,6 +21,25 @@
 
 typedef struct list_head list_t;
 
+#define LIST_HEAD_DEBUGGING
+#ifdef LIST_HEAD_DEBUGGING
+
+static inline void __list_valid(struct list_head *list)
+{
+	BUG_ON(list == NULL);
+	BUG_ON(list->next == NULL);
+	BUG_ON(list->prev == NULL);
+	BUG_ON(list->next->prev != list);
+	BUG_ON(list->prev->next != list);
+	BUG_ON((list->next == list) && (list->prev != list));
+	BUG_ON((list->prev == list) && (list->next != list));
+}
+#else 

It's all cool, but I'm not entirely convinced why it must be a BUG macro. 
I'd rather have something said via printk here. If whatever we did was 
bad, it will show up with a BUG() just too soon.

I'd describe a macro.

#define list_assert(cond)				\
	if (cond) printk(KERN_ERR "%s failed!\n", #cond)

Or the like. BTW, I'd define LIST_HEAD_DEBUGGING as 1.

			Thunder
-- 
assert(typeof((fool)->next) == typeof(fool));	/* wrong */

