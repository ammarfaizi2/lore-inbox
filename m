Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261299AbVCQTcl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261299AbVCQTcl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 14:32:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261321AbVCQTcl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 14:32:41 -0500
Received: from mail.dif.dk ([193.138.115.101]:25570 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261299AbVCQTch (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 14:32:37 -0500
Date: Thu, 17 Mar 2005 20:34:05 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: netdev@oss.sgi.com
Cc: Orest Zborowski <obz@Kodak.COM>, Ross Biro <bir7@leland.Stanford.Edu>,
       "Fred N. van Kempen" <waltje@uWalt.NL.Mugnet.ORG>,
       "David S. Miller" <davem@davemloft.net>, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] net/socket.c : remove redundant NULL pointer check before
 kfree()
Message-ID: <Pine.LNX.4.62.0503172028030.2512@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


kfree() handles NULL pointers just fine, checking first is pointless.


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.11-mm4-orig/net/socket.c	2005-03-16 15:45:42.000000000 +0100
+++ linux-2.6.11-mm4/net/socket.c	2005-03-17 20:25:36.000000000 +0100
@@ -993,8 +993,7 @@ static int sock_fasync(int fd, struct fi
 	sock = SOCKET_I(filp->f_dentry->d_inode);
 
 	if ((sk=sock->sk) == NULL) {
-		if (fna)
-			kfree(fna);
+		kfree(fna);
 		return -EINVAL;
 	}
 




(Please CC me on replies to lists other than linux-kernel)


