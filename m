Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263271AbUDORrN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 13:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263172AbUDORoh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 13:44:37 -0400
Received: from mail.kroah.org ([65.200.24.183]:26806 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263171AbUDORmQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 13:42:16 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core update for 2.6.6-rc1
In-Reply-To: <10820509111858@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Thu, 15 Apr 2004 10:41:51 -0700
Message-Id: <10820509113014@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1643.36.3, 2004/03/19 13:12:46-08:00, greg@kroah.com

VC: fix bug in vty_init() where vcs_init() was not called early enough.

It was being used before initialized, not nice :(


 drivers/char/vt.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)


diff -Nru a/drivers/char/vt.c b/drivers/char/vt.c
--- a/drivers/char/vt.c	Thu Apr 15 10:21:17 2004
+++ b/drivers/char/vt.c	Thu Apr 15 10:21:17 2004
@@ -2602,6 +2602,8 @@
 
 int __init vty_init(void)
 {
+	vcs_init();
+
 	console_driver = alloc_tty_driver(MAX_NR_CONSOLES);
 	if (!console_driver)
 		panic("Couldn't allocate console driver\n");
@@ -2629,7 +2631,6 @@
 #ifdef CONFIG_FRAMEBUFFER_CONSOLE
 	fb_console_init();
 #endif	
-	vcs_init();
 	return 0;
 }
 

