Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161273AbWF0UQS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161273AbWF0UQS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 16:16:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161275AbWF0UQR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 16:16:17 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:56960 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1161274AbWF0UQP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 16:16:15 -0400
Message-Id: <20060627201333.225567000@sous-sol.org>
References: <20060627200745.771284000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 27 Jun 2006 00:00:13 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org, kirr@mns.spb.ru
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk
Subject: [PATCH 13/25] x86: compile fix for asm-i386/alternatives.h
Content-Disposition: inline; filename=x86-compile-fix-for-asm-i386-alternatives.h.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Kirill Smelkov <kirr@mns.spb.ru>

compile fix:  <asm-i386/alternative.h>  needs  <asm/types.h> for 'u8' --
just look at struct alt_instr.

My module includes <asm/bitops.h> as the first header, and as of 2.6.17 this
leads to compilation errors.

Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
Cc: <stable@kernel.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 include/asm-i386/alternative.h |    2 ++
 1 file changed, 2 insertions(+)

--- linux-2.6.17.1.orig/include/asm-i386/alternative.h
+++ linux-2.6.17.1/include/asm-i386/alternative.h
@@ -3,6 +3,8 @@
 
 #ifdef __KERNEL__
 
+#include <asm/types.h>
+
 struct alt_instr {
 	u8 *instr; 		/* original instruction */
 	u8 *replacement;

--
