Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262398AbVAVBrz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262398AbVAVBrz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 20:47:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262419AbVAVBri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 20:47:38 -0500
Received: from ozlabs.org ([203.10.76.45]:33003 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262405AbVAVBr2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 20:47:28 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16881.45225.726680.430987@cargo.ozlabs.ibm.com>
Date: Sat, 22 Jan 2005 12:47:21 +1100
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Cc: anton@samba.org, moilanen@austin.ibm.com
Subject: [PATCH] PPC64 Fix in_be64 definition
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is from Jake Moilanen <moilanen@austin.ibm.com>.

The instruction syntax for the in_be64 inline asm was incorrect for
the "m" constraint for the address parameter.  This patch fixes the
instruction in the inline asm.

Signed-off-by: Jake Moilanen <moilanen@austin.ibm.com>
Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -puN include/asm-ppc64/io.h~in_be64-fix include/asm-ppc64/io.h
--- linux-2.6-bk/include/asm-ppc64/io.h~in_be64-fix	Tue Jan  4 15:33:22 2005
+++ linux-2.6-bk-moilanen/include/asm-ppc64/io.h	Wed Jan  5 08:08:03 2005
@@ -371,7 +371,7 @@ static inline unsigned long in_be64(cons
 {
 	unsigned long ret;
 
-	__asm__ __volatile__("ld %0,0(%1); twi 0,%0,0; isync"
+	__asm__ __volatile__("ld%U1%X1 %0,%1; twi 0,%0,0; isync"
 			     : "=r" (ret) : "m" (*addr));
 	return ret;
 }
