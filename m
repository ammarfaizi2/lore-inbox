Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936942AbWLDOzP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936942AbWLDOzP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 09:55:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936953AbWLDOyy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 09:54:54 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:46448 "EHLO
	mtagate3.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936929AbWLDOym (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 09:54:42 -0500
Date: Mon, 4 Dec 2006 15:54:33 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, heiko.carstens@de.ibm.com
Subject: [S390] Misaligned wait PSW at memory detection.
Message-ID: <20061204145433.GT32059@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

[S390] Misaligned wait PSW at memory detection.

If the memory detection code would ever reach the point where it would
load the wait psw, it would generate a specification exception and the
system would crash at ipl time. This is because of a misaligned wait
psw. It needs to be on a double word boundary instead of a word
boundary.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/head31.S |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff -urpN linux-2.6/arch/s390/kernel/head31.S linux-2.6-patched/arch/s390/kernel/head31.S
--- linux-2.6/arch/s390/kernel/head31.S	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/head31.S	2006-12-04 14:50:51.000000000 +0100
@@ -131,10 +131,11 @@ startup_continue:
 	.long	init_thread_union
 .Lpmask:
 	.byte	0
-.align 8
+	.align	8
 .Lpcext:.long	0x00080000,0x80000000
 .Lcr:
 	.long	0x00			# place holder for cr0
+	.align	8
 .Lwaitsclp:
 	.long 0x010a0000,0x80000000 + .Lsclph
 .Lrcp:
