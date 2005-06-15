Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261588AbVFOVaW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261588AbVFOVaW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 17:30:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261585AbVFOV3e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 17:29:34 -0400
Received: from mail.dif.dk ([193.138.115.101]:60631 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261584AbVFOV0Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 17:26:25 -0400
Date: Wed, 15 Jun 2005 23:31:44 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: "David S. Miller" <davem@davemloft.net>
Cc: Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       James Morris <jmorris@redhat.com>, Ross Biro <ross.biro@gmail.com>,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [-mm PATCH][3/4] net: signed vs unsigned cleanup in net/ipv4/raw.c
Message-ID: <Pine.LNX.4.62.0506152308480.3842@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes the type of the local variable 'i' in 
raw_probe_proto_opt() from 'int' to 'unsigned int'. The only use of 'i' in 
this function is as a counter in a for() loop and subsequent index into 
the msg->msg_iov[] array.
Since 'i' is compared in a loop to the unsigned variable msg->msg_iovlen 
gcc -W generates this warning : 

net/ipv4/raw.c:340: warning: comparison between signed and unsigned

Changing 'i' to unsigned silences this warning and is safe since the array 
index can never be negative anyway, so unsigned int is the logical type to 
use for 'i' and also enables a larger msg_iov[] array (but I don't know if 
that will ever matter).


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
---

 net/ipv4/raw.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.12-rc6-mm1/net/ipv4/raw.c.with_patch-2	2005-06-15 23:04:40.000000000 +0200
+++ linux-2.6.12-rc6-mm1/net/ipv4/raw.c	2005-06-15 23:09:42.000000000 +0200
@@ -332,7 +332,7 @@ static void raw_probe_proto_opt(struct f
 	u8 __user *type = NULL;
 	u8 __user *code = NULL;
 	int probed = 0;
-	int i;
+	unsigned int i;
 
 	if (!msg->msg_iov)
 		return;



