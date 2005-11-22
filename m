Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964912AbVKVKvd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964912AbVKVKvd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 05:51:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964911AbVKVKvd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 05:51:33 -0500
Received: from c3po.0xdef.net ([217.172.181.57]:145 "EHLO c3po.0xdef.net")
	by vger.kernel.org with ESMTP id S964909AbVKVKvc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 05:51:32 -0500
Date: Tue, 22 Nov 2005 11:51:31 +0100
From: Hagen Paul Pfeifer <hpplinuxml@0xdef.net>
To: linux-kernel@vger.kernel.org
Cc: acme@mandriva.com, dccp@vger.kernel.org
Subject: [PATCH] dccp sizeof correction
Message-ID: <20051122105130.GA25078@0xdef.net>
Mail-Followup-To: Hagen Paul Pfeifer <hpplinuxml@0xdef.net>,
	linux-kernel@vger.kernel.org, acme@mandriva.com,
	dccp@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
X-Key-Id: 98350C22
X-Key-Fingerprint: 490F 557B 6C48 6D7E 5706 2EA2 4A22 8D45 9835 0C22
X-GPG-Key: gpg --recv-keys --keyserver wwwkeys.eu.pgp.net 98350C22
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Setsockopt in DCCP make the assumption that sizeof(int) is the same as
sizeof(u32), that isn't correct at all. ;)

best regards

HGN


Signed-off-by: Hagen Paul Pfeifer <hpplinuxml@0xdef.net>

 net/dccp/proto.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

applies-to: 69ebfee77c8a174c87ea8ed31e023c94b09a9d6e
d24574ecf034d259882a6de16d27aff60c009c8d
diff --git a/net/dccp/proto.c b/net/dccp/proto.c
index a021c34..a1be808 100644
--- a/net/dccp/proto.c
+++ b/net/dccp/proto.c
@@ -256,7 +256,7 @@ int dccp_setsockopt(struct sock *sk, int
 	if (level != SOL_DCCP)
 		return ip_setsockopt(sk, level, optname, optval, optlen);
 
-	if (optlen < sizeof(int))
+	if (optlen < sizeof(u32))
 		return -EINVAL;
 
 	if (get_user(val, (int __user *)optval))
---
0.99.9g
