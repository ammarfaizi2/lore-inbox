Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262187AbVCPAdD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262187AbVCPAdD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 19:33:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262193AbVCPAdD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 19:33:03 -0500
Received: from mail.kroah.org ([69.55.234.183]:10939 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262187AbVCPAcr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 19:32:47 -0500
Date: Tue, 15 Mar 2005 16:23:25 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: chrisw@osdl.org, torvalds@osdl.org, akpm@osdl.org
Subject: Re: Linux 2.6.11.4
Message-ID: <20050316002325.GA30645@kroah.com>
References: <20050316002222.GA30602@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050316002222.GA30602@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -Nru a/Makefile b/Makefile
--- a/Makefile	2005-03-15 16:09:59 -08:00
+++ b/Makefile	2005-03-15 16:09:59 -08:00
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 11
-EXTRAVERSION = .3
+EXTRAVERSION = .4
 NAME=Woozy Numbat
 
 # *DOCUMENTATION*
diff -Nru a/drivers/net/ppp_async.c b/drivers/net/ppp_async.c
--- a/drivers/net/ppp_async.c	2005-03-15 16:09:59 -08:00
+++ b/drivers/net/ppp_async.c	2005-03-15 16:09:59 -08:00
@@ -1000,7 +1000,7 @@
 	data += 4;
 	dlen -= 4;
 	/* data[0] is code, data[1] is length */
-	while (dlen >= 2 && dlen >= data[1]) {
+	while (dlen >= 2 && dlen >= data[1] && data[1] >= 2) {
 		switch (data[0]) {
 		case LCP_MRU:
 			val = (data[2] << 8) + data[3];
diff -Nru a/fs/exec.c b/fs/exec.c
--- a/fs/exec.c	2005-03-15 16:09:59 -08:00
+++ b/fs/exec.c	2005-03-15 16:09:59 -08:00
@@ -814,7 +814,7 @@
 {
 	/* buf must be at least sizeof(tsk->comm) in size */
 	task_lock(tsk);
-	memcpy(buf, tsk->comm, sizeof(tsk->comm));
+	strncpy(buf, tsk->comm, sizeof(tsk->comm));
 	task_unlock(tsk);
 }
 
