Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311749AbSHWUrJ>; Fri, 23 Aug 2002 16:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311885AbSHWUrJ>; Fri, 23 Aug 2002 16:47:09 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:17541 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S311749AbSHWUrI>; Fri, 23 Aug 2002 16:47:08 -0400
Message-Id: <200208232051.g7NKp5608166@eng4.beaverton.ibm.com>
To: Bill Hartner <hartner@austin.ibm.com>
cc: Dave Hansen <haveblue@us.ibm.com>, Mala Anand <manand@us.ibm.com>,
       Benjamin LaHaise <bcrl@redhat.com>, Bill Hartner <bhartner@us.ibm.com>,
       davem@redhat.com, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] Re: (RFC): SKB Initialization 
In-reply-to: Your message of "Fri, 23 Aug 2002 15:12:40 CDT."
             <3D669737.67ED34AF@austin.ibm.com> 
Date: Fri, 23 Aug 2002 13:51:05 -0700
From: Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Read the 1st email.  There were 2.4 million samples.

    How many do you think is sufficient ?

I looked at my hand 2.4 million times and it was not wet each time.
Therefore, it is not raining.

Of course, if I am inside a roofed structure, the sampling is faulty.
And (correct me if I'm wrong here, Dave) I think that's what we're
asking about.  Are the samples you're getting pertinent and
significant?  If, as you suggested in another email, you disable
interrupts in the functions to take these measurements, you may be
significantly altering the very environment you hope to measure.

    Why do you think oprofile is a better way to measure this ?  BTW,
    Mala works with Troy Wilson who is running SPECweb99 on an 8-way
    system using Apache.  Troy has run with Mala's patch and that data
    will be posted.

That will be helpful.  Microbenchmarks which measure cycles are far
less interesting to the community than the end results of actual
workloads.  Note that Mala said "I measured the cycles for only the
initialization code in alloc_skb and __kfree_skb" which could mean that
even other parts of alloc_skb() or __kfree_skb() may have gotten worse
and you would not have known. Later she admits, "As the scope of the
code measured widens the percentage improvement comes down" and finally
observes "We measured it in a web serving workload and found that we
get 0.7% improvement"  which is practically in the noise.  Dave's
observation was that it was slightly worse (0.35%).  Either could be
statistical noise.  If the patch only creates statistical noise, the
community won't be interested.

Also, it is well known and widely recognized that more cpus add
increasing complexity with cache and code interactions.  Have you
tested this on an 8-way machine, rather than a 2-way, and do the
results still hold?  Things which look very good on 2-proc can start to
lose their lustre on 8-proc or bigger.

I'm unfamiliar with netperf -- does it yield "results" which can be
compared?  If so, since it was used to generate the load, how did the
results of the two runs compare?

Rick
