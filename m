Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261673AbUKXCE5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261673AbUKXCE5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 21:04:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261687AbUKXCE4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 21:04:56 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:54027 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261673AbUKXCEB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 21:04:01 -0500
Date: Wed, 24 Nov 2004 03:03:54 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, neilb@cse.unsw.edu.au,
       nfs@lists.sourceforge.net, trond.myklebust@fys.uio.no,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] lockd: fix two struct definitions (fwd)
Message-ID: <20041124020354.GK2927@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The patch forwarded below dtill applies and compiles against 
2.6.10-rc2-mm3.

Please apply.


----- Forwarded message from Adrian Bunk <bunk@stusta.de> -----

Date:	Wed, 3 Nov 2004 22:47:32 +0100
From: Adrian Bunk <bunk@stusta.de>
To: neilb@cse.unsw.edu.au, nfs@lists.sourceforge.net,
	trond.myklebust@fys.uio.no, linux-kernel@vger.kernel.org
Subject: [2.6 patch] lockd: fix two struct definitions

Under fs/lockd/, there are two structs declared extern although they are 
in the same file. Furtheremore, they don't have to be global since their 
only users are in the same file.

Most of the changes to svc.c are only indent fixes caused by making the 
struct static.


diffstat output:
 fs/lockd/mon.c |    4 ++--
 fs/lockd/svc.c |   16 ++++++++--------
 2 files changed, 10 insertions(+), 10 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm2-full/fs/lockd/mon.c.old	2004-11-03 22:29:13.000000000 +0100
+++ linux-2.6.10-rc1-mm2-full/fs/lockd/mon.c	2004-11-03 22:29:44.000000000 +0100
@@ -19,7 +19,7 @@
 
 static struct rpc_clnt *	nsm_create(void);
 
-extern struct rpc_program	nsm_program;
+static struct rpc_program	nsm_program;
 
 /*
  * Local NSM state
@@ -237,7 +237,7 @@
 
 static struct rpc_stat		nsm_stats;
 
-struct rpc_program		nsm_program = {
+static struct rpc_program	nsm_program = {
 		.name		= "statd",
 		.number		= SM_PROGRAM,
 		.nrvers		= sizeof(nsm_version)/sizeof(nsm_version[0]),
--- linux-2.6.10-rc1-mm2-full/fs/lockd/svc.c.old	2004-11-03 22:26:30.000000000 +0100
+++ linux-2.6.10-rc1-mm2-full/fs/lockd/svc.c	2004-11-03 22:30:05.000000000 +0100
@@ -38,7 +38,7 @@
 #define LOCKD_BUFSIZE		(1024 + NLMSVC_XDRSIZE)
 #define ALLOWED_SIGS		(sigmask(SIGKILL))
 
-extern struct svc_program	nlmsvc_program;
+static struct svc_program	nlmsvc_program;
 
 struct nlmsvc_binding *		nlmsvc_ops;
 EXPORT_SYMBOL(nlmsvc_ops);
@@ -476,11 +476,11 @@
 static struct svc_stat		nlmsvc_stats;
 
 #define NLM_NRVERS	(sizeof(nlmsvc_version)/sizeof(nlmsvc_version[0]))
-struct svc_program	nlmsvc_program = {
-	.pg_prog	= NLM_PROGRAM,		/* program number */
-	.pg_nvers	= NLM_NRVERS,		/* number of entries in nlmsvc_version */
-	.pg_vers	= nlmsvc_version,	/* version table */
-	.pg_name	= "lockd",		/* service name */
-	.pg_class	= "nfsd",		/* share authentication with nfsd */
-	.pg_stats	= &nlmsvc_stats,	/* stats table */
+static struct svc_program	nlmsvc_program = {
+	.pg_prog		= NLM_PROGRAM,		/* program number */
+	.pg_nvers		= NLM_NRVERS,		/* number of entries in nlmsvc_version */
+	.pg_vers		= nlmsvc_version,	/* version table */
+	.pg_name		= "lockd",		/* service name */
+	.pg_class		= "nfsd",		/* share authentication with nfsd */
+	.pg_stats		= &nlmsvc_stats,	/* stats table */
 };

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

