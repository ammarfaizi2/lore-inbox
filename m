Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932437AbWFSM46@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932437AbWFSM46 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 08:56:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932438AbWFSM46
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 08:56:58 -0400
Received: from mail.mnsspb.ru ([84.204.75.2]:699 "EHLO mail.mnsspb.ru")
	by vger.kernel.org with ESMTP id S932437AbWFSM45 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 08:56:57 -0400
From: Kirill Smelkov <kirr@mns.spb.ru>
Organization: MNS
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] x86: compile fix for asm-i386/alternatives.h
Date: Mon, 19 Jun 2006 16:53:56 +0400
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606191653.58076.kirr@mns.spb.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

compile fix:  <asm-i386/alternative.h>  needs  <asm/types.h> for 'u8' -- 
just look at struct alt_instr.

My module includes <asm/bitops.h> as the first header, and as of 2.6.17 this
leads to compilation errors.

Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>

Index: linux-2.6.17/include/asm-i386/alternative.h
===================================================================
--- linux-2.6.17.orig/include/asm-i386/alternative.h	2006-06-18 05:49:35.000000000 +0400
+++ linux-2.6.17/include/asm-i386/alternative.h	2006-06-19 16:44:17.000000000 +0400
@@ -3,6 +3,8 @@
 
 #ifdef __KERNEL__
 
+#include <asm/types.h>
+
 struct alt_instr {
 	u8 *instr; 		/* original instruction */
 	u8 *replacement;


