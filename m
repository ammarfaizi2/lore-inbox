Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261934AbSLZDN2>; Wed, 25 Dec 2002 22:13:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261908AbSLZDN2>; Wed, 25 Dec 2002 22:13:28 -0500
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:7852 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S261934AbSLZDN1>; Wed, 25 Dec 2002 22:13:27 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH]  Fix socket.c compilation failure when CONFIG_NET=n
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20021226032124.487A236FE@mcspd15.ucom.lsi.nec.co.jp>
Date: Thu, 26 Dec 2002 12:21:24 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In net/socket.c, <linux/wireless.h> is included twice, once conditionally
(on CONFIG_NET_RADIO || CONFIG_NET_PCMCIA_RADIO) and once unconditionally.
However, including <linux/wireless.h> defines WIRELESS_EXT, and this causes an
#ifdef in `sock_ioctl' to reference `dev_ioctl', which isn't defined when
CONFIG_NET=n, and so results in an unresolved symbol reference in that case.

The following patch fixes this by removing the unconditional include, and only
keeping the conditional one.

diff -ruN -X../cludes linux-2.5.53-moo.orig/net/socket.c linux-2.5.53-moo/net/socket.c
--- linux-2.5.53-moo.orig/net/socket.c	2002-11-25 10:30:11.000000000 +0900
+++ linux-2.5.53-moo/net/socket.c	2002-12-26 11:43:49.000000000 +0900
@@ -75,7 +75,6 @@
 #include <linux/cache.h>
 #include <linux/module.h>
 #include <linux/highmem.h>
-#include <linux/wireless.h>
 #include <linux/divert.h>
 #include <linux/mount.h>
 
