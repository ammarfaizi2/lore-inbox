Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311180AbSDECHb>; Thu, 4 Apr 2002 21:07:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311121AbSDECHM>; Thu, 4 Apr 2002 21:07:12 -0500
Received: from zero.tech9.net ([209.61.188.187]:34571 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S311092AbSDECHH>;
	Thu, 4 Apr 2002 21:07:07 -0500
Subject: Re: [PATCH] preemptive kernel behavior change: don't be rude
From: Robert Love <rml@tech9.net>
To: george anzinger <george@mvista.com>
Cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <3CAD0311.CFCCCDB@mvista.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 04 Apr 2002 21:06:29 -0500
Message-Id: <1017972405.22304.720.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-04-04 at 20:51, george anzinger wrote:

> This line implies that entry.S calls with preempt count of 0.  It use to
> call with 1 or was that WAY back there?  

No you are right, this line needs to be pushed back out to
preempt_enable OR we need to duplicate preempt_schedule in the entry.S
code.  For now, I will just push this back into preempt_enable.

> If this is the way it is and it works, then the += and -= below can be
> changed to = and the second reference to PREEMPT_ACTIVE becomes 0.
> 
> I think I would rather have entry.S set preempt_count to PREEMPT_ACTIVE
> with the interrupt system off, turn it on, make the call directly to
> schedule(), and then set to zero on return.  I really am concerned with
> taking an interrupt during the call, i.e. between the interrupt on and
> the store below.  This can lead to stack overflow rather easily.

Agreed.  This is probably the best way to do it ... for now I'll do it
like above.

	Robert Love

