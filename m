Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261522AbULYO15@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261522AbULYO15 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Dec 2004 09:27:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261521AbULYO14
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Dec 2004 09:27:56 -0500
Received: from golobica.uni-mb.si ([164.8.100.4]:13788 "EHLO
	golobica.uni-mb.si") by vger.kernel.org with ESMTP id S261518AbULYO0U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Dec 2004 09:26:20 -0500
Subject: [patch 2/2] linux-2.6.9/fs/proc/proc_tty.c: avoid array
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, wharms@bfs.de
From: domen@coderock.org
Date: Sat, 25 Dec 2004 15:26:22 +0100
Message-Id: <20041225142613.046964DC074@golobica.uni-mb.si>
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
