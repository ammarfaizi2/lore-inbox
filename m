Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261647AbULFU51@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261647AbULFU51 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 15:57:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261644AbULFU51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 15:57:27 -0500
Received: from math.ut.ee ([193.40.5.125]:29840 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S261647AbULFU5K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 15:57:10 -0500
Date: Mon, 6 Dec 2004 22:57:06 +0200 (EET)
From: Riina Kikas <riinak@ut.ee>
To: linux-kernel@vger.kernel.org
cc: mroos@ut.ee
Subject: [PATCH 2.6] clean-up: fixes "comparison between signed and unsigned"
Message-ID: <Pine.SOC.4.61.0412062255170.21075@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes warning "comparison between signed and unsigned"
occuring on line 308

Signed-off-by: Riina Kikas <Riina.Kikas@mail.ee>

--- a/arch/i386/mm/fault.c	2004-12-02 21:30:30.000000000 +0000
+++ b/arch/i386/mm/fault.c	2004-12-02 21:30:59.000000000 +0000
@@ -302,7 +302,13 @@
  		 * pusha) doing post-decrement on the stack and that
  		 * doesn't show up until later..
  		 */
-		if (address + 32 < regs->esp)
+		unsigned long regs_esp;
+		if (regs->esp < 0) {
+			regs_esp = 0;
+		} else {
+			regs_esp = regs->esp;
+		}
+		if (address + 32 < regs_esp)
  			goto bad_area;
  	}
  	if (expand_stack(vma, address))
