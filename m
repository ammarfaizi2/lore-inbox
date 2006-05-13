Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932433AbWEMOMV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932433AbWEMOMV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 10:12:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932420AbWEMOMV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 10:12:21 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:6289 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932433AbWEMOMV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 10:12:21 -0400
Date: Sat, 13 May 2006 10:12:11 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Ingo Molnar <mingo@elte.hu>, akpm@osdl.org,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Silly bitmap size accounting fix
In-Reply-To: <4465386B.9090804@yahoo.com.au>
Message-ID: <Pine.LNX.4.58.0605131010110.27003@gandalf.stny.rr.com>
References: <Pine.LNX.4.58.0605120403540.28581@gandalf.stny.rr.com>
 <20060512091451.GA18145@elte.hu> <4465386B.9090804@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 13 May 2006, Nick Piggin wrote:

> Ingo Molnar wrote:
> > * Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> >
> >>-#define BITMAP_SIZE ((((MAX_PRIO+1+7)/8)+sizeof(long)-1)/sizeof(long))
> >>+#define BITMAP_SIZE ((((MAX_PRIO+7)/8)+sizeof(long)-1)/sizeof(long))
> >
> >
> > Acked-by: Ingo Molnar <mingo@elte.hu>
>
> Really?! What about the delimiter bit set at MAX_PRIO?


		// delimiter for bitsearch
		__set_bit(MAX_PRIO, array->bitmap);


Ah! I see what you mean.  New patch (add a comment).

-- Steve

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-2.6.17-rc3-mm1/kernel/sched.c
===================================================================
--- linux-2.6.17-rc3-mm1.orig/kernel/sched.c	2006-05-12 04:02:32.000000000 -0400
+++ linux-2.6.17-rc3-mm1/kernel/sched.c	2006-05-13 10:09:15.000000000 -0400
@@ -192,6 +192,10 @@ static inline unsigned int task_timeslic
  * These are the runqueue data structures:
  */

+/*
+ * Calculate BITMAP_SIZE.
+ *  The bitmask holds MAX_PRIO bits + 1 for the delimiter.
+ */
 #define BITMAP_SIZE ((((MAX_PRIO+1+7)/8)+sizeof(long)-1)/sizeof(long))

 typedef struct runqueue runqueue_t;
