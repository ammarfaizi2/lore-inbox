Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264477AbUEDQJf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264477AbUEDQJf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 12:09:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264484AbUEDQJf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 12:09:35 -0400
Received: from hera.cwi.nl ([192.16.191.8]:50852 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S264477AbUEDQJS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 12:09:18 -0400
Date: Tue, 4 May 2004 18:09:12 +0200 (MEST)
From: <Andries.Brouwer@cwi.nl>
Message-Id: <UTC200405041609.i44G9CH29412.aeb@smtp.cwi.nl>
To: akpm@osdl.org, torvalds@osdl.org
Subject: [PATCH] report size of printk buffer
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the old days the printk log buffer had a constant size,
and dmesg asked for the 4096, later 8192, later 16384 bytes in there.
These days the printk log buffer has variable size, and it is not
easy for dmesg to do the right thing, especially when doing a
"read and clear".
The patch below adds a syslog subfuntion that reports the buffer size.

Andries

diff -uprN -X /linux/dontdiff a/kernel/printk.c b/kernel/printk.c
--- a/kernel/printk.c	2004-03-28 17:11:55.000000000 +0200
+++ b/kernel/printk.c	2004-05-04 18:00:27.000000000 +0200
@@ -240,6 +240,7 @@ __setup("log_buf_len=", log_buf_len_setu
  * 	7 -- Enable printk's to console
  *	8 -- Set level of messages printed to console
  *	9 -- Return number of unread characters in the log buffer
+ *     10 -- Return size of the log buffer
  */
 int do_syslog(int type, char __user * buf, int len)
 {
@@ -359,6 +360,9 @@ int do_syslog(int type, char __user * bu
 	case 9:		/* Number of chars in the log buffer */
 		error = log_end - log_start;
 		break;
+	case 10:	/* Size of the log buffer */
+		error = log_buf_len;
+		break;
 	default:
 		error = -EINVAL;
 		break;
