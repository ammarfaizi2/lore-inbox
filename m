Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261582AbVFOV0L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261582AbVFOV0L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 17:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261584AbVFOV0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 17:26:11 -0400
Received: from mail.dif.dk ([193.138.115.101]:50903 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261582AbVFOVZk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 17:25:40 -0400
Date: Wed, 15 Jun 2005 23:30:58 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: "David S. Miller" <davem@davemloft.net>
Cc: Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       James Morris <jmorris@redhat.com>, Ross Biro <ross.biro@gmail.com>,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [-mm PATCH][2/4] net: signed vs unsigned cleanup in net/ipv4/raw.c
Message-ID: <Pine.LNX.4.62.0506152239500.3842@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch gets rid of the following gcc -W warning in net/ipv4/raw.c :

net/ipv4/raw.c:387: warning: comparison of unsigned expression < 0 is always false

Since 'len' is of type size_t it is unsigned and can thus never be <0, and 
since this is obvious from the function declaration just a few lines above 
I think it's ok to remove the pointless check for len<0.


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
---

 net/ipv4/raw.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.12-rc6-mm1/net/ipv4/raw.c.with_patch-1	2005-06-15 22:39:17.000000000 +0200
+++ linux-2.6.12-rc6-mm1/net/ipv4/raw.c	2005-06-15 22:39:36.000000000 +0200
@@ -384,7 +384,7 @@ static int raw_sendmsg(struct kiocb *ioc
 	int err;
 
 	err = -EMSGSIZE;
-	if (len < 0 || len > 0xFFFF)
+	if (len > 0xFFFF)
 		goto out;
 
 	/*


