Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267829AbUHTIjx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267829AbUHTIjx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 04:39:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267786AbUHTIjU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 04:39:20 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:44192 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S267827AbUHTIiT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 04:38:19 -0400
To: Andi Kleen <ak@muc.de>
cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] reserve 64bit resources on x86_64
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 20 Aug 2004 02:36:38 -0600
Message-ID: <m18yca8auh.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andi,

The hack from the i386 kernel to not reserve 64bit resource regions
appears to have made it into x86_64.  Since struct resource is 64bit
on 64bit architectures this is completely unnecessary, and dangerous
if the kernel ever assigns a 64bit BAR.

Eric


diff -uNr linux-2.6.8.1-ioapic-virtwire-on-shutdown.x86_64/arch/x86_64/kernel/e820.c linux-2.6.8.1-e820-64bit.x86_64/arch/x86_64/kernel/e820.c
--- linux-2.6.8.1-ioapic-virtwire-on-shutdown.x86_64/arch/x86_64/kernel/e820.c	Wed Aug 18 14:54:30 2004
+++ linux-2.6.8.1-e820-64bit.x86_64/arch/x86_64/kernel/e820.c	Wed Aug 18 14:59:34 2004
@@ -185,8 +185,6 @@
 	int i;
 	for (i = 0; i < e820.nr_map; i++) {
 		struct resource *res;
-		if (e820.map[i].addr + e820.map[i].size > 0x100000000ULL)
-			continue;
 		res = alloc_bootmem_low(sizeof(struct resource));
 		switch (e820.map[i].type) {
 		case E820_RAM:	res->name = "System RAM"; break;
