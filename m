Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751311AbWHaJyA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751311AbWHaJyA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 05:54:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751411AbWHaJx7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 05:53:59 -0400
Received: from ns.miraclelinux.com ([219.118.163.66]:45585 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1751311AbWHaJx7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 05:53:59 -0400
Date: Thu, 31 Aug 2006 18:49:05 +0900
From: Akinobu Mita <mita@miraclelinux.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] rate limiting for the ldisc open faulure messages
Message-ID: <20060831094905.GA13400@miraclelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch limits the messages when ldisc open faulures happen.
It happens under memory pressure.

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>

 drivers/char/tty_io.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

Index: work-shouldfail/drivers/char/tty_io.c
===================================================================
--- work-shouldfail.orig/drivers/char/tty_io.c
+++ work-shouldfail/drivers/char/tty_io.c
@@ -2072,8 +2072,9 @@ fail_no_mem:
 
 	/* call the tty release_mem routine to clean out this slot */
 release_mem_out:
-	printk(KERN_INFO "init_dev: ldisc open failed, "
-			 "clearing slot %d\n", idx);
+	if (printk_ratelimit())
+		printk(KERN_INFO "init_dev: ldisc open failed, "
+				 "clearing slot %d\n", idx);
 	release_mem(tty, idx);
 	goto end_init;
 }
