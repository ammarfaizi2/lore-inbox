Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262871AbUKXWLM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262871AbUKXWLM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 17:11:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262872AbUKXWLL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 17:11:11 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:54506 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262871AbUKXWJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 17:09:40 -0500
Subject: Re: Suspend 2 merge: 14/51: Disable page alloc failure message
	when suspending
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1101312041.8940.45.camel@localhost>
References: <1101292194.5805.180.camel@desktop.cunninghams>
	 <1101294838.5805.245.camel@desktop.cunninghams>
	 <1101312041.8940.45.camel@localhost>
Content-Type: text/plain
Message-Id: <1101330362.3895.24.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 25 Nov 2004 08:06:02 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Thu, 2004-11-25 at 03:00, Dave Hansen wrote:
> On Wed, 2004-11-24 at 04:57, Nigel Cunningham wrote:
> > While eating memory, we will potentially trigger this a lot. We
> > therefore disable the message when suspending.
> > 
> > diff -ruN 503-disable-page-alloc-warnings-while-suspending-old/mm/page_alloc.c 503-disable-page-alloc-warnings-while-suspending-new/mm/page_alloc.c
> > --- 503-disable-page-alloc-warnings-while-suspending-old/mm/page_alloc.c	2004-11-06 09:24:37.231308424 +1100
> > +++ 503-disable-page-alloc-warnings-while-suspending-new/mm/page_alloc.c	2004-11-06 09:24:40.844759096 +1100
> > @@ -725,7 +725,10 @@
> >  	}
> >  
> >  nopage:
> > -	if (!(gfp_mask & __GFP_NOWARN) && printk_ratelimit()) {
> > +	if ((!(gfp_mask & __GFP_NOWARN)) && 
> > +		(!test_suspend_state(SUSPEND_RUNNING)) &&
> > +		printk_ratelimit()) {
> > +
> >  		printk(KERN_WARNING "%s: page allocation failure."
> >  			" order:%d, mode:0x%x\n",
> >  			p->comm, order, gfp_mask);
> 
> Following Documentation/SubmittingPatches, please submit patches made
> with "diff -urp":
> 
>        -p  --show-c-function
>               Show which C function each change is in.
> 
> Otherwise, it's a lot harder to figure out what you're modifying.

Okay; thanks. I wont go redoing all of the patches now, but are there
specific ones you'd like to see?

Regards,

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

You see, at just the right time, when we were still powerless, Christ
died for the ungodly.		-- Romans 5:6

