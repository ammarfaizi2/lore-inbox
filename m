Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932461AbWEMP7d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932461AbWEMP7d (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 11:59:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932462AbWEMP7d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 11:59:33 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:2553 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932461AbWEMP7c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 11:59:32 -0400
Date: Sat, 13 May 2006 11:59:17 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Takashi Iwai <tiwai@suse.de>, Ingo Molnar <mingo@elte.hu>, akpm@osdl.org,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Silly bitmap size accounting fix
In-Reply-To: <4465FEFD.9050603@yahoo.com.au>
Message-ID: <Pine.LNX.4.58.0605131157220.27751@gandalf.stny.rr.com>
References: <Pine.LNX.4.58.0605120403540.28581@gandalf.stny.rr.com>
 <20060512091451.GA18145@elte.hu> <4465386B.9090804@yahoo.com.au>
 <Pine.LNX.4.58.0605131010110.27003@gandalf.stny.rr.com> <s5hpsiivsw8.wl%tiwai@suse.de>
 <4465FEFD.9050603@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 14 May 2006, Nick Piggin wrote:

>
> Yes that sounds even better.
>

I absolutely agree (a bit of a blush as well!)

Andrew,

I guess this is much better than before.  Never seen so much action on a
patch that was just a comment!

-- Steve

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-2.6.17-rc3-mm1/kernel/sched.c
===================================================================
--- linux-2.6.17-rc3-mm1.orig/kernel/sched.c	2006-05-12 04:02:32.000000000 -0400
+++ linux-2.6.17-rc3-mm1/kernel/sched.c	2006-05-13 11:56:08.000000000 -0400
@@ -192,13 +192,11 @@ static inline unsigned int task_timeslic
  * These are the runqueue data structures:
  */

-#define BITMAP_SIZE ((((MAX_PRIO+1+7)/8)+sizeof(long)-1)/sizeof(long))
-
 typedef struct runqueue runqueue_t;

 struct prio_array {
 	unsigned int nr_active;
-	unsigned long bitmap[BITMAP_SIZE];
+	DECLARE_BITMAP(bitmap, MAX_PRIO+1); /* include 1 bit for delimiter */
 	struct list_head queue[MAX_PRIO];
 };

