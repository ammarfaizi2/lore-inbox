Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262175AbUE1DqP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262175AbUE1DqP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 23:46:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262176AbUE1DqP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 23:46:15 -0400
Received: from gate.crashing.org ([63.228.1.57]:65179 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262175AbUE1DqO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 23:46:14 -0400
Subject: [PATCH] Fix typo in pmac_zilog
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1085715655.6320.138.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 28 May 2004 13:40:55 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

This patch fixes a typo preventing channel B from working on the Rx
path of pmac zilog (never calling tty_flip_*). I think I never tested
channel B :)

Please, apply. Thanks to Hollis Blanchard for spotting the bug.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

--- 1.10/drivers/serial/pmac_zilog.c	2004-05-07 21:06:49 +10:00
+++ edited/drivers/serial/pmac_zilog.c	2004-05-28 13:38:07 +10:00
@@ -483,7 +483,7 @@
        		if (r3 & CHBEXT)
        			pmz_status_handle(uap_b, regs);
        	       	if (r3 & CHBRxIP)
-       			pmz_receive_chars(uap_b, regs);
+       			tty = pmz_receive_chars(uap_b, regs);
        		if (r3 & CHBTxIP)
        			pmz_transmit_chars(uap_b);
 	       	rc = IRQ_HANDLED;


