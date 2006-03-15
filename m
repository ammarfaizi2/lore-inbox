Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752177AbWCOXlt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752177AbWCOXlt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 18:41:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752176AbWCOXls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 18:41:48 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:29623 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1752179AbWCOXls (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 18:41:48 -0500
Date: Thu, 16 Mar 2006 00:41:37 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Zachary Amsden <zach@vmware.com>
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: VMI Interface Proposal Documentation for I386, Part 5
Message-ID: <20060315234137.GF1919@elf.ucw.cz>
References: <4415CE76.9030006@vmware.com> <Pine.LNX.4.64.0603132328270.11606@montezuma.fsmlabs.com> <44167E03.3060807@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44167E03.3060807@vmware.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>   VMI_EnableInterrupts
> >>
> >>      VMICALL void VMI_EnableInterrupts(void);
> >>
> >>      Enable maskable interrupts on the processor.  Note that the
> >>      current implementation always will deliver any pending interrupts
> >>      on a call which enables interrupts, for compatibility with kernel
> >>      code which expects this behavior.  Whether this should be required
> >>      is open for debate.
> >>    
> >
> >Mind if i push this debate slightly forward? If we were to move the 
> >dispatch of pending interrupts elsewhere, where would that be? In 
> >particular, for a device which won't issue any more interrupts until it's 
> >previous interrupt is serviced. Perhaps injection at arbitrary points 
> >during runtime when interrupts are enabled?
> >  
> 
> Thanks for the response.
> 
> This is exactly what I was hoping for - discussion.  Think about this 
> from the hypervisor perspective - if the guest enables interrupts, and 
> you have something pending to deliver, for correctness, you have to 
> deliver it, right now.  But does the kernel truly require that interrupt 
> deliver immediately - in most cases, no.  In particular, on the fast 

I'd say PCI hardware can delay interrupts for any arbitrary
delay... so if driver expects to get them "immediately", I'd say it is
broken. It should be enough to deliver them "soon enough", like not
more than 1msec late...
								Pavel
-- 
29:
