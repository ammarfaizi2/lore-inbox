Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316213AbSHIW3s>; Fri, 9 Aug 2002 18:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316217AbSHIW3s>; Fri, 9 Aug 2002 18:29:48 -0400
Received: from pD952AEB1.dip.t-dialin.net ([217.82.174.177]:61060 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S316213AbSHIW3r>; Fri, 9 Aug 2002 18:29:47 -0400
Date: Fri, 9 Aug 2002 16:33:18 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Michael Procter <lkml@procter-collective.org.uk>
cc: kuznet@ms2.inr.ac.ru, <linux-kernel@vger.kernel.org>
Subject: Re: Unix-domain sockets - abstract addresses
In-Reply-To: <20020809145212.B1244@cad.citel.com>
Message-ID: <Pine.LNX.4.44.0208091632270.10270-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 9 Aug 2002, Michael Procter wrote:
> --- af_unix.c.orig	Fri Aug  9 14:10:05 2002
> +++ af_unix.c	Fri Aug  9 14:17:38 2002

Well, if it's right, here goes the update:

--- linus-2.5/net/unix/af_unix.c	Mon Aug  5 12:02:05 2002
+++ thunder-2.5/net/unix/af_unix.c	Fri Aug  9 16:28:36 2002
@@ -79,6 +79,8 @@
  *		  with BSD names.
  */
 
+#undef unix	/* KBUILD_MODNAME */
+
 #include <linux/module.h>
 #include <linux/config.h>
 #include <linux/kernel.h>
@@ -1114,9 +1116,7 @@
 
 	unix_state_rlock(sk);
 	if (!u->addr) {
-		sunaddr->sun_family = AF_UNIX;
-		sunaddr->sun_path[0] = 0;
-		*uaddr_len = sizeof(short);
+		*uaddr_len = 0;
 	} else {
 		struct unix_address *addr = u->addr;
 
@@ -1400,7 +1400,8 @@
 {
 	struct unix_sock *u = unix_sk(sk);
 
-	msg->msg_namelen = sizeof(short);
+	msg->msg_namelen = 0;
+
 	if (u->addr) {
 		msg->msg_namelen = u->addr->len;
 		memcpy(msg->msg_name, u->addr->name, u->addr->len);

			Thunder
-- 
--./../...-/. -.--/---/..-/.-./..././.-../..-. .---/..-/.../- .-
--/../-./..-/-/./--..-- ../.----./.-../.-.. --./../...-/. -.--/---/..-
.- -/---/--/---/.-./.-./---/.--/.-.-.-
--./.-/-.../.-./.././.-../.-.-.-

