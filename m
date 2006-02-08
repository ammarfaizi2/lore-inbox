Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161079AbWBHJNg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161079AbWBHJNg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 04:13:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161082AbWBHJNg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 04:13:36 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:43947 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1161079AbWBHJNe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 04:13:34 -0500
Date: Wed, 8 Feb 2006 10:11:56 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Matt Mackall <mpm@selenic.com>,
       linux-kernel@vger.kernel.org
Subject: [patch] SLOB=y && SMP=y fix
Message-ID: <20060208091156.GA7663@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.2
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.2 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.6 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fix CONFIG_SLOB=y (when CONFIG_SMP=y): get rid of the 'align' parameter 
from its __alloc_percpu() implementation. Boot-tested on x86.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

----

 mm/slob.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux/mm/slob.c
===================================================================
--- linux.orig/mm/slob.c
+++ linux/mm/slob.c
@@ -336,7 +336,7 @@ EXPORT_SYMBOL(slab_reclaim_pages);
 
 #ifdef CONFIG_SMP
 
-void *__alloc_percpu(size_t size, size_t align)
+void *__alloc_percpu(size_t size)
 {
 	int i;
 	struct percpu_data *pdata = kmalloc(sizeof (*pdata), GFP_KERNEL);
