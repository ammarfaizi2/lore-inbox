Return-Path: <linux-kernel-owner+w=401wt.eu-S965005AbXAHWcY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965005AbXAHWcY (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 17:32:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964982AbXAHWcY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 17:32:24 -0500
Received: from ricci.tusc.com.au ([203.2.177.24]:18848 "EHLO ricci.tusc.com.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964956AbXAHWcX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 17:32:23 -0500
Subject: [PATCH] X.25 Add missing sock_put in x25_receive_data
From: ahendry <ahendry@tusc.com.au>
To: linux-x25@vger.kernel.org, eis@baty.hanse.de
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 09 Jan 2007 09:32:17 +1100
Message-Id: <1168295537.5460.30.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


__x25_find_socket does a sock_hold.
This adds a missing sock_put in x25_receive_data.

Signed-off-by: Andrew Hendry <andrew.hendry@gmail.com>

--- linux-2.6.19-vanilla/net/x25/x25_dev.c	2006-12-31 22:31:07.000000000 +1100
+++ linux-2.6.19/net/x25/x25_dev.c	2007-01-06 16:40:54.000000000 +1100
@@ -56,6 +56,7 @@ static int x25_receive_data(struct sk_bu
 			sk_add_backlog(sk, skb);
 		}
 		bh_unlock_sock(sk);
+		sock_put(sk);
 		return queued;
 	}

