Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262620AbTCIUbi>; Sun, 9 Mar 2003 15:31:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262619AbTCIUbi>; Sun, 9 Mar 2003 15:31:38 -0500
Received: from home.linuxhacker.ru ([194.67.236.68]:45207 "EHLO linuxhacker.ru")
	by vger.kernel.org with ESMTP id <S262620AbTCIUbg>;
	Sun, 9 Mar 2003 15:31:36 -0500
Date: Sun, 9 Mar 2003 23:41:25 +0300
From: Oleg Drokin <green@linuxhacker.ru>
To: alan@redhat.com, linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: Memleak in Windows Logical Disk Manager partition handler
Message-ID: <20030309204125.GA31534@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   Not freeing allocated memory on error exit path.
   See the patch.
   Should apply to both 2.4 and 2.5.
   Found with help of smatch + enhanced unfree script.

Bye,
    Oleg

===== fs/partitions/ldm.c 1.6 vs edited =====
--- 1.6/fs/partitions/ldm.c	Mon Aug 12 00:08:42 2002
+++ edited/fs/partitions/ldm.c	Sun Mar  9 23:38:15 2003
@@ -1223,8 +1223,10 @@
 		return FALSE;
 	}
 
-	if (!ldm_parse_vblk (data, len, vb))
+	if (!ldm_parse_vblk (data, len, vb)) {
+		kfree(vb);
 		return FALSE;			/* Already logged */
+	}
 
 	/* Put vblk into the correct list. */
 	switch (vb->type) {
