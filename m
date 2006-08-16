Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751254AbWHPXeG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbWHPXeG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 19:34:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbWHPXeG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 19:34:06 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:22762 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751254AbWHPXeE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 19:34:04 -0400
Date: Wed, 16 Aug 2006 16:34:04 -0700
From: Sukadev Bhattiprolu <sukadev@us.ibm.com>
To: akpm@osdl.org
Cc: "David C. Hansen" <haveblue@us.ibm.com>, clg@fr.ibm.com, serue@us.ibm.com,
       linux-kernel@vger.kernel.org, containers@lists.osdl.org
Subject: [PATCH] Coding style - Use struct pidmap
Message-ID: <20060816233404.GA10635@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Operating-System: Linux 2.0.32 on an i486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Use struct pidmap instead of pidmap_t.

Its a subset of Eric Biederman's patch http://lkml.org/lkml/2006/2/6/271.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Sukadev Bhattiprolu <sukadev@us.ibm.com>
Cc: Dave Hansen <haveblue@us.ibm.com>
Cc: Serge Hallyn <serue@us.ibm.com>
Cc: Cedric Le Goater <clg@fr.ibm.com>
Cc: <containers@lists.osdl.org>

 kernel/pid.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

Index: linux-2.6.18-rc3/kernel/pid.c
===================================================================
--- linux-2.6.18-rc3.orig/kernel/pid.c	2006-08-10 17:58:55.000000000 -0700
+++ linux-2.6.18-rc3/kernel/pid.c	2006-08-10 18:32:20.000000000 -0700
@@ -53,12 +53,12 @@ int pid_max_max = PID_MAX_LIMIT;
  * value does not cause lots of bitmaps to be allocated, but
  * the scheme scales to up to 4 million PIDs, runtime.
  */
-typedef struct pidmap {
+struct pidmap {
 	atomic_t nr_free;
 	void *page;
-} pidmap_t;
+};
 
-static pidmap_t pidmap_array[PIDMAP_ENTRIES] =
+static struct pidmap pidmap_array[PIDMAP_ENTRIES] =
 	 { [ 0 ... PIDMAP_ENTRIES-1 ] = { ATOMIC_INIT(BITS_PER_PAGE), NULL } };
 
 /*
@@ -78,7 +78,7 @@ static  __cacheline_aligned_in_smp DEFIN
 
 static fastcall void free_pidmap(int pid)
 {
-	pidmap_t *map = pidmap_array + pid / BITS_PER_PAGE;
+	struct pidmap *map = pidmap_array + pid / BITS_PER_PAGE;
 	int offset = pid & BITS_PER_PAGE_MASK;
 
 	clear_bit(offset, map->page);
@@ -88,7 +88,7 @@ static fastcall void free_pidmap(int pid
 static int alloc_pidmap(void)
 {
 	int i, offset, max_scan, pid, last = last_pid;
-	pidmap_t *map;
+	struct pidmap *map;
 
 	pid = last + 1;
 	if (pid >= pid_max)
