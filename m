Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311885AbSDDXM5>; Thu, 4 Apr 2002 18:12:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311898AbSDDXMr>; Thu, 4 Apr 2002 18:12:47 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:56845 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S311885AbSDDXMf>; Thu, 4 Apr 2002 18:12:35 -0500
Message-ID: <3CACDD5D.9A9735A9@zip.com.au>
Date: Thu, 04 Apr 2002 15:10:21 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: Roger Larsson <roger.larsson@norran.net>,
        Linus Torvalds <torvalds@transmeta.com>,
        Dave Hansen <haveblue@us.ibm.com>,
        "Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org
Subject: Re: Patch: linux-2.5.8-pre1/kernel/exit.c change caused BUG() atboot  
 time
In-Reply-To: <3CACD5D3.B2DA02AE@zip.com.au> <1017960927.22299.634.camel@phantasy>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> 
> ...
> This allows us to preempt tasks in any state, without problems or
> special cases.  It also wasn't too much overhead - compared to now,
> basically just:
> 
>         if (unlikely(current->preempt_count() & PREEMPT_ACTIVE))
>                 goto pick_next_task;
> 
> at the top of schedule().
> 

That's changing schedule().  Seems that I'd ruled out that
option prematurely.  As current->preempt_count() and PREEMPT_ACTIVE
can both evaluate to constant zero if CONFIG_PREEMPT=n, it can
be done ifdeflessly.

Everything happens inside rq->lock.  Looks solid to me.

-
