Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317777AbSGVQIU>; Mon, 22 Jul 2002 12:08:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317778AbSGVQIU>; Mon, 22 Jul 2002 12:08:20 -0400
Received: from pump3.york.ac.uk ([144.32.128.131]:47777 "EHLO pump3.york.ac.uk")
	by vger.kernel.org with ESMTP id <S317777AbSGVQIT>;
	Mon, 22 Jul 2002 12:08:19 -0400
Date: Mon, 22 Jul 2002 16:35:16 +0100 (BST)
From: Ewan Mac Mahon <ecm103@york.ac.uk>
X-X-Sender: ewan@talisker.york.ac.uk
To: James Simmons <jsimmons@transvirtual.com>
cc: linux-kernel@vger.kernel.org
Subject: VT code in 2.5.26,27 breaks with devfs
Message-ID: <Pine.LNX.4.44.0207221632460.31044-100000@talisker.york.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

It seems that the rearranged VT/console init code in 2.5.26 and 2.5.27
doesn't call con_init_devfs to register the VTs. On boot a devfs only
system can't open gettys since the /dev/vc/x nodes don't exist, while a
non-devfs system is fine.

This one liner fixes it for me,

Ewan

diff -urN linux-2.5.27-clean/drivers/char/console.c linux-2.5.27-devfs_vc/drivers/char/console.c
--- linux-2.5.27-clean/drivers/char/console.c	Sat Jul 20 20:11:57 2002
+++ linux-2.5.27-devfs_vc/drivers/char/console.c	Mon Jul 22 10:44:09 2002
@@ -2525,6 +2525,7 @@
 
 	kbd_init();
 	console_map_init();
+	con_init_devfs();
 	vcs_init();
 	return 0;
 }








