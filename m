Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261368AbVCCBP3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261368AbVCCBP3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 20:15:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261389AbVCCBP1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 20:15:27 -0500
Received: from MAIL.13thfloor.at ([212.16.62.51]:9418 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S261368AbVCCBON (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 20:14:13 -0500
Date: Thu, 3 Mar 2005 02:14:13 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: eis@baty.hanse.de, linux-x25@vger.kernel.org
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: x25_create initializing socket data twice ...
Message-ID: <20050303011413.GB11516@mail.13thfloor.at>
Mail-Followup-To: eis@baty.hanse.de, linux-x25@vger.kernel.org,
	Linux Kernel ML <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Folks!

x25_create() [net/x25/af_x25.c] is calling sock_init_data()
twice ... once indirectly via x25_alloc_socket() and a
second time directly via sock_init_data(sock, sk);

while this might not look as critical as it seems, it can
easily break stuff which assumes that sock_init_data()
isn't called twice on the same socket ...

maybe something like this might be appropriate?

--- ./net/x25/af_x25.c.orig	2005-03-02 12:39:11 +0100
+++ ./net/x25/af_x25.c	2005-03-03 02:12:11 +0100
@@ -490,7 +490,6 @@ static int x25_create(struct socket *soc
 
 	x25 = x25_sk(sk);
 
-	sock_init_data(sock, sk);
 	sk_set_owner(sk, THIS_MODULE);
 
 	x25_init_timers(sk);


best,
Herbert

