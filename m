Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261422AbVANS6O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261422AbVANS6O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 13:58:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261343AbVANS5L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 13:57:11 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:21411 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S261372AbVANSzZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 13:55:25 -0500
Date: Fri, 14 Jan 2005 19:55:23 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 4/8] s390: 3270 console.
Message-ID: <20050114185523.GD6789@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 4/8] s390: 3270 console.

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

3270 console changes:
 - Initialize timer element before first use.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 drivers/s390/char/tty3270.c |    1 +
 1 files changed, 1 insertion(+)

diff -urN linux-2.6/drivers/s390/char/tty3270.c linux-2.6-patched/drivers/s390/char/tty3270.c
--- linux-2.6/drivers/s390/char/tty3270.c	2005-01-14 19:44:49.000000000 +0100
+++ linux-2.6-patched/drivers/s390/char/tty3270.c	2005-01-14 19:45:18.000000000 +0100
@@ -706,6 +706,7 @@
 	if (!tp->freemem_pages)
 		goto out_tp;
 	INIT_LIST_HEAD(&tp->freemem);
+	init_timer(&tp->timer);
 	for (pages = 0; pages < TTY3270_STRING_PAGES; pages++) {
 		tp->freemem_pages[pages] = (void *)
 			__get_free_pages(GFP_KERNEL|GFP_DMA, 0);
