Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319012AbSHMTet>; Tue, 13 Aug 2002 15:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319039AbSHMTet>; Tue, 13 Aug 2002 15:34:49 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:13828 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S319012AbSHMTet>; Tue, 13 Aug 2002 15:34:49 -0400
Date: Tue, 13 Aug 2002 12:41:03 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Christoph Hellwig <hch@infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] CLONE_SETTLS, CLONE_SETTID, 2.5.31-BK
In-Reply-To: <Pine.LNX.4.44.0208132100120.7535-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0208131239271.7411-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 13 Aug 2002, Ingo Molnar wrote:
> > 
> > Except you actually test the CLONE_SETTLS bit..
> 
> We've tested clone_startup() with real threads on a 2.4-backported version
> of yesterday's final TLS API quite extensively, and it works as expected.  
> (as we've tested earlier incarnations of the TLS API and code as well.)

It's still buggy, and you didn't read what I wrote.

+       /*
+        * Notify the child of the TID?
+        */
+       if (clone_flags & CLONE_SETTLS)
+               if (put_user(p->pid, (pid_t *)childregs->edx))
+                       return -EFAULT;

Find the bug. Find the sentence I wrote that pointed it out last time. 
Notice how your testing did not find it, since you always just set both 
flags.

		Linus

