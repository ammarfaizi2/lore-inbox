Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263870AbTKFXhE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 18:37:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263871AbTKFXhE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 18:37:04 -0500
Received: from fmr06.intel.com ([134.134.136.7]:32161 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S263870AbTKFXhB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 18:37:01 -0500
Subject: Re: [PATCH] SMP signal latency fix up.
From: Mark Gross <mgross@linux.co.intel.com>
Reply-To: mgross@linux.co.intel.com
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: mgross@linux.co.intel.com,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <3FAAD8AA.8060303@nortelnetworks.com>
References: <1068158989.3555.43.camel@localhost.localdomain>
	 <3FAAD8AA.8060303@nortelnetworks.com>
Content-Type: text/plain
Organization: TSP
Message-Id: <1068161721.3555.58.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 06 Nov 2003 15:35:21 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-11-06 at 15:26, Chris Friesen wrote:
> Mark Gross wrote:
> 
> > diff -urN -X dontdiff linux-2.6.0-test9/kernel/sched.c /opt/linux-2.6.0-test9/kernel/sched.c
> > --- linux-2.6.0-test9/kernel/sched.c    2003-10-25 11:44:29.000000000 -0700
> > +++ /opt/linux-2.6.0-test9/kernel/sched.c       2003-11-06 13:04:03.628116240 -0800
> > @@ -626,13 +626,13 @@
> >                         }
> >                         success = 1;
> >                 }
> > -#ifdef CONFIG_SMP
> > -               else
> > -                       if (unlikely(kick) && task_running(rq, p) && (task_cpu(p) != smp_processor_id()))
> > -                               smp_send_reschedule(task_cpu(p));
> > -#endif
> >                 p->state = TASK_RUNNING;
> >         }
> > +#ifdef CONFIG_SMP
> > +               else
> > +               if (unlikely(kick) && task_running(rq, p) && (task_cpu(p) != smp_processor_id()))
> > +                       smp_send_reschedule(task_cpu(p));
> > +#endif
> >         task_rq_unlock(rq, &flags);
> 
> Without any comment as to whether or not the patch would work, shouldn't 
> the "else" be moved back by a tab?
> 

You are correct.  
The source file used ot build the patch "looked" correct but had some
spaces where intermixed, that didn't show up until the tabs got expanded
by the cut and paste into the mailer.

I can re-send if you like, but I have a feeling Linux and Ingo are going
to work something slightly different out.  So I'll hold off.

Sorry about that.

--mgross


