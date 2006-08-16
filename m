Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751095AbWHPQOr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbWHPQOr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 12:14:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751102AbWHPQOr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 12:14:47 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:44005 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751095AbWHPQOq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 12:14:46 -0400
Subject: PATCH: Fix crash case
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 16 Aug 2006 17:35:31 +0100
Message-Id: <1155746131.24077.363.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If we are going to BUG() not panic() here then we should cover the case
of the BUG being compiled out

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc4-mm1/kernel/exit.c linux-2.6.18-rc4-mm1/kernel/exit.c
--- linux.vanilla-2.6.18-rc4-mm1/kernel/exit.c	2006-08-15 15:40:19.000000000 +0100
+++ linux-2.6.18-rc4-mm1/kernel/exit.c	2006-08-15 16:03:23.000000000 +0100
@@ -979,7 +979,8 @@
 	schedule();
 	BUG();
 	/* Avoid "noreturn function does return".  */
-	for (;;) ;
+	for (;;)
+		cpu_relax();	/* For when BUG is null */
 }
 
 EXPORT_SYMBOL_GPL(do_exit);

