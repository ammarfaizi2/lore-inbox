Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316664AbSFUPbt>; Fri, 21 Jun 2002 11:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316672AbSFUPbs>; Fri, 21 Jun 2002 11:31:48 -0400
Received: from host194.steeleye.com ([216.33.1.194]:6151 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S316667AbSFUPbr>; Fri, 21 Jun 2002 11:31:47 -0400
Message-Id: <200206211531.g5LFViZ07396@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Rusty Russell <rusty@rustcorp.com.au>
cc: James Bottomley <James.Bottomley@SteelEye.com>,
       linux-kernel@vger.kernel.org, mingo@redhat.com
Subject: Re: Optimisation for smp_num_cpus loop in hotplug 
In-Reply-To: Message from Rusty Russell <rusty@rustcorp.com.au> 
   of "Sat, 22 Jun 2002 01:14:46 +1000." <E17LQ7b-0000Iz-00@wagner.rustcorp.com.au> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 21 Jun 2002 11:31:44 -0400
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rusty@rustcorp.com.au said:
> Yeah, it's simple, and none of the current ones are really critical.
> But I think we're better off with:
> 	for (i = first_cpu(); i < NR_CPUS; i = next_cpu(i)) {

> Which is simple enough not to need an iterator macro, and also has the
> bonus of giving irq-balancing et al. an efficient, portable way of
> looking for the "next" cpu. 

So you're thinking that next_cpu(i) is something like

__ffs((~(unsigned)((1<<i)-1) & cpu_online_map)

plus an extra exception piece to take next_cpu(i) above NR_CPUS if we have no 
remaining CPUs (because __ffs would be undefined)?  It's the exception piece 
that I don't see how to do really efficiently.

James


