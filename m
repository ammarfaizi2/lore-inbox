Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751152AbVKUWQi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152AbVKUWQi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 17:16:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751157AbVKUWQi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 17:16:38 -0500
Received: from 22.107.233.220.exetel.com.au ([220.233.107.22]:773 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1751152AbVKUWQh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 17:16:37 -0500
From: Herbert Xu <herbert@gondor.apana.org.au>
To: kuznet@ms2.inr.ac.ru (Alexey Kuznetsov)
Subject: [NETLINK]: Use tgid instead of pid for nlmsg_pid
Cc: herbert@gondor.apana.org.au, cfriesen@nortel.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, davem@davemloft.net
Organization: Core
In-Reply-To: <20051121213549.GA28187@ms2.inr.ac.ru>
X-Newsgroups: apana.lists.os.linux.kernel,apana.lists.os.linux.netdev
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1EeJxb-0006xG-00@gondolin.me.apana.org.au>
Date: Tue, 22 Nov 2005 09:16:27 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Kuznetsov <kuznet@ms2.inr.ac.ru> wrote:
> 
> I agree, apparently netlink_autobind was missed when sed'ing pid->tgid.
> Of course, it does not matter, but tgid is nicer choice from user's viewpoint.

Great, here is the patch to do just that.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
--
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -476,7 +476,7 @@ static int netlink_autobind(struct socke
 	struct hlist_head *head;
 	struct sock *osk;
 	struct hlist_node *node;
-	s32 pid = current->pid;
+	s32 pid = current->tgid;
 	int err;
 	static s32 rover = -4097;
 
