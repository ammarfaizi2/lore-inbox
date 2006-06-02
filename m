Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751356AbWFBSOp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751356AbWFBSOp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 14:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751407AbWFBSOp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 14:14:45 -0400
Received: from mtagate3.uk.ibm.com ([195.212.29.136]:13368 "EHLO
	mtagate3.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1751356AbWFBSOo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 14:14:44 -0400
Subject: [Patch] restore correct print_len calculation in printk
From: Martin Peschke <mp3@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Tim Bird <tim.bird@am.sony.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 02 Jun 2006 20:14:39 +0200
Message-Id: <1149272080.2958.7.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the following miscalculation that has been introduced by my
statistics-infrastructure-prerequisite-timestamp.patch:

print_len loses 3 in the 'got log level'-case due to a surplus
substraction. It also loses 3 in the other case due to adding a log
level substring that is not entered in the books.

Signed-off-by: Martin Peschke <mp3@de.ibm.com>
---

 printk.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/printk.c	2006-06-01 10:04:45.000000000 +0200
+++ b/kernel/printk.c	2006-06-01 10:08:46.000000000 +0200
@@ -515,9 +515,9 @@
 			    p[1] <= '7' && p[2] == '>') {
 				loglev_char = p[1];
 				p += 3;
-				printed_len -= 3;
 			} else	{
 				loglev_char = default_message_loglevel + '0';
+				printed_len += 3;
 			}
 			emit_log_char('<');
 			emit_log_char(loglev_char);


