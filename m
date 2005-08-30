Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750834AbVH3I2Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750834AbVH3I2Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 04:28:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751231AbVH3I2Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 04:28:16 -0400
Received: from duempel.org ([81.209.165.42]:50567 "HELO duempel.org")
	by vger.kernel.org with SMTP id S1750834AbVH3I2P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 04:28:15 -0400
Date: Tue, 30 Aug 2005 10:27:18 +0200
From: Max Kellermann <max@duempel.org>
To: linux-kernel@vger.kernel.org
Cc: bk@cm4all.com
Subject: [PATCH] print unsigned integers in sunrpc stats
Message-ID: <20050830082718.GA25148@roonstrasse.net>
Mail-Followup-To: linux-kernel@vger.kernel.org, bk@cm4all.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

the sunrpc stats are collected in unsigned integers, but they are
printed with '%d'.  That can result in negative numbers in
/proc/net/rpc when the highest bit of a counter is set.  The following
patch changes '%d' to '%u' where appropriate.

Max


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sunrpc-unsigned-stats.patch"

--- linux-2.6.13/net/sunrpc/stats.c.orig	2005-08-30 10:22:35.000000000 +0200
+++ linux-2.6.13/net/sunrpc/stats.c	2005-08-30 10:28:51.000000000 +0200
@@ -35,13 +35,13 @@
 	int		i, j;
 
 	seq_printf(seq,
-		"net %d %d %d %d\n",
+		"net %u %u %u %u\n",
 			statp->netcnt,
 			statp->netudpcnt,
 			statp->nettcpcnt,
 			statp->nettcpconn);
 	seq_printf(seq,
-		"rpc %d %d %d\n",
+		"rpc %u %u %u\n",
 			statp->rpccnt,
 			statp->rpcretrans,
 			statp->rpcauthrefresh);
@@ -50,10 +50,10 @@
 		const struct rpc_version *vers = prog->version[i];
 		if (!vers)
 			continue;
-		seq_printf(seq, "proc%d %d",
+		seq_printf(seq, "proc%u %u",
 					vers->number, vers->nrprocs);
 		for (j = 0; j < vers->nrprocs; j++)
-			seq_printf(seq, " %d",
+			seq_printf(seq, " %u",
 					vers->procs[j].p_count);
 		seq_putc(seq, '\n');
 	}
@@ -83,13 +83,13 @@
 	int		i, j;
 
 	seq_printf(seq,
-		"net %d %d %d %d\n",
+		"net %u %u %u %u\n",
 			statp->netcnt,
 			statp->netudpcnt,
 			statp->nettcpcnt,
 			statp->nettcpconn);
 	seq_printf(seq,
-		"rpc %d %d %d %d %d\n",
+		"rpc %u %u %u %u %u\n",
 			statp->rpccnt,
 			statp->rpcbadfmt+statp->rpcbadauth+statp->rpcbadclnt,
 			statp->rpcbadfmt,
@@ -99,9 +99,9 @@
 	for (i = 0; i < prog->pg_nvers; i++) {
 		if (!(vers = prog->pg_vers[i]) || !(proc = vers->vs_proc))
 			continue;
-		seq_printf(seq, "proc%d %d", i, vers->vs_nproc);
+		seq_printf(seq, "proc%d %u", i, vers->vs_nproc);
 		for (j = 0; j < vers->vs_nproc; j++, proc++)
-			seq_printf(seq, " %d", proc->pc_count);
+			seq_printf(seq, " %u", proc->pc_count);
 		seq_putc(seq, '\n');
 	}
 }

--RnlQjJ0d97Da+TV1--
