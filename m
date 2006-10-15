Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161177AbWJOVaK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161177AbWJOVaK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 17:30:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161180AbWJOVaK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 17:30:10 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:23003 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1161179AbWJOVaJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 17:30:09 -0400
Date: Sun, 15 Oct 2006 22:30:03 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] endianness bug: missing cpu_to_le16() in l2cap
Message-ID: <20061015213003.GS29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

__l2cap_get_sock_by_addr() expects its first argument in
little-endian.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 net/bluetooth/l2cap.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 0995420..07d13a8 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -741,7 +741,7 @@ static int l2cap_sock_listen(struct sock
 		write_lock_bh(&l2cap_sk_list.lock);
 
 		for (psm = 0x1001; psm < 0x1100; psm += 2)
-			if (!__l2cap_get_sock_by_addr(psm, src)) {
+			if (!__l2cap_get_sock_by_addr(htobs(psm), src)) {
 				l2cap_pi(sk)->psm   = htobs(psm);
 				l2cap_pi(sk)->sport = htobs(psm);
 				err = 0;
-- 
1.4.2.GIT

