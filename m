Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750999AbWDEACu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750999AbWDEACu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 20:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750995AbWDEACS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 20:02:18 -0400
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:2243 "EHLO
	aria.kroah.org") by vger.kernel.org with ESMTP id S1750959AbWDEACL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 20:02:11 -0400
Date: Tue, 4 Apr 2006 17:01:25 -0700
From: gregkh@suse.de
To: linux-kernel@vger.kernel.org, stable@kernel.org, vgoyal@in.ibm.com,
       oomichi@mxs.nes.nec.co.jp, mm-commits@vger.kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 26/26] kdump proc vmcore size oveflow fix
Message-ID: <20060405000125.GA27049@kroah.com>
References: <20060404235634.696852000@quad.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="kdump-proc-vmcore-size-oveflow-fix.patch"
In-Reply-To: <20060404235927.GA27049@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vivek Goyal <vgoyal@in.ibm.com>

A couple of /proc/vmcore data structures overflow with 32bit systems having
memory more than 4G.  This patch fixes those.

Signed-off-by: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


---
 fs/proc/vmcore.c        |    4 ++--
 include/linux/proc_fs.h |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

--- linux-2.6.16.1.orig/fs/proc/vmcore.c
+++ linux-2.6.16.1/fs/proc/vmcore.c
@@ -103,8 +103,8 @@ static ssize_t read_vmcore(struct file *
 				size_t buflen, loff_t *fpos)
 {
 	ssize_t acc = 0, tmp;
-	size_t tsz, nr_bytes;
-	u64 start;
+	size_t tsz;
+	u64 start, nr_bytes;
 	struct vmcore *curr_m = NULL;
 
 	if (buflen == 0 || *fpos >= vmcore_size)
--- linux-2.6.16.1.orig/include/linux/proc_fs.h
+++ linux-2.6.16.1/include/linux/proc_fs.h
@@ -78,7 +78,7 @@ struct kcore_list {
 struct vmcore {
 	struct list_head list;
 	unsigned long long paddr;
-	unsigned long size;
+	unsigned long long size;
 	loff_t offset;
 };
 

--
