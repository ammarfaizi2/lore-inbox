Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261408AbVAGNhJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261408AbVAGNhJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 08:37:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261409AbVAGNhI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 08:37:08 -0500
Received: from smtp2.libero.it ([193.70.192.52]:10191 "EHLO smtp2.libero.it")
	by vger.kernel.org with ESMTP id S261408AbVAGNhE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 08:37:04 -0500
From: Marco Cipullo <cipullo@libero.it>
To: linux-kernel@vger.kernel.org
Subject: In last setsid/tty locking changes...
Date: Fri, 7 Jan 2005 14:37:02 +0100
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501071437.02426.cipullo@libero.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In last setsid/tty locking changes:

diff -Nru a/kernel/exit.c b/kernel/exit.c
--- a/kernel/exit.c	2005-01-07 05:24:41 -08:00
+++ b/kernel/exit.c	2005-01-07 05:24:41 -08:00
@@ -332,7 +332,9 @@
 	exit_mm(current);
 
 	set_special_pids(1, 1);
+	down(&tty_sem);
 	current->signal->tty = NULL;
+	up(&tty_sem);
 
 	/* Block and flush all signals */
 	sigfillset(&blocked);

Sorry for the silly question, but why is needed a semaphore to write just one 
value without read/write nothing else?

Bye
Marco
