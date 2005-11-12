Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932455AbVKLSDW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932455AbVKLSDW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 13:03:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932462AbVKLSCt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 13:02:49 -0500
Received: from host20-103.pool873.interbusiness.it ([87.3.103.20]:8904 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S932463AbVKLSCp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 13:02:45 -0500
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 9/9] uml: fix daemon transport exit path bug
Date: Sat, 12 Nov 2005 19:08:03 +0100
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20051112180801.20133.67833.stgit@zion.home.lan>
In-Reply-To: <20051112180711.20133.68166.stgit@zion.home.lan>
References: <20051112180711.20133.68166.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Fix some exit path bugs in the daemon driver.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/drivers/daemon_user.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/um/drivers/daemon_user.c b/arch/um/drivers/daemon_user.c
index c1b03f7..1bb085b 100644
--- a/arch/um/drivers/daemon_user.c
+++ b/arch/um/drivers/daemon_user.c
@@ -98,7 +98,7 @@ static int connect_to_switch(struct daem
 		printk("daemon_open : control setup request failed, err = %d\n",
 		       -n);
 		err = -ENOTCONN;
-		goto out;		
+		goto out_free;
 	}
 
 	n = os_read_file(pri->control, sun, sizeof(*sun));
@@ -106,12 +106,14 @@ static int connect_to_switch(struct daem
 		printk("daemon_open : read of data socket failed, err = %d\n",
 		       -n);
 		err = -ENOTCONN;
-		goto out_close;		
+		goto out_free;
 	}
 
 	pri->data_addr = sun;
 	return(fd);
 
+ out_free:
+	kfree(sun);
  out_close:
 	os_close_file(fd);
  out:

