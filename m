Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270583AbTGNMdn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 08:33:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270618AbTGNMcQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 08:32:16 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:51332
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S270594AbTGNMSZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 08:18:25 -0400
Date: Mon, 14 Jul 2003 13:32:15 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307141232.h6ECWFOu030968@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, marcelo@conectiva.com
Subject: PATCH: make rep-nop a barrier as in 2.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.22-pre5/include/asm-i386/processor.h linux.22-pre5-ac1/include/asm-i386/processor.h
--- linux.22-pre5/include/asm-i386/processor.h	2003-07-14 12:27:42.000000000 +0100
+++ linux.22-pre5-ac1/include/asm-i386/processor.h	2003-07-08 23:31:26.000000000 +0100
@@ -468,7 +471,7 @@
 /* REP NOP (PAUSE) is a good thing to insert into busy-wait loops. */
 static inline void rep_nop(void)
 {
-	__asm__ __volatile__("rep;nop");
+	__asm__ __volatile__("rep;nop" ::: "memory");
 }
 
 #define cpu_relax()	rep_nop()
