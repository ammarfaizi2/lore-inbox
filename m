Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318101AbSHIAZx>; Thu, 8 Aug 2002 20:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318105AbSHIAZx>; Thu, 8 Aug 2002 20:25:53 -0400
Received: from pD9E23ABF.dip.t-dialin.net ([217.226.58.191]:16106 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S318101AbSHIAZw>; Thu, 8 Aug 2002 20:25:52 -0400
Date: Thu, 8 Aug 2002 18:29:30 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: kuznet@ms2.inr.ac.ru
cc: Michael Procter <lkml@procter-collective.ORG.UK>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Unix-domain sockets - abstract addresses
In-Reply-To: <200208081836.WAA03110@sex.inr.ac.ru>
Message-ID: <Pine.LNX.4.44.0208081829030.10270-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 8 Aug 2002 kuznet@ms2.inr.ac.ru wrote:
> -	msg->msg_namelen = sizeof(short);
> +	msg->msg_namelen = 0;

This version is for 2.5:

--- linus-2.5/net/unix/af_unix.c	Mon Aug  5 12:02:05 2002
+++ thunder-2.5/net/unix/af_unix.c	Thu Aug  8 18:28:49 2002
@@ -79,6 +79,8 @@
  *		  with BSD names.
  */
 
+#undef unix	/* KBUILD_MODNAME */
+
 #include <linux/module.h>
 #include <linux/config.h>
 #include <linux/kernel.h>
@@ -1400,7 +1402,9 @@
 {
 	struct unix_sock *u = unix_sk(sk);
 
-	msg->msg_namelen = sizeof(short);
+	// msg->msg_namelen = sizeof(short);
+	msg->msg_namelen = 0;
+
 	if (u->addr) {
 		msg->msg_namelen = u->addr->len;
 		memcpy(msg->msg_name, u->addr->name, u->addr->len);

			Thunder
-- 
.-../../-./..-/-..- .-./..-/.-.././.../.-.-.-

