Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315925AbSHXKAI>; Sat, 24 Aug 2002 06:00:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315928AbSHXKAI>; Sat, 24 Aug 2002 06:00:08 -0400
Received: from ns2.sea.interquest.net ([66.135.144.2]:41388 "EHLO ns2.sea")
	by vger.kernel.org with ESMTP id <S315925AbSHXKAH>;
	Sat, 24 Aug 2002 06:00:07 -0400
Date: Sat, 24 Aug 2002 03:10:03 -0700
From: silvio@qualys.com
To: linux-kernel@vger.kernel.org
Subject: [PATCH TRIVIAL]: repost 2.4.19/drivers/acorn/char/mouse_ps2.c
Message-ID: <20020824031003.B2399@hamsec.aurora.sfo.interquest.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="l76fUT7nc3MelDdI"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--l76fUT7nc3MelDdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

repost with attachment this time.

--
Silvio

--l76fUT7nc3MelDdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="patch.linux2"

--- linux-2.4.19/drivers/acorn/char/mouse_ps2.c	Fri Aug  2 17:39:43 2002
+++ linux-2.4.19-dev/drivers/acorn/char/mouse_ps2.c	Sat Aug 24 02:31:57 2002
@@ -273,9 +273,15 @@
 	iomd_writeb(0, IOMD_MSECTL);
 	iomd_writeb(8, IOMD_MSECTL);
   
-	if (misc_register(&psaux_mouse))
-		return -ENODEV;
 	queue = (struct aux_queue *) kmalloc(sizeof(*queue), GFP_KERNEL);
+	if (queue == NULL)
+		return -ENOMEM;
+
+	if (misc_register(&psaux_mouse)) {
+		kfree(queue);
+		return -ENODEV;
+	}
+
 	memset(queue, 0, sizeof(*queue));
 	queue->head = queue->tail = 0;
 	init_waitqueue_head(&queue->proc_list);

--l76fUT7nc3MelDdI--
