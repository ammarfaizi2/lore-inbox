Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318793AbSG1GJq>; Sun, 28 Jul 2002 02:09:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318911AbSG1GJq>; Sun, 28 Jul 2002 02:09:46 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:32576 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S318793AbSG1GJp>; Sun, 28 Jul 2002 02:09:45 -0400
Date: Sun, 28 Jul 2002 02:13:05 -0400
From: Doug Ledford <dledford@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@transmeta.com>,
       Greg KH <greg@kroah.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: i810_audio.c cli/sti fix
Message-ID: <20020728021305.A11402@redhat.com>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Ingo Molnar <mingo@elte.hu>,
	Linus Torvalds <torvalds@transmeta.com>, Greg KH <greg@kroah.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0207271103180.2606-100000@localhost.localdomain> <1027773342.17404.0.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1027773342.17404.0.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Sat, Jul 27, 2002 at 01:35:42PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 27, 2002 at 01:35:42PM +0100, Alan Cox wrote:
> On Sat, 2002-07-27 at 10:10, Ingo Molnar wrote:
> > how about a disable_irq_all() and enable_irq_all() call, which would
> > disable every single interrupt source in the system? Sure it's a bit
> > heavyweight (it disables the timer interrupt too), but if some driver
> > **really** needs complete silence in the IRQ system then it might be
> > useful. It would roughly be equivalent to cli() and sti(), from the
> > hardirq disabling point of view. [it would not disable bottom halves.]
> 
> For the precision needed I think a local irq disable and the lock the
> driver needs itself are sufficient, and the lock _irqsave will handle
> the IRQ bits

Well, to my belief the irq_all() stuff is overkill as Alan points out.  
However, Alan also implies that during the init stage we should be holding 
the card lock and using that to disable interrupts.  I disagree with that 
since we may already have other entry points looking at our card and we 
don't want the card lock held until after it has been initted and is ready 
for real use. So, I would leave it just like the patch to fix up the sti 
usage left it.

-- 
  Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
         Red Hat, Inc. 
         1801 Varsity Dr.
         Raleigh, NC 27606
  
