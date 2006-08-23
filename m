Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932409AbWHWIUd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932409AbWHWIUd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 04:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932410AbWHWITh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 04:19:37 -0400
Received: from ns.suse.de ([195.135.220.2]:60342 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932409AbWHWITE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 04:19:04 -0400
From: Andi Kleen <ak@suse.de>
To: Zachary Amsden <zach@vmware.com>
Subject: Re: [PATCH] paravirt.h
Date: Wed, 23 Aug 2006 10:18:12 +0200
User-Agent: KMail/1.9.3
Cc: Arjan van de Ven <arjan@infradead.org>, virtualization@lists.osdl.org,
       Jeremy Fitzhardinge <jeremy@goop.org>, Andrew Morton <akpm@osdl.org>,
       Chris Wright <chrisw@sous-sol.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1155202505.18420.5.camel@localhost.localdomain> <p73y7tg7cg7.fsf@verdi.suse.de> <44EB7F0C.60402@vmware.com>
In-Reply-To: <44EB7F0C.60402@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608231018.12571.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> Well, I don't think anything is sufficient for a preemptible kernel.  I 
> think that's just plain not going to work.  You could have a kernel 
> thread that got preempted in a paravirt-op patch point, and making all 
> the patch points non-preempt is probably a non-starter (either +12 bytes 
> each or no native inlining). 

stop machine deals with preemption.  If it didn't it would be unusable
for the purposes the kernel uses it right now (cpu hotplug, module unloading etc.)

> stop_machine_run() is almost what I want, but even that is not 
> sufficient.  You also need to disable NMIs and debug traps

and machine checks. debug traps -- i assume you mean kernel debuggers -- 
sounds like something that cannot be really controlled though.

How do you control a debugger from the debugee?

I don't think NMI/MCEs are a problem though because NMIs (at least oprofile/nmi watchdog) 
and MCEs all just have global state that can be changed on a single CPU.

> , which is  
> pretty hairy, but doable.  The problem with stop_machine_run() is that I 
> don't just want the kernel to halt running on remote CPUs, I want the 
> kernel on all CPUs to actually do something simultaneously - the entry 
> into paravirt mode requires a hypervisor call on each CPU, and 
> stop_machine() doesn't provide a facility to fire a callback on each CPU 
> from the stopmachine state.

Ok.

-Andi

