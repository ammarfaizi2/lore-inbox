Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262278AbVCOFrC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262278AbVCOFrC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 00:47:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262272AbVCOFrB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 00:47:01 -0500
Received: from fire.osdl.org ([65.172.181.4]:29378 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262269AbVCOFp0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 00:45:26 -0500
Date: Mon, 14 Mar 2005 21:45:06 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: nikita@clusterfs.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm counter operations through macros
Message-Id: <20050314214506.050efadf.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0503142103090.16582@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0503110422150.19280@schroedinger.engr.sgi.com>
	<20050311182500.GA4185@redhat.com>
	<Pine.LNX.4.58.0503111103200.22240@schroedinger.engr.sgi.com>
	<16946.62799.737502.923025@gargle.gargle.HOWL>
	<Pine.LNX.4.58.0503142103090.16582@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@sgi.com> wrote:
>
>  This patch extracts all the operations on counters protected by the
>  page table lock (currently rss and anon_rss) into definitions in
>  include/linux/sched.h. All rss operations are performed through
>  the following macros:

I don't think the MM_COUNTER_T macro adds much, really.  How about this?

--- 25/include/linux/sched.h~mm-counter-operations-through-macros-tidy	2005-03-14 21:43:00.000000000 -0800
+++ 25-akpm/include/linux/sched.h	2005-03-14 21:43:00.000000000 -0800
@@ -210,7 +210,6 @@ extern void arch_unmap_area_topdown(stru
 #define inc_mm_counter(mm, member) (mm)->_##member++
 #define dec_mm_counter(mm, member) (mm)->_##member--
 typedef unsigned long mm_counter_t;
-#define MM_COUNTER_T(member) mm_counter_t _##member
 
 struct mm_struct {
 	struct vm_area_struct * mmap;		/* list of VMAs */
@@ -241,8 +240,8 @@ struct mm_struct {
 	unsigned long exec_vm, stack_vm, reserved_vm, def_flags, nr_ptes;
 
 	/* Special counters protected by the page_table_lock */
-	MM_COUNTER_T(rss);
-	MM_COUNTER_T(anon_rss);
+	mm_counter_t _rss;
+	mm_counter_t _anon_rss;
 
 	unsigned long saved_auxv[42]; /* for /proc/PID/auxv */
 
_

