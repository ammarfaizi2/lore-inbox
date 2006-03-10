Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751408AbWCJQfK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751408AbWCJQfK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 11:35:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbWCJQfK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 11:35:10 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:16028 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751336AbWCJQfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 11:35:08 -0500
From: Pat Gefre <pfg@sgi.com>
Message-Id: <200603101634.k2AGYvAo148109@fsgi900.americas.sgi.com>
Subject: [PATCH] 2.6 Altix : small ioc4 oversight....
To: linux-kernel@vger.kernel.org
Date: Fri, 10 Mar 2006 10:34:56 -0600 (CST)
Cc: akpm@osdl.org
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I shoulda caught this when I reviewed the code for the recent serial
core changes - sorry....

Get rid of the local 'flip' variable and no need to 'trim' the buffer.


Signed-off-by: Patrick Gefre <pfg@sgi.com>


 ioc4_serial.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)


Index: linux-2.6/drivers/serial/ioc4_serial.c
===================================================================
--- linux-2.6.orig/drivers/serial/ioc4_serial.c	2006-03-09 11:37:31.153784820 -0600
+++ linux-2.6/drivers/serial/ioc4_serial.c	2006-03-09 11:38:36.697103905 -0600
@@ -2301,7 +2301,6 @@
 	int read_count, request_count = IOC4_MAX_CHARS;
 	struct uart_icount *icount;
 	struct uart_info *info = the_port->info;
-	int flip = 0;
 	unsigned long pflags;
 
 	/* Make sure all the pointers are "good" ones */
@@ -2313,7 +2312,7 @@
 	spin_lock_irqsave(&the_port->lock, pflags);
 	tty = info->tty;
 
-	request_count = tty_buffer_request_room(tty, IOC4_MAX_CHARS - 2);
+	request_count = tty_buffer_request_room(tty, IOC4_MAX_CHARS);
 
 	if (request_count > 0) {
 		icount = &the_port->icount;
@@ -2326,8 +2325,7 @@
 
 	spin_unlock_irqrestore(&the_port->lock, pflags);
 
-	if (flip)
-		tty_flip_buffer_push(tty);
+	tty_flip_buffer_push(tty);
 }
 
 /**
