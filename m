Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267808AbUHSBqU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267808AbUHSBqU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 21:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267958AbUHSBqU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 21:46:20 -0400
Received: from mx1.redhat.com ([66.187.233.31]:37567 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267808AbUHSBqP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 21:46:15 -0400
Date: Wed, 18 Aug 2004 18:43:03 -0700
From: "David S. Miller" <davem@redhat.com>
To: joshk@triplehelix.org (Joshua Kwan)
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6] busybox EFAULT on sparc64
Message-Id: <20040818184303.1ae13c98.davem@redhat.com>
In-Reply-To: <20040818235528.GA8070@triplehelix.org>
References: <20040818235528.GA8070@triplehelix.org>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Oops, it's possible that the bug fixed by this patch
might fix your problem...

===== include/asm-sparc64/pgtable.h 1.42 vs edited =====
--- 1.42/include/asm-sparc64/pgtable.h	2004-08-14 22:20:36 -07:00
+++ edited/include/asm-sparc64/pgtable.h	2004-08-18 18:29:17 -07:00
@@ -335,7 +335,7 @@
 	pte_t orig = *ptep;
 
 	*ptep = pte;
-	if (pte_present(orig))
+	if (pte_val(orig) & _PAGE_VALID)
 		tlb_batch_add(mm, addr, ptep, orig);
 }
 
