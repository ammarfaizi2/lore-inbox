Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268608AbTBYWEe>; Tue, 25 Feb 2003 17:04:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268609AbTBYWEe>; Tue, 25 Feb 2003 17:04:34 -0500
Received: from packet.digeo.com ([12.110.80.53]:9652 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S268608AbTBYWEd>;
	Tue, 25 Feb 2003 17:04:33 -0500
Date: Tue, 25 Feb 2003 14:11:34 -0800
From: Andrew Morton <akpm@digeo.com>
To: Emmett Pate <emmett@epate.com>
Cc: linux-kernel@vger.kernel.org, Bertrand <bert@ovh.net>
Subject: Re: rootfs on nfs : oops 2.5.63
Message-Id: <20030225141134.3778b199.akpm@digeo.com>
In-Reply-To: <200302251622.55217.emmett@epate.com>
References: <20030225151337.358a6ee6.bert@ovh.net>
	<200302251622.55217.emmett@epate.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Feb 2003 22:14:42.0554 (UTC) FILETIME=[4BCF7DA0:01C2DD1B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Emmett Pate <emmett@epate.com> wrote:
>
> I'm having the same problem.
> 
> On my notebook (wireless PCMCIA, D-Link DWL650), 2.5.63 oopses immediately on 
> trying to mount an NFS filesystem.

Trond quietly sent out the below patch a while back.  Could you please see if
this fixes things up?


--- 25/net/sunrpc/clnt.c~rpc_rmdir-fix	Mon Feb 24 15:47:53 2003
+++ 25-akpm/net/sunrpc/clnt.c	Mon Feb 24 15:47:53 2003
@@ -208,7 +208,8 @@ rpc_destroy_client(struct rpc_clnt *clnt
 		rpcauth_destroy(clnt->cl_auth);
 		clnt->cl_auth = NULL;
 	}
-	rpc_rmdir(clnt->cl_pathname);
+	if (clnt->cl_pathname[0])
+		rpc_rmdir(clnt->cl_pathname);
 	if (clnt->cl_xprt) {
 		xprt_destroy(clnt->cl_xprt);
 		clnt->cl_xprt = NULL;

_

