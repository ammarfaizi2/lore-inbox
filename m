Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267741AbTBMCwg>; Wed, 12 Feb 2003 21:52:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267740AbTBMCwg>; Wed, 12 Feb 2003 21:52:36 -0500
Received: from covert.black-ring.iadfw.net ([209.196.123.142]:10502 "EHLO
	covert.brown-ring.iadfw.net") by vger.kernel.org with ESMTP
	id <S267731AbTBMCwd>; Wed, 12 Feb 2003 21:52:33 -0500
Date: Wed, 12 Feb 2003 20:10:22 -0600
From: Art Haas <ahaas@airmail.net>
To: linux-net@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] C99 initializers for net/sunrpc/sysctl.c
Message-ID: <20030213021022.GC23898@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

This patch converts the file to use C99 initializers to improve
readability and remove warnings if '-W' is used.

Art Haas

===== net/sunrpc/sysctl.c 1.2 vs edited =====
--- 1.2/net/sunrpc/sysctl.c	Tue Feb  5 01:39:25 2002
+++ edited/net/sunrpc/sysctl.c	Wed Feb 12 18:50:37 2003
@@ -116,23 +116,51 @@
 	return 0;
 }
 
-#define DIRENTRY(nam1, nam2, child)	\
-	{CTL_##nam1, #nam2, NULL, 0, 0555, child }
-#define DBGENTRY(nam1, nam2)	\
-	{CTL_##nam1##DEBUG, #nam2 "_debug", &nam2##_debug, sizeof(int),\
-	 0644, NULL, &proc_dodebug}
-
-static ctl_table		debug_table[] = {
-	DBGENTRY(RPC,  rpc),
-	DBGENTRY(NFS,  nfs),
-	DBGENTRY(NFSD, nfsd),
-	DBGENTRY(NLM,  nlm),
-	{0}
+static ctl_table debug_table[] = {
+	{
+		.ctl_name	= CTL_RPCDEBUG,
+		.procname	= "rpc_debug",
+		.data		= &rpc_debug,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dodebug
+	}, 
+	{
+		.ctl_name	= CTL_NFSDEBUG,
+		.procname	= "nfs_debug",
+		.data		= &nfs_debug,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dodebug
+	}, 
+	{
+		.ctl_name	= CTL_NFSDDEBUG,
+		.procname	= "nfsd_debug",
+		.data		= &nfsd_debug,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dodebug
+	}, 
+	{
+		.ctl_name	= CTL_NLMDEBUG,
+		.procname	= "nlm_debug",
+		.data		= &nlm_debug,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dodebug
+	}, 
+	{ .ctl_name = 0 }
 };
 
-static ctl_table		sunrpc_table[] = {
-	DIRENTRY(SUNRPC, sunrpc, debug_table),
-	{0}
+static ctl_table sunrpc_table[] = {
+	{
+		.ctl_name	= CTL_SUNRPC,
+		.procname	= "sunrpc",
+		.maxlen		= 0,
+		.mode		= 0555,
+		.child		= debug_table
+	},
+	{ .ctl_name = 0 }
 };
 
 #endif
-- 
They that can give up essential liberty to obtain a little temporary safety
deserve neither liberty nor safety.
 -- Benjamin Franklin, Historical Review of Pennsylvania, 1759
