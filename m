Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267696AbTASV4i>; Sun, 19 Jan 2003 16:56:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267698AbTASV4i>; Sun, 19 Jan 2003 16:56:38 -0500
Received: from pat.uio.no ([129.240.130.16]:22775 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S267696AbTASV4i>;
	Sun, 19 Jan 2003 16:56:38 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15915.8496.899499.957528@charged.uio.no>
Date: Sun, 19 Jan 2003 23:05:36 +0100
To: Martin Josefsson <gandalf@wlug.westbo.se>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, linux-kernel@vger.kernel.org
Subject: problems with nfs-server in 2.5 bk as of 030115
In-Reply-To: <1043012373.7986.94.camel@tux.rsn.bth.se>
References: <1043012373.7986.94.camel@tux.rsn.bth.se>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Martin Josefsson <gandalf@wlug.westbo.se> writes:

     > This is what I get when trying to start the nfs-server
     > (/etc/init.d/nfs-kernel-server in debian):

     > Installing knfsd (copyright (C) 1996 okir@monad.swb.de).  RPC:
     > Couldn't create pipefs entry /portmap/clntcfac0540 RPC:
     > Couldn't create pipefs entry /portmap/clntcfac0540 RPC:
     > Couldn't create pipefs entry /portmap/clntcfac0540

Could you apply the following patch, so that I can see what the actual
returned error is?

Cheers,
  Trond

--- linux-2.5.59/net/sunrpc/clnt.c	2003-01-12 22:40:13.000000000 +0100
+++ linux-2.5.59-00-fix/net/sunrpc/clnt.c	2003-01-19 23:01:09.000000000 +0100
@@ -113,8 +113,8 @@
 			"/%s/clnt%p", clnt->cl_protname, clnt);
 	clnt->cl_dentry = rpc_mkdir(clnt->cl_pathname, clnt);
 	if (IS_ERR(clnt->cl_dentry)) {
-		printk(KERN_INFO "RPC: Couldn't create pipefs entry %s\n",
-				clnt->cl_pathname);
+		printk(KERN_INFO "RPC: Couldn't create pipefs entry %s, error %ld\n",
+				clnt->cl_pathname, PTR_ERR(clnt->cl_dentry));
 		goto out_no_path;
 	}
 	if (!rpcauth_create(flavor, clnt)) {
