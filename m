Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964857AbWAWU7P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964857AbWAWU7P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 15:59:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964873AbWAWU7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 15:59:15 -0500
Received: from silver.veritas.com ([143.127.12.111]:26001 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S964857AbWAWU7O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 15:59:14 -0500
Date: Mon, 23 Jan 2006 20:59:53 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Christoph Lameter <clameter@sgi.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: VM_ZONE_RECLAIM_MODE warning in kernel/sysctl.c
Message-ID: <Pine.LNX.4.61.0601232035450.6596@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 23 Jan 2006 20:59:14.0299 (UTC) FILETIME=[DDDEDCB0:01C6205F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

I'm puzzled why I who only pretend to have NUMA get this compiler warning
kernel/sysctl.c:881: warning: initialization from incompatible pointer type
but people who really have NUMA don't.  Specifying the address of an int
instead of a function looks unhealthy to me: could you please test this
plausible but possibly nonsense patch below, correct it where necessary,
and send it in?  Thanks.


Heed NUMA VM_ZONE_RECLAIM_MODE compiler warning in kernel/sysctl.c.

Signed-off-by: Hugh Dickins <hugh@veritas.com>

--- 2.6.16-rc1-git4/kernel/sysctl.c	2006-01-22 09:22:41.000000000 +0000
+++ linux/kernel/sysctl.c	2006-01-23 13:25:22.000000000 +0000
@@ -878,7 +878,8 @@ static ctl_table vm_table[] = {
 		.maxlen		= sizeof(zone_reclaim_mode),
 		.mode		= 0644,
 		.proc_handler	= &proc_dointvec,
-		.strategy	= &zero,
+		.strategy	= &sysctl_intvec,
+		.extra1		= &zero,
 	},
 #endif
 	{ .ctl_name = 0 }
