Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261748AbUKCRIm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261748AbUKCRIm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 12:08:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261746AbUKCRIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 12:08:42 -0500
Received: from hcc022087.bai.ne.jp ([210.171.22.87]:24712 "HELO
	tigger.internet.email.ne.jp") by vger.kernel.org with SMTP
	id S261785AbUKCRH4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 12:07:56 -0500
Date: Thu, 04 Nov 2004 02:07:44 +0900 (JST)
Message-Id: <20041104.020744.730561579.takata@linux-m32r.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org
Subject: [PATCH 2.6.10-rc1] [m32r] Fix arch/m32r/lib/memset.S
From: Hirokazu Takata <takata@linux-m32r.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.15 (Security Through Obscurity)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

This patch fixes arch/m32r/lib/memset.S.
Please apply.

Thanks.

Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 arch/m32r/lib/memset.S |   17 ++++++++++-------
 1 files changed, 10 insertions(+), 7 deletions(-)

diff -ruNp a/arch/m32r/lib/memset.S b/arch/m32r/lib/memset.S
--- a/arch/m32r/lib/memset.S	2004-10-19 06:55:28.000000000 +0900
+++ b/arch/m32r/lib/memset.S	2004-11-02 18:39:09.000000000 +0900
@@ -70,16 +70,18 @@ qword_set_loop:
 	st	r1, @+r4
 	bnc	qword_set_loop	    ||  cmpz	r2
 	jc	r14
-word_set_wrap:
+set_remainder:
 	cmpui	r2, #4
-	bc	byte_set
+	bc	byte_set_wrap1
 	addi	r2, #-4
 	bra	word_set_loop
 
 byte_set_wrap:
 	addi	r2, #4
-	addi	r4, #4		    ||  cmpz	r2
+	cmpz	r2
 	jc	r14
+byte_set_wrap1:
+	addi	r4, #4
 #if defined(CONFIG_ISA_M32R2)
 byte_set:
 	addi	r2, #-1		    ||	stb	r1, @r4+
@@ -153,18 +155,19 @@ qword_set_loop:
 	st	r1, @+r4
 	st	r1, @+r4
 	bnc	qword_set_loop
-	bnez	r2, word_set_wrap
+	bnez	r2, set_remainder
 	jmp	r14
-word_set_wrap:
+set_remainder:
 	cmpui	r2, #4
-	bc	byte_set
+	bc	byte_set_wrap1
 	addi	r2, #-4
 	bra	word_set_loop
 
 byte_set_wrap:
 	addi	r2, #4
-	addi	r4, #4
 	beqz	r2, end_memset
+byte_set_wrap1:
+	addi	r4, #4
 byte_set:
 	addi	r2, #-1
 	stb	r1, @r4

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
