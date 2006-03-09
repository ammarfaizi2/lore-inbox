Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751473AbWCIJME@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751473AbWCIJME (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 04:12:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751491AbWCIJME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 04:12:04 -0500
Received: from mail27.syd.optusnet.com.au ([211.29.133.168]:51858 "EHLO
	mail27.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751473AbWCIJMD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 04:12:03 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH] mm: yield during swap prefetching
Date: Thu, 9 Mar 2006 20:11:47 +1100
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org, ck@vds.kolivas.org
References: <200603081013.44678.kernel@kolivas.org> <200603091330.14396.kernel@kolivas.org> <440F99AF.8050706@yahoo.com.au>
In-Reply-To: <440F99AF.8050706@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603092011.48494.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 09 March 2006 13:57, Nick Piggin wrote:
> Con Kolivas wrote:
> >On Thu, 9 Mar 2006 01:22 pm, Nick Piggin wrote:
> >>So as much as a major fault costs in terms of performance, the tiny
> >>chance that prefetching will avoid it means even the CPU usage is
> >>questionable. Using sched_yield() seems like a hack though.
> >
> >Yeah it's a hack alright. Funny how at last I find a place where yield
> > does exactly what I want and because we hate yield so much noone wants me
> > to use it all.
>
> AFAIKS it is a hack for the same reason using it for locking is a hack,
> it's just that prefetch doesn't care if it doesn't get the CPU back for
> a while.
>
> Given a yield implementation which does something completely different
> for SCHED_OTHER tasks, you code may find it doesn't work so well anymore.
> This is no different to the java folk using it with decent results for
> locking. Just because it happened to work OK for them at the time didn't
> mean it was the right thing to do.
>
> I have always maintained that a SCHED_OTHER task calling sched_yield
> is basically a bug because it is utterly undefined behaviour.
>
> But being an in-kernel user that "knows" the implementation sort of does
> the right thin, maybe you justify it that way.

You're right. Even if I do know exactly how yield works and am using it to my 
advantage, any solution that depends on the way yield works may well not work 
in the future. It does look like I should just check cpu usage as well in 
prefetch_suitable(). That will probably be the best generalised solution to 
this. 

Thanks.

Cheers,
Con
