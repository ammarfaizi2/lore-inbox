Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262959AbSLBBRH>; Sun, 1 Dec 2002 20:17:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262981AbSLBBRH>; Sun, 1 Dec 2002 20:17:07 -0500
Received: from [211.101.140.97] ([211.101.140.97]:41476 "EHLO
	dns.rabbit.redflag-linux.com") by vger.kernel.org with ESMTP
	id <S262959AbSLBBRH> convert rfc822-to-8bit; Sun, 1 Dec 2002 20:17:07 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Zou Pengcheng <pczou@redflag-linux.com>
Organization: RedFlag Linux
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH] dnotify fix for readv/writev (Linux 2.4.20)
Date: Mon, 2 Dec 2002 09:22:43 +0800
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200212020922.43820.pczou@redflag-linux.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi, Marcelo,

this is a patch to fix the dnotify bug of readv/writev. 

Orignally DN_MODIFY is issued on readv while DN_ACCESS is issued on writev, 
which is obviously wrong. This patch fixes such problem.

cheers,
  -- Pengcheng Zou

diff -uNr fs/read_write.c.orig fs/read_write.c
--- fs/read_write.c.orig        Mon Dec  2 09:07:34 2002
+++ fs/read_write.c     Mon Dec  2 09:08:26 2002
@@ -315,7 +315,7 @@
        /* VERIFY_WRITE actually means a read, as we write to user space */
        if ((ret + (type == VERIFY_WRITE)) > 0)
                dnotify_parent(file->f_dentry,
-                       (type == VERIFY_WRITE) ? DN_MODIFY : DN_ACCESS);
+                       (type == VERIFY_WRITE) ? DN_ACCESS : DN_MODIFY);
        return ret;
 }

