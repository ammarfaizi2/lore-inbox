Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261189AbVCKQTo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261189AbVCKQTo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 11:19:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261188AbVCKQTn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 11:19:43 -0500
Received: from host-65-117-135-105.timesys.com ([65.117.135.105]:18641 "EHLO
	yoda.timesys") by vger.kernel.org with ESMTP id S261189AbVCKQT0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 11:19:26 -0500
Date: Fri, 11 Mar 2005 11:19:23 -0500
To: Ingo Molnar <mingo@elte.hu>
Cc: Scott Wood <scott@gw.timesys.com>, linux-kernel@vger.kernel.org,
       manas.saksena@timesys.com
Subject: Re: [PATCH] realtime-preempt: update inherited priorities on setscheduler
Message-ID: <20050311161923.GA4518@yoda.timesys>
References: <20050310212116.GA2420@yoda.timesys> <20050311093607.GB19954@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050311093607.GB19954@elte.hu>
User-Agent: Mutt/1.5.4i
From: Scott Wood <scott@gw.timesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2005 at 10:36:07AM +0100, Ingo Molnar wrote:
> 
> * Scott Wood <scott@gw.timesys.com> wrote:
> 
> > -	p->prio = effective_prio(p);
> > +	/* Don't overwrite an inherited RT priority with the static
> > +	   RT priority. */
> > +
> > +	if (!rt_task(p))
> > +		p->prio = effective_prio(p);
> 
> are you sure this is needed? The -RT code currently does this:
> 
>  static int effective_prio(task_t *p)
>  {
>          if (rt_task(p))
>                  return p->prio;
>          return __effective_prio(p);
>  }

I must have read-then-misremembered it as recalculating the prio from
rt_priority, or else been worried about some race that doesn't appear
possible.  The change isn't needed.

-Scott
