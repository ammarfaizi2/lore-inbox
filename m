Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932122AbWHGP0k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122AbWHGP0k (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 11:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932145AbWHGP0j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 11:26:39 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:15584 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932122AbWHGP0j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 11:26:39 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] x86_64: Double the per cpu area size
CC: Andi Kleen <ak@suse.de>,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       <linux-kernel@vger.kernel.org>
Date: Mon, 07 Aug 2006 09:25:16 -0600
Message-ID: <m1mzagfu03.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


With the support for more than 256 irqs kernel_stat.irqs has
grown noticeably in size.  When asked about it no one wants to
keep less information, so we need a larger per cpu area.

According to my rough calculations the per cpu usage
has grown by about 15K (in the worst case) while the per cpu
area size has grown by 32K so we should have enough room for
a while.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 include/asm-x86_64/percpu.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/asm-x86_64/percpu.h b/include/asm-x86_64/percpu.h
index 08dd9f9..56e3bdb 100644
--- a/include/asm-x86_64/percpu.h
+++ b/include/asm-x86_64/percpu.h
@@ -11,6 +11,8 @@ #ifdef CONFIG_SMP
 
 #include <asm/pda.h>
 
+#define PERCPU_ENOUGH_ROOM 65536
+
 #define __per_cpu_offset(cpu) (cpu_pda(cpu)->data_offset)
 #define __my_cpu_offset() read_pda(data_offset)
 
-- 
1.4.2.rc3.g7e18e

