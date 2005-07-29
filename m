Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262706AbVG2S6s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262706AbVG2S6s (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 14:58:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262704AbVG2S4d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 14:56:33 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:33417 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262680AbVG2SyL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 14:54:11 -0400
To: Andi Kleen <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] x86_64: Fix off by one in e820_mapped
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 29 Jul 2005 12:53:56 -0600
Message-ID: <m14qad4f5n.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This allows a valid iommu placed immediately after memory
to work, to be recognized as after the last byte of memory
and not overlapping it.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---

 arch/x86_64/kernel/e820.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

a0929b87b8d0d059a10eb3e61da3d679d64980e1
diff --git a/arch/x86_64/kernel/e820.c b/arch/x86_64/kernel/e820.c
--- a/arch/x86_64/kernel/e820.c
+++ b/arch/x86_64/kernel/e820.c
@@ -85,7 +85,7 @@ int __init e820_mapped(unsigned long sta
 		struct e820entry *ei = &e820.map[i]; 
 		if (type && ei->type != type) 
 			continue;
-		if (ei->addr >= end || ei->addr + ei->size < start) 
+		if (ei->addr >= end || ei->addr + ei->size <= start) 
 			continue; 
 		return 1; 
 	} 
