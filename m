Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751162AbWEMOxl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162AbWEMOxl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 10:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751195AbWEMOxl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 10:53:41 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:42988 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751162AbWEMOxk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 10:53:40 -0400
Date: Sat, 13 May 2006 10:53:26 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Ingo Molnar <mingo@elte.hu>, akpm@osdl.org,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Silly bitmap size accounting fix
In-Reply-To: <4465EF80.6010106@yahoo.com.au>
Message-ID: <Pine.LNX.4.58.0605131051160.27751@gandalf.stny.rr.com>
References: <Pine.LNX.4.58.0605120403540.28581@gandalf.stny.rr.com>
 <20060512091451.GA18145@elte.hu> <4465386B.9090804@yahoo.com.au>
 <Pine.LNX.4.58.0605131010110.27003@gandalf.stny.rr.com> <4465EF80.6010106@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> > +/*
> > + * Calculate BITMAP_SIZE.
> > + *  The bitmask holds MAX_PRIO bits + 1 for the delimiter.
>
> + * Calculation is to find the minimum number of longs that holds MAX_PRIO+1 bits:
> + *  size-in-chars = ceiling((MAX_PRIO+1) / CHAR_BITS)
> + *  size-in-longs = ceiling(size-in-chars / sizeof(long))
>
> > + */
> >  #define BITMAP_SIZE ((((MAX_PRIO+1+7)/8)+sizeof(long)-1)/sizeof(long))
> >
>

What do you think of the following comment, better?

-- Steve

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-2.6.17-rc3-mm1/kernel/sched.c
===================================================================
--- linux-2.6.17-rc3-mm1.orig/kernel/sched.c	2006-05-12 04:02:32.000000000 -0400
+++ linux-2.6.17-rc3-mm1/kernel/sched.c	2006-05-13 10:50:44.000000000 -0400
@@ -192,6 +192,13 @@ static inline unsigned int task_timeslic
  * These are the runqueue data structures:
  */

+/*
+ * Calculate BITMAP_SIZE.
+ *  The bitmask holds MAX_PRIO bits + 1 for the delimiter.
+ *  BITMAP_SIZE is the minimum number of longs that holds MAX_PRIO+1 bits:
+ *   size-in-bytes = ceiling((MAX_PRIO+1) / BITS_PER_BYTE)
+ *   size-in-longs = ceiling(size-in-bytes / sizeof(long))
+ */
 #define BITMAP_SIZE ((((MAX_PRIO+1+7)/8)+sizeof(long)-1)/sizeof(long))

 typedef struct runqueue runqueue_t;
