Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261183AbUBZWhj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 17:37:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261200AbUBZWhi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 17:37:38 -0500
Received: from fmr06.intel.com ([134.134.136.7]:20399 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S261207AbUBZWem (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 17:34:42 -0500
From: Mark Gross <mgross@linux.co.intel.com>
Organization: Intel
To: arjanv@redhat.com, Tim Bird <tim.bird@am.sony.com>
Subject: Re: Why no interrupt priorities?
Date: Thu, 26 Feb 2004 14:21:34 -0800
User-Agent: KMail/1.5.4
Cc: root@chaos.analogic.com, linux kernel <linux-kernel@vger.kernel.org>
References: <403E4363.2070908@am.sony.com> <403E5EF7.7080309@am.sony.com> <1077831001.4443.9.camel@laptop.fenrus.com>
In-Reply-To: <1077831001.4443.9.camel@laptop.fenrus.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402261421.34885.mgross@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 26 February 2004 13:30, Arjan van de Ven wrote:
> On Thu, 2004-02-26 at 22:02, Tim Bird wrote:
> > Richard B. Johnson wrote:
> > > On Thu, 26 Feb 2004, Tim Bird wrote:
> > >>What's the rationale for not supporting interrupt priorities
> > >>in the kernel?
> > >
> > > Interrupt priorities are supported and have been supported
> > > since the first cascaded interrupt controllers and, now
> > > with the APIC.
> >
> > Please forgive my ignorance.  I'm not sure what's going
> > on with 2.6 and work queues, but do the hardware priorities
> > allow you to control scheduling of interrupt bottom halves?
>
> hardware IRQ priorities are useless for the linux model. In linux, the
> hardirq runs *very* briefly and then lets the softirq context do the
> longer taking work. hardware irq priorities then don't matter really
> because the hardirq's are hardly ever interrupted really, and when they
> are they cause a performance *loss* due to cache trashing. The latency
> added by waiting briefly is going to be really really short for any sane
> hardware.

Keep in mind the context is Linux running on non-sane hardware, sloooow CPUs, 
latency sensitive small io buffers etc. Losing system wide throughput to have 
the hardware codec not be starved is a happy trade off to make.

So far all the comments are very PC centric. I suspect the history of the no 
interrupt priorities goes back a lot of years.  Perhaps the answer is that it 
never seemed to help having priorities much on PC hardware so lets not deal 
with the complexity in the software.

Any more historical insights?
I wonder how hard it would be add for embedded types of 
applications/architectures?

--mgross

>
> Now doing priorities in softirq context... well... here again it's a
> case of a tiny latency hit vs a lot of cache trashing. If your softirq
> handler runs in 10 cachemisses (it's useless to talk about cpu cycles
> since most of teh time you'll be cache bound) that's not too long
> latency, but if you interrupt it it might get 15 or more cachemisses
> instead. That again will increase the delay the user context gets from
> irq's.... so from a userspace pov you actually increased irq latency....

