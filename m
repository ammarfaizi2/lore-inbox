Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267744AbTATBww>; Sun, 19 Jan 2003 20:52:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267748AbTATBww>; Sun, 19 Jan 2003 20:52:52 -0500
Received: from pat.uio.no ([129.240.130.16]:62089 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S267744AbTATBwv>;
	Sun, 19 Jan 2003 20:52:51 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15915.22671.867328.281811@charged.uio.no>
Date: Mon, 20 Jan 2003 03:01:51 +0100
To: Martin Josefsson <gandalf@wlug.westbo.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: problems with nfs-server in 2.5 bk as of 030115
In-Reply-To: <1043027422.668.4.camel@tux.rsn.bth.se>
References: <1043012373.7986.94.camel@tux.rsn.bth.se>
	<15915.21051.365166.964932@charged.uio.no>
	<1043027422.668.4.camel@tux.rsn.bth.se>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Martin Josefsson <gandalf@wlug.westbo.se> writes:

     > # ls portmap/clnteb2bbc7c -l
     > ls: portmap/clnteb2bbc7c/info: No such file or directory total
     > 0

OK. Try this...

Cheers,
  Trond

--- linux-2.5.59-00-fix/net/sunrpc/rpc_pipe.c.orig	2003-01-14 16:29:23.000000000 +0100
+++ linux-2.5.59-00-fix/net/sunrpc/rpc_pipe.c	2003-01-20 02:58:08.000000000 +0100
@@ -569,6 +569,7 @@
 {
 	int error;
 
+	shrink_dcache_parent(dentry);
 	rpc_inode_setowner(dentry->d_inode, NULL);
 	if ((error = simple_rmdir(dir, dentry)) != 0)
 		return error;
