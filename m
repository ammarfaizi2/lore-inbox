Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751093AbWHPQIJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbWHPQIJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 12:08:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751095AbWHPQII
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 12:08:08 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:57053 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751093AbWHPQIG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 12:08:06 -0400
Subject: PATCH: Trivial kzalloc opportunity
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 16 Aug 2006 17:28:48 +0100
Message-Id: <1155745728.24077.354.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc4-mm1/drivers/char/tty_io.c linux-2.6.18-rc4-mm1/drivers/char/tty_io.c
--- linux.vanilla-2.6.18-rc4-mm1/drivers/char/tty_io.c	2006-08-15 15:40:16.000000000 +0100
+++ linux-2.6.18-rc4-mm1/drivers/char/tty_io.c	2006-08-15 16:01:19.000000000 +0100
@@ -160,17 +160,11 @@
  *	been initialized in any way but has been zeroed
  *
  *	Locking: none
- *	FIXME: use kzalloc
  */
 
 static struct tty_struct *alloc_tty_struct(void)
 {
-	struct tty_struct *tty;
-
-	tty = kmalloc(sizeof(struct tty_struct), GFP_KERNEL);
-	if (tty)
-		memset(tty, 0, sizeof(struct tty_struct));
-	return tty;
+	return (struct tty_struct *)kzalloc(sizeof(struct tty_struct), GFP_KERNEL);
 }
 
 static void tty_buffer_free_all(struct tty_struct *);

