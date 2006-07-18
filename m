Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751317AbWGRLzr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317AbWGRLzr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 07:55:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751321AbWGRLzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 07:55:46 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:23877 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751317AbWGRLzq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 07:55:46 -0400
Date: Tue, 18 Jul 2006 13:55:52 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, Andreas.Krebbel@de.ibm.com
Subject: [patch 4/6] s390: get_clock inline assembly.
Message-ID: <20060718115552.GD20884@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Krebbel <Andreas.Krebbel@de.ibm.com>

[S390] get_clock inline assembly.

Add missing volatile to the get_clock / get_cycles inline assemblies
to avoid that consecutive calls get optimized away.

Signed-off-by: Andreas Krebbel <krebbel1@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 include/asm-s390/timex.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -urpN linux-2.6/include/asm-s390/timex.h linux-2.6-patched/include/asm-s390/timex.h
--- linux-2.6/include/asm-s390/timex.h	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6-patched/include/asm-s390/timex.h	2006-07-18 13:40:45.000000000 +0200
@@ -19,7 +19,7 @@ static inline cycles_t get_cycles(void)
 {
 	cycles_t cycles;
 
-	__asm__("stck 0(%1)" : "=m" (cycles) : "a" (&cycles) : "cc");
+	__asm__ __volatile__ ("stck 0(%1)" : "=m" (cycles) : "a" (&cycles) : "cc");
 	return cycles >> 2;
 }
 
@@ -27,7 +27,7 @@ static inline unsigned long long get_clo
 {
 	unsigned long long clk;
 
-	__asm__("stck 0(%1)" : "=m" (clk) : "a" (&clk) : "cc");
+	__asm__ __volatile__ ("stck 0(%1)" : "=m" (clk) : "a" (&clk) : "cc");
 	return clk;
 }
 
