Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268602AbUHTSTG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268602AbUHTSTG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 14:19:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268638AbUHTSQg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 14:16:36 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:61345 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S268595AbUHTSFl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 14:05:41 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH 7/14] kexec: e820-64bit
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 20 Aug 2004 12:04:25 -0600
Message-ID: <m1ekm165zq.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It is ok to reserve resources > 4G on x86_64
struct resource is 64bit now :)

diff -uNr linux-2.6.8.1-mm2-ioapic-virtwire-on-shutdown.x86_64/arch/x86_64/kernel/e820.c linux-2.6.8.1-mm2-e820-64bit.x86_64/arch/x86_64/kernel/e820.c
--- linux-2.6.8.1-mm2-ioapic-virtwire-on-shutdown.x86_64/arch/x86_64/kernel/e820.c	Sat Aug 14 11:55:02 2004
+++ linux-2.6.8.1-mm2-e820-64bit.x86_64/arch/x86_64/kernel/e820.c	Fri Aug 20 10:14:09 2004
@@ -185,8 +185,6 @@
 	int i;
 	for (i = 0; i < e820.nr_map; i++) {
 		struct resource *res;
-		if (e820.map[i].addr + e820.map[i].size > 0x100000000ULL)
-			continue;
 		res = alloc_bootmem_low(sizeof(struct resource));
 		switch (e820.map[i].type) {
 		case E820_RAM:	res->name = "System RAM"; break;
