Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751057AbVHLG7Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751057AbVHLG7Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 02:59:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751151AbVHLG7Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 02:59:24 -0400
Received: from zproxy.gmail.com ([64.233.162.199]:19164 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751057AbVHLG7X convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 02:59:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jPAKBxvQxWygKzMrWqm0+95C9u0/C57gMxqEZgmNK/PdYMQDxhwuqwJ32xLxGbK8Y2vV9o1tJ43W9B3MvAV1hfz1NFVCoKNj33ZoPcBncQ3UoZiUw7dd1snPdghSupvlGeR8fCQrIAEC5QssfsBwf0DKno9OyAhdl0MK05ecpwk=
Message-ID: <86802c4405081123597239dff7@mail.gmail.com>
Date: Thu, 11 Aug 2005 23:59:21 -0700
From: yhlu <yhlu.kernel@gmail.com>
To: Andi Kleen <ak@suse.de>
Subject: Re: [discuss] Re: 2.6.13-rc2 with dual way dual core ck804 MB
Cc: Mike Waychison <mikew@google.com>, YhLu <YhLu@tyan.com>,
       Peter Buckingham <peter@pantasys.com>, linux-kernel@vger.kernel.org,
       "discuss@x86-64.org" <discuss@x86-64.org>
In-Reply-To: <20050811005100.GF8974@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <3174569B9743D511922F00A0C94314230AF97867@TYANWEB>
	 <42FA8A4B.4090408@google.com> <20050810232614.GC27628@wotan.suse.de>
	 <86802c4405081016421db9baa5@mail.gmail.com>
	 <20050811000430.GD8974@wotan.suse.de>
	 <86802c4405081017174c22dcd5@mail.gmail.com>
	 <86802c440508101723d4aadef@mail.gmail.com>
	 <20050811002841.GE8974@wotan.suse.de>
	 <86802c440508101743783588df@mail.gmail.com>
	 <20050811005100.GF8974@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

andi,

is it possible for
after the AP1 call_in is done and before AP1 get in tsc_sync_wait
The AP2 call_in done.  and then AP1 get in tsc_sync_wait and before it
done, AP2 get in tsc_sync_wait too.

sync_master can not figure out from AP1 or AP2 because only have
go[MASTER] and go{SLAVE].

YH

On 8/10/05, Andi Kleen <ak@suse.de> wrote:
> On Wed, Aug 10, 2005 at 05:43:23PM -0700, yhlu wrote:
> > Yes, I mean more aggressive
> >
> > static void __init smp_init(void)
> > {
> >         unsigned int i;
> >
> >         /* FIXME: This should be done in userspace --RR */
> >         for_each_present_cpu(i) {
> >                 if (num_online_cpus() >= max_cpus)
> >                         break;
> >                 if (!cpu_online(i))
> >                         cpu_up(i);
> >         }
> >
> >
> > let cpu_up take one array instead of one int.
> 
> It can be done already by just not starting the CPUs and
> then do it multithreaded from user space using sysfs with
> the CPU hotplug infrastructure. Unfortunately cpu_up
> right now has a global semaphore, so it won't save you any
> time. However it could be done in parallel with other
> startup jobs.
> 
> -Andi
>
