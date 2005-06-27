Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261425AbVF0QBs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261425AbVF0QBs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 12:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262056AbVF0PUX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 11:20:23 -0400
Received: from mo01.iij4u.or.jp ([210.130.0.20]:18939 "EHLO mo01.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S261757AbVF0Ou7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 10:50:59 -0400
Date: Mon, 27 Jun 2005 23:50:51 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Andrew Morton <akpm@osdl.org>
Cc: yuasa@hh.iij4u.or.jp, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.12] mips: fixed try_to_freeze build error
Message-Id: <20050627235051.375e6c47.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch had fixed try_to_freeze build error.

  CC      arch/mips/kernel/signal.o
arch/mips/kernel/signal.c: In function 'do_signal':
arch/mips/kernel/signal.c:460: error: too many arguments to function 'try_to_freeze'
make[1]: *** [arch/mips/kernel/signal.o] Error 1
make: *** [arch/mips/kernel] Error 2

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff git8-orig/arch/mips/kernel/signal.c git8/arch/mips/kernel/signal.c
--- git8-orig/arch/mips/kernel/signal.c	Sat Jun 18 04:48:29 2005
+++ git8/arch/mips/kernel/signal.c	Mon Jun 27 22:51:19 2005
@@ -457,7 +457,7 @@
 	if (!user_mode(regs))
 		return 1;
 
-	if (try_to_freeze(0))
+	if (try_to_freeze())
 		goto no_signal;
 
 	if (!oldset)
