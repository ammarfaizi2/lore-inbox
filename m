Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263794AbTANPYP>; Tue, 14 Jan 2003 10:24:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263977AbTANPYP>; Tue, 14 Jan 2003 10:24:15 -0500
Received: from mons.uio.no ([129.240.130.14]:53418 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S263794AbTANPYO>;
	Tue, 14 Jan 2003 10:24:14 -0500
To: Andrew Walrond <andrew@walrond.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.bk no longer boots from NFS root after bk pull this morning
References: <3E23E087.9020302@walrond.org>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 14 Jan 2003 16:32:47 +0100
In-Reply-To: <3E23E087.9020302@walrond.org>
Message-ID: <shsof6j21cw.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Andrew Walrond <andrew@walrond.org> writes:

     > 100005/1 on 10.0.0.1 net/sunrpc/rpc_pipe.c: rpc_lookup_path
     > failed to find path /mount/clntc398a880

Could you apply the RPC fix that I just posted to l-k, and then this
fix on top of it?

Cheers,
 Trond

diff -u --recursive --new-file linux-2.5.58-00-fix_warn/net/sunrpc/rpc_pipe.c linux-2.5.58-01-fix_nfsroot/net/sunrpc/rpc_pipe.c
--- linux-2.5.58-00-fix_warn/net/sunrpc/rpc_pipe.c	2003-01-14 16:05:21.000000000 +0100
+++ linux-2.5.58-01-fix_nfsroot/net/sunrpc/rpc_pipe.c	2003-01-14 16:29:23.000000000 +0100
@@ -324,6 +324,7 @@
 enum {
 	RPCAUTH_Root = 1,
 	RPCAUTH_lockd,
+	RPCAUTH_mount,
 	RPCAUTH_nfs,
 	RPCAUTH_portmap,
 	RPCAUTH_statd,
@@ -344,6 +345,10 @@
 		.name = "lockd",
 		.mode = S_IFDIR | S_IRUGO | S_IXUGO,
 	},
+	[RPCAUTH_mount] = {
+		.name = "mount",
+		.mode = S_IFDIR | S_IRUGO | S_IXUGO,
+	},
 	[RPCAUTH_nfs] = {
 		.name = "nfs",
 		.mode = S_IFDIR | S_IRUGO | S_IXUGO,

