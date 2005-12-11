Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750821AbVLKTdt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750821AbVLKTdt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 14:33:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750823AbVLKTds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 14:33:48 -0500
Received: from uproxy.gmail.com ([66.249.92.206]:2639 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750821AbVLKTdr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 14:33:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=VWx0f6pMntac37kQ0yvqhuEgC+5QprJovRsp3P1iKbPfxNC6ngVYUHNgCIknf41wXcy4vZZkDHHIBV6Cna5ujXMnTXljuS6AgWVBKzCbSR05PSUK9GejUqaIViDemchhNGlNWTrw7zRVLxF+zDWUfEIc75OyHdd7t7G/EM8SHek=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/6] net: Remove unneeded kmalloc() return value casts
Date: Sun, 11 Dec 2005 20:34:20 +0100
User-Agent: KMail/1.9
Cc: Maxim Krasnyansky <maxk@qualcomm.com>, Olaf Kirch <okir@monad.swb.de>,
       netdev@vger.kernel.org, davem@davemloft.net, yoshfuji@linux-ipv6.org,
       Andrew Morton <akpm@osdl.org>, Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200512112034.20644.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Get rid of needless casting of kmalloc() return value in net/


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 net/bluetooth/hci_conn.c |    2 +-
 net/sunrpc/svc.c         |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

--- linux-2.6.15-rc5-git1-orig/net/bluetooth/hci_conn.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6.15-rc5-git1/net/bluetooth/hci_conn.c	2005-12-11 19:50:32.000000000 +0100
@@ -403,7 +403,7 @@ int hci_get_conn_list(void __user *arg)
 
 	size = sizeof(req) + req.conn_num * sizeof(*ci);
 
-	if (!(cl = (void *) kmalloc(size, GFP_KERNEL)))
+	if (!(cl = kmalloc(size, GFP_KERNEL)))
 		return -ENOMEM;
 
 	if (!(hdev = hci_dev_get(req.dev_id))) {
--- linux-2.6.15-rc5-git1-orig/net/sunrpc/svc.c	2005-12-04 18:49:00.000000000 +0100
+++ linux-2.6.15-rc5-git1/net/sunrpc/svc.c	2005-12-11 19:54:05.000000000 +0100
@@ -167,8 +167,8 @@ svc_create_thread(svc_thread_fn func, st
 	memset(rqstp, 0, sizeof(*rqstp));
 	init_waitqueue_head(&rqstp->rq_wait);
 
-	if (!(rqstp->rq_argp = (u32 *) kmalloc(serv->sv_xdrsize, GFP_KERNEL))
-	 || !(rqstp->rq_resp = (u32 *) kmalloc(serv->sv_xdrsize, GFP_KERNEL))
+	if (!(rqstp->rq_argp = kmalloc(serv->sv_xdrsize, GFP_KERNEL))
+	 || !(rqstp->rq_resp = kmalloc(serv->sv_xdrsize, GFP_KERNEL))
 	 || !svc_init_buffer(rqstp, serv->sv_bufsz))
 		goto out_thread;
 



