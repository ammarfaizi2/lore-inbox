Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261510AbTIKUgP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 16:36:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261511AbTIKUgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 16:36:15 -0400
Received: from home.linuxhacker.ru ([194.67.236.68]:20618 "EHLO linuxhacker.ru")
	by vger.kernel.org with ESMTP id S261510AbTIKUgM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 16:36:12 -0400
Date: Fri, 12 Sep 2003 00:31:46 +0400
From: Oleg Drokin <green@linuxhacker.ru>
To: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: [PATCH] [2.4] Rocketport driver compile fix
Message-ID: <20030911203146.GA28291@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   Rocketport driver does not compile in latest 2.4 bk, it seems to assume
   that tty->count is of atomic type which is no longer true.

   Seems that this patch is needed now.


===== drivers/char/rocket.c 1.9 vs edited =====
--- 1.9/drivers/char/rocket.c	Wed Aug 13 17:22:04 2003
+++ edited/drivers/char/rocket.c	Thu Sep 11 15:22:06 2003
@@ -1052,7 +1052,7 @@
 		restore_flags(flags);
 		return;
 	}
-	if ((atomic_read(&tty->count) == 1) && (info->count != 1)) {
+	if ((tty->count == 1) && (info->count != 1)) {
 		/*
 		 * Uh, oh.  tty->count is 1, which means that the tty
 		 * structure will be freed.  Info->count should always

Bye,
    Oleg
