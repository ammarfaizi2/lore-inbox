Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319005AbSHMRzT>; Tue, 13 Aug 2002 13:55:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319010AbSHMRzT>; Tue, 13 Aug 2002 13:55:19 -0400
Received: from mx2.elte.hu ([157.181.151.9]:34776 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S319005AbSHMRzI>;
	Tue, 13 Aug 2002 13:55:08 -0400
Date: Tue, 13 Aug 2002 19:59:12 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@zip.com.au>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] kwaitd, 2.5.31-A1
In-Reply-To: <3D594A68.88807CEE@zip.com.au>
Message-ID: <Pine.LNX.4.44.0208131956510.5934-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 13 Aug 2002, Andrew Morton wrote:

> Well what we can do in there is to just have a one-deep percpu list. So
> the exitting task frees the previous thread's stack (if any) and inserts
> its own stack.  And that stack can be used in fork, of course.  Which
> gives some per-cpu LIFO stack allocation.

yeah, this will work - and it's not a big chunk of RAM we are holding
onto, so we can keep it around indefinitely. I'll try it this way.

(the LIFO argument is not true once the proper per-CPU page caching
patches are integrated.)

(btw., the kernel has the same catch-22 problem as user-space's problem
with stack deallocation, with the difference that it's much easier and
cheaper to provide atomicity in kernel-space.)

	Ingo

