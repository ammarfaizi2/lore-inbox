Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932223AbVHWRKf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932223AbVHWRKf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 13:10:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932230AbVHWRKf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 13:10:35 -0400
Received: from web33309.mail.mud.yahoo.com ([68.142.206.124]:8636 "HELO
	web33309.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932223AbVHWRKe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 13:10:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=deMEbaig8a9mV8Sjtnf07Tas9MwQDV6P5t3GdPIaaejJVyWiB1uahobVAcVOTHEErN5M0dzSYA9DudWmEFnEPvf0qG+eaFnh6kFfZJ7AJhICkxxFzmyEONTy0AHmK6QZ8ExTNPtVCG++59c4ReAaOeHOvbj2QZYwcymOZhcwq6k=  ;
Message-ID: <20050823171028.47315.qmail@web33309.mail.mud.yahoo.com>
Date: Tue, 23 Aug 2005 10:10:28 -0700 (PDT)
From: Danial Thom <danial_thom@yahoo.com>
Reply-To: danial_thom@yahoo.com
Subject: Re: 2.6.12 Performance problems
To: Helge Hafting <helge.hafting@aitel.hist.no>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <430ACC5C.1060507@aitel.hist.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Helge Hafting <helge.hafting@aitel.hist.no>
wrote:

> Danial Thom wrote:
> 
> >--- Jesper Juhl <jesper.juhl@gmail.com> wrote:
> >
> >  
> >
> >>On 8/21/05, Danial Thom
> <danial_thom@yahoo.com>
> >>wrote:
> >>    
> >>
> >>>I just started fiddling with 2.6.12, and
> >>>      
> >>>
> >>there
> >>    
> >>
> >>>seems to be a big drop-off in performance
> >>>      
> >>>
> >>from
> >>    
> >>
> >>>2.4.x in terms of networking on a
> >>>      
> >>>
> >>uniprocessor
> >>    
> >>
> >>>system. Just bridging packets through the
> >>>machine, 2.6.12 starts dropping packets at
> >>>~100Kpps, whereas 2.4.x doesn't start
> >>>      
> >>>
> >>dropping
> >>    
> >>
> >>>until over 350Kpps on the same hardware
> >>>      
> >>>
> >>(2.0Ghz
> >>    
> >>
> >>>Opteron with e1000 driver). This is pitiful
> >>>prformance for this hardware. I've
> >>>increased the rx ring in the e1000 driver to
> >>>      
> >>>
> >>512
> >>    
> >>
> >>>with little change (interrupt moderation is
> >>>      
> >>>
> >>set
> >>    
> >>
> >>>to 8000 Ints/second). Has "tuning" for MP
> >>>destroyed UP performance altogether, or is
> >>>      
> >>>
> >>there
> >>    
> >>
> >>>some tuning parameter that could make a
> >>>      
> >>>
> >>4-fold
> >>    
> >>
> >>>difference? All debugging is off and there
> >>>      
> >>>
> >>are
> >>    
> >>
> >>>no messages on the console or in the error
> >>>      
> >>>
> >>logs.
> >>    
> >>
> >>>The kernel is the standard kernel.org
> dowload
> >>>config with SMP turned off and the intel
> >>>      
> >>>
> >>ethernet
> >>    
> >>
> >>>card drivers as modules without any other
> >>>changes, which is exactly the config for my
> >>>      
> >>>
> >>2.4
> >>    
> >>
> >>>kernels.
> >>>
> >>>      
> >>>
> >>If you have preemtion enabled you could
> disable
> >>it. Low latency comes
> >>at the cost of decreased throughput - can't
> >>have both. Also try using
> >>a HZ of 100 if you are currently using 1000,
> >>that should also improve
> >>throughput a little at the cost of slightly
> >>higher latencies.
> >>
> >>I doubt that it'll do any huge difference,
> but
> >>if it does, then that
> >>would probably be valuable info.
> >>
> >>    
> >>
> >Ok, well you'll have to explain this one:
> >
> >"Low latency comes at the cost of decreased
> >throughput - can't have both"
> >  
> >
> Configuring "preempt" gives lower latency,
> because then
> almost anything can be interrupted (preempted).
>  You can then
> get very quick responses to some things, i.e.
> interrupts and such.

I think part of the problem is the continued
misuse of the word "latency". Latency, in
language terms, means "unexplained delay". Its
wrong here because for one, its explainable. But
it also depends on your perspective. The
"latency" is increased for kernel tasks, while it
may be reduced for something that is getting the
benefit of preempting the kernel. So you really
can't say "the price of reduced latency is lower
throughput", because thats simply backwards.
You've increased the kernel tasks latency by
allowing it to be pre-empted. Reduced latency
implies higher efficiency. All you've done here
is shift the latency from one task to another, so
there is no reduction overall, in fact there is
probably a marginal increase due to the overhead
of pre-emption vs doing nothing.

DT



		
____________________________________________________
Start your day with Yahoo! - make it your home page 
http://www.yahoo.com/r/hs 
 
