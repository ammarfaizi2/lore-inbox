Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266765AbTAIOpY>; Thu, 9 Jan 2003 09:45:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266761AbTAIOpY>; Thu, 9 Jan 2003 09:45:24 -0500
Received: from [66.70.28.20] ([66.70.28.20]:55557 "EHLO
	maggie.piensasolutions.com") by vger.kernel.org with ESMTP
	id <S266765AbTAIOpW>; Thu, 9 Jan 2003 09:45:22 -0500
Date: Thu, 9 Jan 2003 15:56:59 +0100
From: DervishD <raul@pleyades.net>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: [TRIVIAL] mmap.c corner case fix
Message-ID: <20030109145659.GB164@DervishD>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

    Hi Marcelo :)

    This patch fixes a corner case on the mmap() syscall.

    The patch is from David S. Miller, not me. My patch was
incomplete and did nothing on 'big TASK_SIZE' architectures.

    The patch is against both 2.4.20 and 2.4.21-pre1, is just the same.

    Raúl

--sdtB3X0nJg68CQEu
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

--sdtB3X0nJg68CQEu--
