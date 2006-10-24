Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965179AbWJXVKb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965179AbWJXVKb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 17:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965182AbWJXVKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 17:10:31 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:30698 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965179AbWJXVKb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 17:10:31 -0400
Date: Tue, 24 Oct 2006 22:10:27 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org
Subject: [PATCH] fix RARP ic_servaddr breakage
Message-ID: <20061024211027.GG29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

memcpy 4 bytes to address of auto unsigned long variable followed
by comparison with u32 is a bloody bad idea.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 net/ipv4/ipconfig.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/ipv4/ipconfig.c b/net/ipv4/ipconfig.c
index f8ce847..955a07a 100644
--- a/net/ipv4/ipconfig.c
+++ b/net/ipv4/ipconfig.c
@@ -420,7 +420,7 @@ ic_rarp_recv(struct sk_buff *skb, struct
 {
 	struct arphdr *rarp;
 	unsigned char *rarp_ptr;
-	unsigned long sip, tip;
+	u32 sip, tip;
 	unsigned char *sha, *tha;		/* s for "source", t for "target" */
 	struct ic_device *d;
 
-- 
1.4.2.GIT

