Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261210AbVBYToW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261210AbVBYToW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 14:44:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261264AbVBYToW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 14:44:22 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:10176 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261210AbVBYToM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 14:44:12 -0500
Date: Fri, 25 Feb 2005 11:28:28 -0800
From: Chandra Seetharaman <sekharan@us.ibm.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Gerrit Huizenga <gh@us.ibm.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ckrm-tech@lists.sourceforge.net
Subject: Re: [ckrm-tech] Re: [PATCH] CKRM [7/8]  Resource controller for number of tasks per class
Message-ID: <20050225192828.GF14595@chandralinux.beaverton.ibm.com>
References: <E1D4FOI-0006wW-00@w-gerrit.beaverton.ibm.com> <1109261743.7244.64.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1109261743.7244.64.camel@localhost>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2005 at 08:15:43AM -0800, Dave Hansen wrote:
> On Thu, 2005-02-24 at 01:34 -0800, Gerrit Huizenga wrote:
> > This patch provides a resource controller for limiting the number
> > of tasks per class in CKRM.
> 
> It takes 627 lines of code to count the number of tasks in a class?

It is not just counting the number of tasks. It helps the user to manage
and monitor it, which one can use to do accounting, planning etc.,

But, we get your point. will look into it.
> What does all of that infrastructure buy you, again?
> 
> All of the logic to borrow if you've gone over your limit should be a
> quite repeated theme throughout all of the controllers.  Seems to me
> that at least a larger chunk of that should be in generic code.  

Current controllers we have are very different from each other(because of
the nature of the resource they manage) in the way they handle the shares.
That makes sharing hard.

We do have plan to make one of the function common.
> 
> > +static void numtasks_res_free(void *my_res)
> > +{
> ...
> > +       if (unlikely(atomic_read(&res->cnt_cur_alloc) < 0)) {
> > +               printk(KERN_WARNING "numtasks_res: counter below 0
> > \n");
> > +       }
> > +       if (unlikely(atomic_read(&res->cnt_cur_alloc) > 0 ||
> > +                               atomic_read(&res->cnt_borrowed) > 0)) 
> 
> How often is this called?  Do you really need unlikely()?

not very often. can go.
> 
> -- Dave
> 
> 
> 
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
> _______________________________________________
> ckrm-tech mailing list
> https://lists.sourceforge.net/lists/listinfo/ckrm-tech

-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------
