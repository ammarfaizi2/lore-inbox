Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261523AbULYPhS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261523AbULYPhS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Dec 2004 10:37:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261525AbULYPhR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Dec 2004 10:37:17 -0500
Received: from coderock.org ([193.77.147.115]:17884 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261523AbULYPfO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Dec 2004 10:35:14 -0500
Subject: [patch 2/2] linux-2.6.9/fs/proc/proc_tty.c: avoid array
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, wharms@bfs.de
From: domen@coderock.org
Date: Sat, 25 Dec 2004 16:35:16 +0100
Message-Id: <20041225153506.E346B1F123@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi list,
no need for an array here.  therefor no need to worry about possible 
overflows. seq_printf() can handle this.

avoid array in show_tty_range()

re,
walter

signed-off-by: walter harms <wharms@bfs.de>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/fs/proc/proc_tty.c |    4 +---
 1 files changed, 1 insertion(+), 3 deletions(-)

diff -puN fs/proc/proc_tty.c~remove_sprintf-fs_proc_proc_tty.c.bak fs/proc/proc_tty.c
--- kj/fs/proc/proc_tty.c~remove_sprintf-fs_proc_proc_tty.c.bak	2004-12-25 01:36:07.000000000 +0100
+++ kj-domen/fs/proc/proc_tty.c	2004-12-25 01:36:07.000000000 +0100
@@ -32,10 +32,8 @@ static void show_tty_range(struct seq_fi
 	seq_printf(m, "%-20s ", p->driver_name ? p->driver_name : "unknown");
 	seq_printf(m, "/dev/%-8s ", p->name);
 	if (p->num > 1) {
-		char	range[20];
-		sprintf(range, "%d-%d", MINOR(from),
+		seq_printf(m, "%3d %d-%d ", MAJOR(from), MINOR(from),
 			MINOR(from) + num - 1);
-		seq_printf(m, "%3d %7s ", MAJOR(from), range);
 	} else {
 		seq_printf(m, "%3d %7d ", MAJOR(from), MINOR(from));
 	}
diff -L fs/proc/proc_tty.c.bak -puN /dev/null /dev/null
_
