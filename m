Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267508AbTACMgZ>; Fri, 3 Jan 2003 07:36:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267509AbTACMgZ>; Fri, 3 Jan 2003 07:36:25 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:9159 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S267508AbTACMgY>; Fri, 3 Jan 2003 07:36:24 -0500
Date: Fri, 3 Jan 2003 13:44:48 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix 2.5 compiles w/ networking off
Message-ID: <20030103124448.GD1360@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All right I have to admit I can't think of another cunning simile.
We should compile w/ networking switched off entirely, too.

-- 
Tomas Szepe <szepe@pinerecords.com>


--- a/net/socket.c	2002-12-08 20:06:42.000000000 +0100
+++ b/net/socket.c	2003-01-03 13:31:20.000000000 +0100
@@ -742,11 +742,11 @@
 		err = dev_ioctl(cmd, (void *)arg);
 	} else
 #endif  /* CONFIG_NET */
-#ifdef WIRELESS_EXT
+#if defined(CONFIG_NET) && defined (WIRELESS_EXT)
 	if (cmd >= SIOCIWFIRST && cmd <= SIOCIWLAST) {
 		err = dev_ioctl(cmd, (void *)arg);
 	} else
-#endif	/* WIRELESS_EXT */
+#endif /* CONFIG_NET && WIRELESS_EXT */
 	switch (cmd) {
 		case FIOSETOWN:
 		case SIOCSPGRP:
