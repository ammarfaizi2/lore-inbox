Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261526AbUJXPuM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261526AbUJXPuM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 11:50:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261533AbUJXPqU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 11:46:20 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:44824 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261526AbUJXPoR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 11:44:17 -0400
Date: Sun, 24 Oct 2004 16:43:52 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: Frank Hirtz <fhirtz@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] omit CommitAvail
Message-ID: <Pine.LNX.4.44.0410241642230.12023-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CommitLimit was a good addition to /proc/meminfo, but we don't usually
show both what's used and what's free: don't waste lines of screenspace,
omit CommitAvail, let the user do the arithmetic as with all the others.
And in updating that Documentation, removed the long-gone ReverseMaps.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---
 Documentation/filesystems/proc.txt     |   14 --------------
 Documentation/vm/overcommit-accounting |    5 ++---
 fs/proc/proc_misc.c                    |    2 --
 3 files changed, 2 insertions(+), 19 deletions(-)

--- 2.6.10-rc1/Documentation/filesystems/proc.txt	2004-10-23 12:43:38.000000000 +0100
+++ linux/Documentation/filesystems/proc.txt	2004-10-24 12:58:16.408009536 +0100
@@ -380,9 +380,7 @@ Mapped:         280372 kB
 Slab:           684068 kB
 CommitLimit:   7669796 kB
 Committed_AS:   100056 kB
-CommitAvail:   7569740 kB
 PageTables:      24448 kB
-ReverseMaps:   1080904
 VmallocTotal:   112216 kB
 VmallocUsed:       428 kB
 VmallocChunk:   111088 kB
@@ -446,20 +444,8 @@ Committed_AS: The amount of memory prese
               above) will not be permitted. This is useful if one needs
               to guarantee that processes will not fail due to lack of
               memory once that memory has been successfully allocated.
- CommitAvail: Based on the current overcommit ratio
-              ('vm.overcommit_ratio'), this is the amount of memory
-              currently available to be allocated under the overcommit
-              limit (the CommitLimit above). This is calculated as:
-              CommitAvail = CommitLimit - Committed_AS
-              This limit is only enforced if strict overcommit accounting
-              is enabled (mode 2 in 'vm.overcommit_memory'). CommitAvail
-              may be a negative number if strict accounting is not enabled
-              and the system's memory is currently overcommitted.
-              For more details, see the memory overcommit documentation
-              in vm/overcommit-accounting.
   PageTables: amount of memory dedicated to the lowest level of page
               tables.
- ReverseMaps: number of reverse mappings performed
 VmallocTotal: total size of vmalloc memory area
  VmallocUsed: amount of vmalloc area which is used
 VmallocChunk: largest contigious block of vmalloc area which is free
--- 2.6.10-rc1/Documentation/vm/overcommit-accounting	2004-10-23 12:43:38.000000000 +0100
+++ linux/Documentation/vm/overcommit-accounting	2004-10-24 13:00:35.516861776 +0100
@@ -22,9 +22,8 @@ The overcommit policy is set via the sys
 
 The overcommit percentage is set via `vm.overcommit_ratio'.
 
-The current overcommit limit, amount used, and amount remaining below
-the limit are viewable in /proc/meminfo as CommitLimit, Committed_AS, and
-CommitAvail respectively.
+The current overcommit limit and amount committed are viewable in
+/proc/meminfo as CommitLimit and Committed_AS respectively.
 
 Gotchas
 -------
--- 2.6.10-rc1/fs/proc/proc_misc.c	2004-10-23 12:44:06.000000000 +0100
+++ linux/fs/proc/proc_misc.c	2004-10-23 20:43:24.000000000 +0100
@@ -204,7 +204,6 @@ static int meminfo_read_proc(char *page,
 		"Slab:         %8lu kB\n"
 		"CommitLimit:  %8lu kB\n"
 		"Committed_AS: %8lu kB\n"
-		"CommitAvail:  %8ld kB\n"
 		"PageTables:   %8lu kB\n"
 		"VmallocTotal: %8lu kB\n"
 		"VmallocUsed:  %8lu kB\n"
@@ -228,7 +227,6 @@ static int meminfo_read_proc(char *page,
 		K(ps.nr_slab),
 		K(allowed),
 		K(committed),
-		K(allowed - committed),
 		K(ps.nr_page_table_pages),
 		vmtot,
 		vmi.used,

