Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965035AbWGJPhn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965035AbWGJPhn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 11:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965053AbWGJPhn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 11:37:43 -0400
Received: from chester.provo.novell.com ([137.65.82.21]:24598 "EHLO
	chester.provo.novell.com") by vger.kernel.org with ESMTP
	id S965035AbWGJPhm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 11:37:42 -0400
Message-Id: <44B206D3.3C0A.0073.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Mon, 10 Jul 2006 09:37:32 -0600
From: "Adam Jerome" <abj@novell.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH 001/001] /fs/proc/: 'larger than buffer size' memory
	accesses by clear_user()
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adam B. Jerome <abj@novell.com>

This patch addresses potential 'larger than buffer size' memory accesses by clear_user().
Without this patch, this call to clear_user() can attempt to clear too many (tsz) bytes
resulting in a wrong (-EFAULT) return code by read_kcore().
Signed-off-by: Adam B. Jerome <abj@novell.com>
---

I do not subscribe to the list. Please CC posted answers/comments CC me <abj@novell.com>.
Thanks; -adam

diff -urpN linux-2.6-git/fs/proc/kcore.c linux-2.6-cur/fs/proc/kcore.c
--- linux-2.6-git/fs/proc/kcore.c	2006-07-07 15:39:23.000000000 -0600
+++ linux-2.6-cur/fs/proc/kcore.c	2006-07-07 16:11:58.000000000 -0600
@@ -384,7 +384,7 @@ read_kcore(struct file *file, char __use
 				 */
 				if (n) { 
 					if (clear_user(buffer + tsz - n,
-								tsz - n))
+								n))
 						return -EFAULT;
 				}
 			} else {



