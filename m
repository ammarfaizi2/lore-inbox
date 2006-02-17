Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932245AbWBQFEX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932245AbWBQFEX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 00:04:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932197AbWBQFEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 00:04:22 -0500
Received: from [203.2.177.25] ([203.2.177.25]:19227 "EHLO pfeiffer.tusc.com.au")
	by vger.kernel.org with ESMTP id S932245AbWBQFET (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 00:04:19 -0500
Subject: [PATCH 4/6]x25:Fix kernel error message 64 bit kernel
From: Shaun Pereira <spereira@tusc.com.au>
Reply-To: spereira@tusc.com.au
To: "David S. Miller" <davem@davemloft.net>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>,
       linux-kenel <linux-kernel@vger.kernel.org>
Cc: Andre Hendry <ahendry@tusc.com.au>
Content-Type: text/plain
Date: Fri, 17 Feb 2006 16:02:13 +1100
Message-Id: <1140152533.1475.25.camel@spereira05.tusc.com.au>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: spereira@tusc.com.au

Fixes the following error from kernel
T2 kernel: schedule_timeout:
wrong timeout value ffffffffffffffff from ffffffff88164796

Signed-off-by:Shaun Pereira <spereira@tusc.com.au>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
diff -uprN -X dontdiff linux-2.6.16-rc3-vanilla/net/x25/af_x25.c linux-2.6.16-rc3/net/x25/af_x25.c
--- linux-2.6.16-rc3-vanilla/net/x25/af_x25.c	2006-02-16 15:28:58.000000000 +1100
+++ linux-2.6.16-rc3/net/x25/af_x25.c	2006-02-16 15:29:04.000000000 +1100
@@ -743,7 +743,7 @@ out:
 	return rc;
 }
 
-static int x25_wait_for_data(struct sock *sk, int timeout)
+static int x25_wait_for_data(struct sock *sk, long timeout)
 {
 	DECLARE_WAITQUEUE(wait, current);
 	int rc = 0;

