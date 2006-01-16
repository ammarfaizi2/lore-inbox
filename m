Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751190AbWAPUFx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190AbWAPUFx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 15:05:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751204AbWAPUFx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 15:05:53 -0500
Received: from mx1.redhat.com ([66.187.233.31]:42398 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751190AbWAPUFv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 15:05:51 -0500
Date: Mon, 16 Jan 2006 15:04:32 -0500
From: Andy Gospodarek <andy@greyhouse.net>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net
Subject: [patch] networking ipv4: remove total socket usage count from /proc/net/sockstat
Message-ID: <20060116200432.GB14060@gospo.rdu.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Printing the total number of sockets used in /proc/net/sockstat is out
of place in a file that is supposed to contain information related to
ipv4 sockets.  Removed output for total socket usage.

Signed-off-by: Andy Gospodarek <andy@greyhouse.net>
---

 proc.c |    1 -
 1 files changed, 1 deletion(-)


diff --git a/net/ipv4/proc.c b/net/ipv4/proc.c
--- a/net/ipv4/proc.c
+++ b/net/ipv4/proc.c
@@ -60,7 +60,6 @@ static int fold_prot_inuse(struct proto 
  */
 static int sockstat_seq_show(struct seq_file *seq, void *v)
 {
-	socket_seq_show(seq);
 	seq_printf(seq, "TCP: inuse %d orphan %d tw %d alloc %d mem %d\n",
 		   fold_prot_inuse(&tcp_prot), atomic_read(&tcp_orphan_count),
 		   tcp_death_row.tw_count, atomic_read(&tcp_sockets_allocated),
