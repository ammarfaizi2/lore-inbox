Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272741AbTHKQEB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 12:04:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272747AbTHKQCu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 12:02:50 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:12582 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S272741AbTHKP7l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 11:59:41 -0400
To: torvalds@osdl.org
From: davej@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] boolean logic error in fpu emulation.
Message-Id: <E19mF4Y-0005Ed-00@tetrachloride>
Date: Mon, 11 Aug 2003 16:59:02 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/arch/i386/math-emu/fpu_trig.c linux-2.5/arch/i386/math-emu/fpu_trig.c
--- bk-linus/arch/i386/math-emu/fpu_trig.c	2003-04-10 06:01:09.000000000 +0100
+++ linux-2.5/arch/i386/math-emu/fpu_trig.c	2003-07-13 06:03:46.000000000 +0100
@@ -1058,7 +1058,7 @@ static void do_fprem(FPU_REG *st0_ptr, u
 	return;
       goto fprem_valid;
     }
-  else if ( (st0_tag == TAG_Empty) | (st1_tag == TAG_Empty) )
+  else if ( (st0_tag == TAG_Empty) || (st1_tag == TAG_Empty) )
     {
       FPU_stack_underflow();
       return;
