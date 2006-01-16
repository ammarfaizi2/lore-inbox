Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751260AbWAPXOF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260AbWAPXOF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 18:14:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751052AbWAPXOF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 18:14:05 -0500
Received: from [203.2.177.25] ([203.2.177.25]:59181 "EHLO pfeiffer.tusc.com.au")
	by vger.kernel.org with ESMTP id S1751260AbWAPXOD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 18:14:03 -0500
Subject: [PATCH 4/4]x25: 32 bit (socket layer) ioctl emulation for 64 bit
	kernels
From: Shaun Pereira <spereira@tusc.com.au>
Reply-To: spereira@tusc.com.au
To: Arnd Bergmann <arnd@arndb.de>
Cc: YOSHIFUJI Hideaki / =?UTF-8?Q?=E5=90=89=E8=97=A4=E8=8B=B1?=
	 =?UTF-8?Q?=E6=98=8E?= <yoshfuji@linux-ipv6.org>,
       acme@ghostprotocols.net, ak@muc.de, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, pereira.shaun@gmail.com
In-Reply-To: <200601161043.31742.arnd@arndb.de>
References: <1137122079.5589.34.camel@spereira05.tusc.com.au>
	 <1137391160.5588.32.camel@spereira05.tusc.com.au>
	 <20060116.154106.64415709.yoshfuji@linux-ipv6.org>
	 <200601161043.31742.arnd@arndb.de>
Content-Type: text/plain
Date: Tue, 17 Jan 2006 10:12:22 +1100
Message-Id: <1137453142.6553.20.camel@spereira05.tusc.com.au>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A small fix for the following error, when trying to run a 64 bit x25
server application.

T2 kernel: schedule_timeout: 
 wrong timeout value ffffffffffffffff from ffffffff88164796

diff -uprN -X dontdiff linux-2.6.15-vanilla/net/x25/af_x25.c
linux-2.6.15/net/x25/af_x25.c
--- linux-2.6.15-vanilla/net/x25/af_x25.c	2006-01-17 09:57:38.000000000
+1100
+++ linux-2.6.15/net/x25/af_x25.c	2006-01-17 09:58:04.000000000 +1100
@@ -747,7 +747,7 @@ out:
 	return rc;
 }
 
-static int x25_wait_for_data(struct sock *sk, int timeout)
+static int x25_wait_for_data(struct sock *sk, long timeout)
 {
 	DECLARE_WAITQUEUE(wait, current);
 	int rc = 0;

