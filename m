Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267139AbSLKNY3>; Wed, 11 Dec 2002 08:24:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267141AbSLKNY3>; Wed, 11 Dec 2002 08:24:29 -0500
Received: from [66.70.28.20] ([66.70.28.20]:5387 "EHLO
	maggie.piensasolutions.com") by vger.kernel.org with ESMTP
	id <S267139AbSLKNXg>; Wed, 11 Dec 2002 08:23:36 -0500
Date: Wed, 11 Dec 2002 14:16:44 +0100
From: DervishD <raul@pleyades.net>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@redhat.com>
Subject: [PATCH] mmap.c corner case fix, per David S. Miller
Message-ID: <20021211131644.GC48@DervishD>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

    Hi Marcelo :)

    This patch fixes the same corner case, but does something useful
even or architectures where TASK_SIZE is greater than SIZE_MAX-PAGE_SIZE

    The patch is from David S. Miller, not me. My patch was
incomplete and did nothing on 'big TASK_SIZE' architectures, as
sparc64.

    The patch is against both 2.4.20 and 2.4.21-pre1, is just the same.

    Raúl

--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=iso-8859-1
Content-Description: mmap.c.diff
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

--tThc/1wpZn/ma/RB--
