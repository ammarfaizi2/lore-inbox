Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268056AbUGWVFg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268056AbUGWVFg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 17:05:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268059AbUGWVFg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 17:05:36 -0400
Received: from fw.osdl.org ([65.172.181.6]:49092 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268056AbUGWVF3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 17:05:29 -0400
Date: Fri, 23 Jul 2004 14:05:27 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] hlist_for_each_safe cleanup
Message-Id: <20040723140527.7e3c119a@dell_ss3.pdx.osdl.net>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.10claws (GTK+ 1.2.10; i386-redhat-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make code for hlist_for_each_safe use better code (same as hlist_for_each_entry_safe).
Get rid of comment about prefetch, because that was fixed a while ago.
Only current use of this is in the bridge code, that I maintain.

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>

--- linux-2.6/include/linux/list.h	2004-07-23 09:36:18.000000000 -0700
+++ tcp-2.6/include/linux/list.h	2004-07-23 11:43:25.000000000 -0700
@@ -620,13 +620,12 @@
 
 #define hlist_entry(ptr, type, member) container_of(ptr,type,member)
 
-/* Cannot easily do prefetch unfortunately */
 #define hlist_for_each(pos, head) \
 	for (pos = (head)->first; pos && ({ prefetch(pos->next); 1; }); \
 	     pos = pos->next)
 
 #define hlist_for_each_safe(pos, n, head) \
-	for (pos = (head)->first; n = pos ? pos->next : NULL, pos; \
+	for (pos = (head)->first; pos && ({ n = pos->next; 1; }); \
 	     pos = n)
 
 /**
