Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314480AbSDWWoG>; Tue, 23 Apr 2002 18:44:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314481AbSDWWoF>; Tue, 23 Apr 2002 18:44:05 -0400
Received: from zero.tech9.net ([209.61.188.187]:49670 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S314480AbSDWWoD>;
	Tue, 23 Apr 2002 18:44:03 -0400
Subject: Re: [PATCH] 2.5: MAX_PRIO cleanup
From: Robert Love <rml@tech9.net>
To: mingo@elte.hu
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0204230948150.10873-100000@elte.hu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 23 Apr 2002 18:43:58 -0400
Message-Id: <1019601843.1469.257.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-04-23 at 03:53, Ingo Molnar wrote:

> >  /*
> > - * Priority of a process goes from 0 to 139. The 0-99
> > - * priority range is allocated to RT tasks, the 100-139
> > - * range is for SCHED_OTHER tasks. Priority values are
> > - * inverted: lower p->prio value means higher priority.
> > + * Priority of a process goes from 0 to MAX_PRIO-1.  The
> > + * 0 to MAX_RT_PRIO-1 priority range is allocated to RT tasks,
> > + * the MAX_RT_PRIO to MAX_PRIO range is for SCHED_OTHER tasks.
> > + * Priority values are inverted: lower p->prio value means higher
> > + * priority.
> 
> this i dont agree with either. The point of comments is easy
> understanding, so i intentionally kept the 'hard' constants and i'm
> updating them constantly - it's much easier to understand how things
> happen if it does not happen via a define. The code itself i agree should
> stay abstract, but the comments should stay as humanly readable as
> possible.

Now that I am working on the configurable maximum RT value patch, I see
why I did this: we can't hardcode the values like "0 to 99" because that
99 is set now via a compile-time define.  Even if it defaults to 100, it
can be a range of values so the comments should be specific and give the
exact define.

That is why I did it in the invariant patch, anyhow - and I think it
makes the most sense to do it in this patch.

	Robert Love

