Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965461AbWI0JPX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965461AbWI0JPX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 05:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965463AbWI0JPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 05:15:23 -0400
Received: from adsl-69-232-92-238.dsl.sndg02.pacbell.net ([69.232.92.238]:59288
	"EHLO gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id S965461AbWI0JPV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 05:15:21 -0400
Date: Wed, 27 Sep 2006 02:14:56 -0700
To: Ingo Molnar <mingo@elte.hu>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>, John Stultz <johnstul@us.ibm.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       "Bill Huey (hui)" <billh@gnuppy.monkey.org>
Subject: Re: [PATCH] move put_task_struct() reaping into a thread [Re: 2.6.18-rt1]
Message-ID: <20060927091456.GB17136@gnuppy.monkey.org>
References: <20060920141907.GA30765@elte.hu> <20060921065624.GA9841@gnuppy.monkey.org> <m1irjaqaqa.fsf@ebiederm.dsl.xmission.com> <20060927050856.GA16140@gnuppy.monkey.org> <20060927085712.GA16938@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060927085712.GA16938@elte.hu>
User-Agent: Mutt/1.5.13 (2006-08-11)
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2006 at 10:57:12AM +0200, Ingo Molnar wrote:
> * Bill Huey <billh@gnuppy.monkey.org> wrote:
> 
> > Because the conversion of memory allocation routines like kmalloc and 
> > kfree aren't safely callable within a preempt_disable critical section 
> > since they were incompletely converted in the -rt. [...]
> 
> they were not 'incompletely converted' - they are /intentionally/ fully 
> preemptible.

What I meant by "incompletely converted" is that the allocators could be
made more safe in non-preemptible scenarios under -rt. It's potentially
a valuable thing to have since GFP_ATOMIC semantics already exist in the
current allocators and a newer category could be added as a new feature of
that allocator for those scenarios. I'm happy dequeuing things off of my
own free list, but that's just me.

-rt semanatics created a couple of new locking scenarios that the previous
kernel didn't really have to address. That's all that I meant by that. :)

bill

