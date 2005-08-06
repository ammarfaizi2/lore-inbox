Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261162AbVHFTsR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbVHFTsR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 15:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261175AbVHFTsQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 15:48:16 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:10892 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261162AbVHFTsL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 15:48:11 -0400
To: Linus Torvalds <torvalds@osdl.org>
CC: <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>
Subject: [PATCH] x86_64 bootmem: sparse_mem/kexec merge bug.
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sat, 06 Aug 2005 13:47:36 -0600
Message-ID: <m1ll3eyhif.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When the sparse mem changes and the kexec changes
were merged into setup.c they came in, in the wrong order.
This patch changes the order so we don't run sparse_init
which uses the bootmem allocator until we all of the
reserve_bootmem calls has been made.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---

 arch/x86_64/kernel/setup.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

a5873c00a7da0ebb5c192f89382ef382602bd396
diff --git a/arch/x86_64/kernel/setup.c b/arch/x86_64/kernel/setup.c
--- a/arch/x86_64/kernel/setup.c
+++ b/arch/x86_64/kernel/setup.c
@@ -645,15 +645,15 @@ void __init setup_arch(char **cmdline_p)
 		}
 	}
 #endif
-
-	sparse_init();
-
 #ifdef CONFIG_KEXEC
 	if (crashk_res.start != crashk_res.end) {
 		reserve_bootmem(crashk_res.start,
 			crashk_res.end - crashk_res.start + 1);
 	}
 #endif
+
+	sparse_init();
+
 	paging_init();
 
 	check_ioapic();
