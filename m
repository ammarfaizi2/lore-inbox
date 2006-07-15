Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945997AbWGOEAM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945997AbWGOEAM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 00:00:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945999AbWGOEAM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 00:00:12 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:45503 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1945997AbWGOEAK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 00:00:10 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <fastboot@osdl.org>
Subject: [PATCH] machine_kexec.c: Fix the description of segment handling.
Date: Fri, 14 Jul 2006 21:59:19 -0600
Message-ID: <m1u05jr014.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


One of my original comments in machine_kexec was unclear
and this should fix it.  

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---

Be very careful with this patch.  It seems to be surrounded
by a somebody else's problem field.

I wrote it months ago, and then forgot it.  I started writing this
email message several days ago and then forgot it.

Hopefully including this patch won't cause this effect to spread
and cause the entire kernel to be universally treated as somebody
else's problem. :) 

 arch/i386/kernel/machine_kexec.c   |   13 +++++--------
 arch/x86_64/kernel/machine_kexec.c |   13 +++++--------
 2 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/arch/i386/kernel/machine_kexec.c b/arch/i386/kernel/machine_kexec.c
index 511abe5..a696f93 100644
--- a/arch/i386/kernel/machine_kexec.c
+++ b/arch/i386/kernel/machine_kexec.c
@@ -189,14 +189,11 @@ NORET_TYPE void machine_kexec(struct kim
 	memcpy((void *)reboot_code_buffer, relocate_new_kernel,
 						relocate_new_kernel_size);
 
-	/* The segment registers are funny things, they are
-	 * automatically loaded from a table, in memory wherever you
-	 * set them to a specific selector, but this table is never
-	 * accessed again you set the segment to a different selector.
-	 *
-	 * The more common model is are caches where the behide
-	 * the scenes work is done, but is also dropped at arbitrary
-	 * times.
+	/* The segment registers are funny things, they have both a
+	 * visible and an invisible part.  Whenever the visible part is
+	 * set to a specific selector, the invisible part is loaded
+	 * with from a table in memory.  At no other time is the
+	 * descriptor table in memory accessed. 
 	 *
 	 * I take advantage of this here by force loading the
 	 * segments, before I zap the gdt with an invalid value.
diff --git a/arch/x86_64/kernel/machine_kexec.c b/arch/x86_64/kernel/machine_kexec.c
index 83fb24a..ba9b571 100644
--- a/arch/x86_64/kernel/machine_kexec.c
+++ b/arch/x86_64/kernel/machine_kexec.c
@@ -207,14 +207,11 @@ NORET_TYPE void machine_kexec(struct kim
 	__flush_tlb();
 
 
-	/* The segment registers are funny things, they are
-	 * automatically loaded from a table, in memory wherever you
-	 * set them to a specific selector, but this table is never
-	 * accessed again unless you set the segment to a different selector.
-	 *
-	 * The more common model are caches where the behide
-	 * the scenes work is done, but is also dropped at arbitrary
-	 * times.
+	/* The segment registers are funny things, they have both a
+	 * visible and an invisible part.  Whenever the visible part is
+	 * set to a specific selector, the invisible part is loaded
+	 * with from a table in memory.  At no other time is the
+	 * descriptor table in memory accessed. 
 	 *
 	 * I take advantage of this here by force loading the
 	 * segments, before I zap the gdt with an invalid value.
-- 
1.4.1.gac83a

