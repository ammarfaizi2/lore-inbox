Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261872AbULUXHh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261872AbULUXHh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 18:07:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261890AbULUXHh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 18:07:37 -0500
Received: from web52604.mail.yahoo.com ([206.190.39.142]:29118 "HELO
	web52604.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261872AbULUXH0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 18:07:26 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=C0Ch/NlnwvOI67N8OlKkKLC4x16/dJ+WKaZY+x/2pRMQprFydtmcb9LFkMaORn0c3dQxMm7O9J7M09ulDOhb84EFMh7cX2cT9/jQosxj8Gtbv8owcV5tYT81WM/F3nm0re7HHURU37uGhkVZv1J4bWl3dT0khPPvVPRIK7tsCHc=  ;
Message-ID: <20041221230726.51621.qmail@web52604.mail.yahoo.com>
Date: Tue, 21 Dec 2004 15:07:26 -0800 (PST)
From: jesse <jessezx@yahoo.com>
Subject: Re: Gurus, a silly question for preemptive behavior
To: Con Kolivas <kernel@kolivas.org>
Cc: Paulo Marques <pmarques@grupopie.com>, linux-kernel@vger.kernel.org
In-Reply-To: <41C89734.8020302@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Con Kolivas <kernel@kolivas.org> wrote:

> jesse wrote:
> > Paulo:
> >  
> >    I already said in the messsage that my user
> space
> > application has a low nice priority, i set it to
> 10.
> > since my application has low priority compared to
> > other user space applications, it is supposed to
> be
> > interrupted. but it is not.
> 
> If your task is better priority the scheduler will
> make it preempt the 
> worse priority task. It sounds to me like you are
> complaining that the 
> worse priority task is still getting cpu? If so, you
> misunderstand 
> priority - it orders tasks according to priority
> giving lower latency 
> and preemptive behaviour to the better task, and
> gives _more_ cpu but 
> not all the cpu. The cpu must still be shared, but
> with more cpu 
> distributed to the better priority task. If you want
> your better 
> priority task to get _all_ the cpu you have to use
> real time scheduling.
> 
> Cheers,
> Con
> 

ok, Con, your explaining makes some sense to me , but
still not very well.

   suppose I have five high process: A1, A2, A3, A4,
A5 all have nice = 0. and I also have a low priority
process B with nice = 10.

    a) when process B is scheduled to run, it is given
a short time slot based on its priority, for example 5
secs. because at that point, A1/2/3/4/5 are not
started yet. B will get CPU and run at full speed. 
    b) at the end of time slot(5 secs), scheduler
finds higher priority A1/A2/A3/A4/A5 are ready,
scheduler will interrupt process B and starts to pick 
a process from group A, even though B still needs CPU
cycle.
    c)unfortunately, process A1/2/3/4/5 are so active,
thus process B should never get opportunity to run
again, in consequence, CPU Usage% of Process B should
be very Low.
    
   However, The above theretic assumption is in
contrary to what i observed. in my LAB, the low
priority process B seems to hold the CPU forever and
Top command always shows Process B with a 90% CPU
usage.
  
  If _more_ cpu but not _all_ the cpu are given to
Process A1/2/3/4/5, Process B shouldn't have a 90% CPU
usage.   

  Thus, i can't help asking why low priority process B
gets most CPU cycle.

  thanks in advance. 

jesse

 

