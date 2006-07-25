Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932358AbWGYAad@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932358AbWGYAad (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 20:30:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932359AbWGYAad
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 20:30:33 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:3819 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932358AbWGYAac (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 20:30:32 -0400
Subject: [PATCH] [afs] Add lock annotations to
	afs_proc_cell_servers_{start,stop}
From: Josh Triplett <josht@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>
Content-Type: text/plain
Date: Mon, 24 Jul 2006 17:30:33 -0700
Message-Id: <1153787433.31581.41.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

afs_proc_cell_servers_start acquires a lock, and afs_proc_cell_servers_stop
releases that lock.  Add lock annotations to these two functions so that
sparse can check callers for lock pairing, and so that sparse will not
complain about these functions since they intentionally use locks in this
manner.

Signed-off-by: Josh Triplett <josh@freedesktop.org>
---
 fs/afs/proc.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/fs/afs/proc.c b/fs/afs/proc.c
index 101d21b..86463ec 100644
--- a/fs/afs/proc.c
+++ b/fs/afs/proc.c
@@ -775,6 +775,7 @@ static int afs_proc_cell_servers_release
  * first item
  */
 static void *afs_proc_cell_servers_start(struct seq_file *m, loff_t *_pos)
+	__acquires(m->private->sv_lock)
 {
 	struct list_head *_p;
 	struct afs_cell *cell = m->private;
@@ -823,6 +824,7 @@ static void *afs_proc_cell_servers_next(
  * clean up after reading from the cells list
  */
 static void afs_proc_cell_servers_stop(struct seq_file *p, void *v)
+	__releases(p->private->sv_lock)
 {
 	struct afs_cell *cell = p->private;
 


