Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261389AbSIZTrw>; Thu, 26 Sep 2002 15:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261400AbSIZTrv>; Thu, 26 Sep 2002 15:47:51 -0400
Received: from dexter.citi.umich.edu ([141.211.133.33]:25473 "EHLO
	dexter.citi.umich.edu") by vger.kernel.org with ESMTP
	id <S261389AbSIZTrp>; Thu, 26 Sep 2002 15:47:45 -0400
Date: Thu, 26 Sep 2002 15:53:04 -0400 (EDT)
From: Chuck Lever <cel@citi.umich.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux NFS List <nfs@lists.sourceforge.net>
Subject: [PATCH]: new static structure definitions for RPC
Message-ID: <Pine.LNX.4.44.0209261551280.28477-100000@dexter.citi.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi Linus-

this patch updates the static structure declarations in sunrpc to use the 
new format.  please let me know if someone else is taking care of this, 
and i will stop sending this patch.  against 2.5.38.


diff -drN -U2 01-iip/net/sunrpc/auth_null.c 02-struct/net/sunrpc/auth_null.c
--- 01-iip/net/sunrpc/auth_null.c	Sun Sep 22 00:25:36 2002
+++ 02-struct/net/sunrpc/auth_null.c	Mon Sep 23 14:02:52 2002
@@ -126,19 +126,19 @@
 
 struct rpc_authops	authnull_ops = {
-	RPC_AUTH_NULL,
+	.au_flavor	= RPC_AUTH_NULL,
 #ifdef RPC_DEBUG
-	"NULL",
+	.au_name	= "NULL",
 #endif
-	nul_create,
-	nul_destroy,
-	nul_create_cred
+	.create		= nul_create,
+	.destroy	= nul_destroy,
+	.crcreate	= nul_create_cred,
 };
 
 static
 struct rpc_credops	null_credops = {
-	nul_destroy_cred,
-	nul_match,
-	nul_marshal,
-	nul_refresh,
-	nul_validate
+	.crdestroy	= nul_destroy_cred,
+	.crmatch	= nul_match,
+	.crmarshal	= nul_marshal,
+	.crrefresh	= nul_refresh,
+	.crvalidate	= nul_validate,
 };
diff -drN -U2 01-iip/net/sunrpc/auth_unix.c 02-struct/net/sunrpc/auth_unix.c
--- 01-iip/net/sunrpc/auth_unix.c	Sun Sep 22 00:24:59 2002
+++ 02-struct/net/sunrpc/auth_unix.c	Mon Sep 23 14:02:52 2002
@@ -240,19 +240,19 @@
 
 struct rpc_authops	authunix_ops = {
-	RPC_AUTH_UNIX,
+	.au_flavor	= RPC_AUTH_UNIX,
 #ifdef RPC_DEBUG
-	"UNIX",
+	.au_name	= "UNIX",
 #endif
-	unx_create,
-	unx_destroy,
-	unx_create_cred
+	.create		= unx_create,
+	.destroy	= unx_destroy,
+	.crcreate	= unx_create_cred,
 };
 
 static
 struct rpc_credops	unix_credops = {
-	unx_destroy_cred,
-	unx_match,
-	unx_marshal,
-	unx_refresh,
-	unx_validate
+	.crdestroy	= unx_destroy_cred,
+	.crmatch	= unx_match,
+	.crmarshal	= unx_marshal,
+	.crrefresh	= unx_refresh,
+	.crvalidate	= unx_validate,
 };
diff -drN -U2 01-iip/net/sunrpc/pmap_clnt.c 02-struct/net/sunrpc/pmap_clnt.c
--- 01-iip/net/sunrpc/pmap_clnt.c	Sun Sep 22 00:25:10 2002
+++ 02-struct/net/sunrpc/pmap_clnt.c	Mon Sep 23 14:02:52 2002
@@ -244,20 +244,34 @@
 
 static struct rpc_procinfo	pmap_procedures[4] = {
-	{ "pmap_null",
-		(kxdrproc_t) xdr_error,	
-		(kxdrproc_t) xdr_error,	0, 0 },
-	{ "pmap_set",
-		(kxdrproc_t) xdr_encode_mapping,	
-		(kxdrproc_t) xdr_decode_bool, 4, 1 },
-	{ "pmap_unset",
-		(kxdrproc_t) xdr_encode_mapping,	
-		(kxdrproc_t) xdr_decode_bool, 4, 1 },
-	{ "pmap_get",
-		(kxdrproc_t) xdr_encode_mapping,
-		(kxdrproc_t) xdr_decode_port, 4, 1 },
+	{ .p_procname		= "pmap_null",
+	  .p_encode		= (kxdrproc_t) xdr_error,	
+	  .p_decode		= (kxdrproc_t) xdr_error,
+	  .p_bufsiz		= 0,
+	  .p_count		= 0,
+	},
+	{ .p_procname		= "pmap_set",
+	  .p_encode		= (kxdrproc_t) xdr_encode_mapping,	
+	  .p_decode		= (kxdrproc_t) xdr_decode_bool,
+	  .p_bufsiz		= 4,
+	  .p_count		= 1,
+	},
+	{ .p_procname		= "pmap_unset",
+	  .p_encode		= (kxdrproc_t) xdr_encode_mapping,	
+	  .p_decode		= (kxdrproc_t) xdr_decode_bool,
+	  .p_bufsiz		= 4,
+	  .p_count		= 1,
+	},
+	{ .p_procname		= "pmap_get",
+	  .p_encode		= (kxdrproc_t) xdr_encode_mapping,
+	  .p_decode		= (kxdrproc_t) xdr_decode_port,
+	  .p_bufsiz		= 4,
+	  .p_count		= 1,
+	},
 };
 
 static struct rpc_version	pmap_version2 = {
-	2, 4, pmap_procedures
+	.number		= 2,
+	.nrprocs	= 4,
+	.procs		= pmap_procedures
 };
 
@@ -265,5 +279,5 @@
 	NULL,
 	NULL,
-	&pmap_version2,
+	&pmap_version2
 };
 
@@ -271,8 +285,8 @@
 
 struct rpc_program	pmap_program = {
-	"portmap",
-	RPC_PMAP_PROGRAM,
-	sizeof(pmap_version)/sizeof(pmap_version[0]),
-	pmap_version,
-	&pmap_stats,
+	.name		= "portmap",
+	.number		= RPC_PMAP_PROGRAM,
+	.nrvers		= sizeof(pmap_version)/sizeof(pmap_version[0]),
+	.version	= pmap_version,
+	.stats		= &pmap_stats,
 };

-- 

corporate:	<cel at netapp dot com>
personal:	<chucklever at bigfoot dot com>

