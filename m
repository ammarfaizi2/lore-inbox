Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262672AbSJBWGK>; Wed, 2 Oct 2002 18:06:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262673AbSJBWGK>; Wed, 2 Oct 2002 18:06:10 -0400
Received: from [195.223.140.120] ([195.223.140.120]:64578 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S262672AbSJBWGJ>; Wed, 2 Oct 2002 18:06:09 -0400
Date: Thu, 3 Oct 2002 00:12:04 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20pre8aa2
Message-ID: <20021002221204.GK1567@dualathlon.random>
References: <20021002071110.GC1158@dualathlon.random> <20021002214540.GA2589@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021002214540.GA2589@werewolf.able.es>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2002 at 11:45:40PM +0200, J.A. Magallon wrote:
> 
> On 2002.10.02 Andrea Arcangeli wrote:
> >URL:
> >
> >	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.20pre8aa2.gz
> >	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.20pre8aa2/
> >
> >Changelog between 2.4.20pre8aa1 and 2.4.20pre8aa2:
> >
> 
> I was rediffing the task_cpu patch, when reached a new hunk in -aa:
> 
> kernel/sched.c::sched_init(void):
> 
> +   current->cpu = smp_processor_id();
> 
> As include/asm-i386/smp.h says, 
> 
> #define smp_processor_id() (current->cpu)
> 
> So you have a harmless and useless assignment...
> unless you really wanted to do any other thing, or
> smp_processor_id() != current->cpu in some arch.

yes, it's a superflous line, it's the equivalent of the 2.5.40 line
here:

	rq->idle = current;
	set_task_cpu(current, smp_processor_id());
	^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
	wake_up_process(current);

it is a superflous bit in the o1 scheduler changes. If the boot cpu
isn't id 0 it must be initialized by the architectural code in arch/.
Either that or sched_init must use hard_smp_processor_id(). On most
archs the boot cpu is id 0 so it probably doesn't trigger if needed.

Andrea
