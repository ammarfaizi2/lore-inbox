Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264745AbSKRT3y>; Mon, 18 Nov 2002 14:29:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264729AbSKRT2i>; Mon, 18 Nov 2002 14:28:38 -0500
Received: from d12lmsgate-3.de.ibm.com ([194.196.100.236]:39850 "EHLO
	d12lmsgate-3.de.ibm.com") by vger.kernel.org with ESMTP
	id <S264745AbSKRTYx> convert rfc822-to-8bit; Mon, 18 Nov 2002 14:24:53 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] 2.5.48 s390 (11/16): isclean bug.
Date: Mon, 18 Nov 2002 20:21:34 +0100
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200211182021.34536.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the _PAGE_ISCLEAN bit in pte_mkwrite to make pte_mkwrite
work correctly even if it is not followed by a pte_mkdirty.

diff -urN linux-2.5.48/include/asm-s390/pgtable.h linux-2.5.48-s390/include/asm-s390/pgtable.h
--- linux-2.5.48/include/asm-s390/pgtable.h	Mon Nov 18 05:29:52 2002
+++ linux-2.5.48-s390/include/asm-s390/pgtable.h	Mon Nov 18 20:11:53 2002
@@ -320,7 +320,7 @@
 
 extern inline pte_t pte_mkwrite(pte_t pte) 
 {
-	pte_val(pte) &= ~_PAGE_RO;
+	pte_val(pte) &= ~(_PAGE_RO | _PAGE_ISCLEAN);
 	return pte;
 }
 
diff -urN linux-2.5.48/include/asm-s390x/pgtable.h linux-2.5.48-s390/include/asm-s390x/pgtable.h
--- linux-2.5.48/include/asm-s390x/pgtable.h	Mon Nov 18 05:29:32 2002
+++ linux-2.5.48-s390/include/asm-s390x/pgtable.h	Mon Nov 18 20:11:53 2002
@@ -339,7 +339,7 @@
 
 extern inline pte_t pte_mkwrite(pte_t pte)
 {
-	pte_val(pte) &= ~_PAGE_RO;
+	pte_val(pte) &= ~(_PAGE_RO | _PAGE_ISCLEAN);
 	return pte;
 }
 

