Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272334AbTG1ACZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 20:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272325AbTG1ABx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 20:01:53 -0400
Received: from zeus.kernel.org ([204.152.189.113]:31477 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S272926AbTG0XBb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 19:01:31 -0400
Date: Sun, 27 Jul 2003 21:05:52 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307272005.h6RK5qmX029629@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: fix return on pms change
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/drivers/media/video/pms.c linux-2.6.0-test2-ac1/drivers/media/video/pms.c
--- linux-2.6.0-test2/drivers/media/video/pms.c	2003-07-27 19:56:24.000000000 +0100
+++ linux-2.6.0-test2-ac1/drivers/media/video/pms.c	2003-07-27 20:17:24.000000000 +0100
@@ -664,7 +664,7 @@
 				dt=count-len;
 			cnt += dev->height;
 			if (copy_to_user(buf, tmp+32, dt))
-				return -EFAULT;
+				return len ? len : -EFAULT;
 			buf += dt;    
 			len += dt;
 		}
