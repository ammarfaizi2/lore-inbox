Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261900AbTANJiO>; Tue, 14 Jan 2003 04:38:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261907AbTANJiO>; Tue, 14 Jan 2003 04:38:14 -0500
Received: from [66.70.28.20] ([66.70.28.20]:2822 "EHLO
	maggie.piensasolutions.com") by vger.kernel.org with ESMTP
	id <S261900AbTANJiN>; Tue, 14 Jan 2003 04:38:13 -0500
Date: Tue, 14 Jan 2003 10:39:02 +0100
From: DervishD <raul@pleyades.net>
To: Linux-kernel <linux-kernel@vger.kernel.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH][TRIVIAL] mmap.c corner case fix
Message-ID: <20030114093902.GA225@DervishD>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

    Hi Marcelo :)

    This patch fixes a corner case on the mmap() syscall.

    The patch is from David S. Miller, not me. My patch was
incomplete and did nothing on 'big TASK_SIZE' architectures.

    The patch is against both 2.4.20 and 2.4.21-pre, is just the same.
Please apply. I sent you the incomplete patch at pre-1 and this bug
is getting older by the minute ;))

    Thanks :)

    Raúl

--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=iso-8859-1
Content-Description: mmap.c.diff for 2.4.20 and 2.4.21-pre
Content-Disposition: attachment; filename="mmap.c.2.4.20.diff"

--- linux/mm/mmap.c.orig	2002-12-11 13:59:37.000000000 +0100
+++ linux/mm/mmap.c	2002-12-11 14:01:16.000000000 +0100
@@ -403,10 +403,12 @@
 	if (file && (!file->f_op || !file->f_op->mmap))
 		return -ENODEV;
 
-	if ((len = PAGE_ALIGN(len)) == 0)
+	if (!len)
 		return addr;
 
-	if (len > TASK_SIZE)
+	len = PAGE_ALIGN(len);
+
+	if (len > TASK_SIZE || len == 0)
 		return -EINVAL;
 
 	/* offset overflow? */

--7AUc2qLy4jB3hD7Z--
