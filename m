Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311898AbSDDXQ1>; Thu, 4 Apr 2002 18:16:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311925AbSDDXQR>; Thu, 4 Apr 2002 18:16:17 -0500
Received: from zero.tech9.net ([209.61.188.187]:266 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S311898AbSDDXQG>;
	Thu, 4 Apr 2002 18:16:06 -0500
Subject: Re: Patch: linux-2.5.8-pre1/kernel/exit.c change caused BUG()
	atboot   time
From: Robert Love <rml@tech9.net>
To: Andrew Morton <akpm@zip.com.au>
Cc: Roger Larsson <roger.larsson@norran.net>,
        Linus Torvalds <torvalds@transmeta.com>,
        Dave Hansen <haveblue@us.ibm.com>,
        "Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org
In-Reply-To: <3CACDD5D.9A9735A9@zip.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 04 Apr 2002 18:16:02 -0500
Message-Id: <1017962163.22299.653.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-04-04 at 18:10, Andrew Morton wrote:

> That's changing schedule().  Seems that I'd ruled out that
> option prematurely.  As current->preempt_count() and PREEMPT_ACTIVE
> can both evaluate to constant zero if CONFIG_PREEMPT=n, it can
> be done ifdeflessly.
> 
> Everything happens inside rq->lock.  Looks solid to me.

It is solid - I did not just invent that approach, it was how we have
always done it until around 2.5.6-pre (Ingo sent a patch to change it). 
The 2.4 patches do it this way (take a look) and 2.5 before the change
obviously worked like this.

It hasn't shown any problems in ~6 months of use.

I'll cook up a patch to do it, but I'd like to hear Linus opinion ...

	Robert Love

