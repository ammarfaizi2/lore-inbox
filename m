Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750931AbVJ2LCE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750931AbVJ2LCE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 07:02:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750936AbVJ2LCE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 07:02:04 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:50911 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750931AbVJ2LCB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 07:02:01 -0400
Date: Sat, 29 Oct 2005 12:02:00 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, Dmitry Torokhov <dtor@mail.ru>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH] bluetooth hidp is broken on s390
Message-ID: <20051029110200.GH7992@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Bluetooth HIDP selects INPUT and it really needs it to be
there - module depends on input core.  And input core is never
built on s390...  Marked as broken on s390, for now; if somebody
has better ideas, feel free to fix it and remove dependency...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN RC14-base/net/bluetooth/hidp/Kconfig current/net/bluetooth/hidp/Kconfig
--- RC14-base/net/bluetooth/hidp/Kconfig	2005-06-17 15:48:29.000000000 -0400
+++ current/net/bluetooth/hidp/Kconfig	2005-10-29 06:14:28.000000000 -0400
@@ -1,6 +1,6 @@
 config BT_HIDP
 	tristate "HIDP protocol support"
-	depends on BT && BT_L2CAP
+	depends on BT && BT_L2CAP && (BROKEN || !S390)
 	select INPUT
 	help
 	  HIDP (Human Interface Device Protocol) is a transport layer
