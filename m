Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318833AbSH1Nj3>; Wed, 28 Aug 2002 09:39:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318838AbSH1Nj3>; Wed, 28 Aug 2002 09:39:29 -0400
Received: from hq.fsmlabs.com ([209.155.42.197]:61869 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S318833AbSH1Nj0>;
	Wed, 28 Aug 2002 09:39:26 -0400
Date: Wed, 28 Aug 2002 07:41:48 -0600
From: yodaiken@fsmlabs.com
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: yodaiken@fsmlabs.com, Mark Hounschell <markh@compro.net>,
       "Wessler, Siegfried" <Siegfried.Wessler@de.hbm.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: interrupt latency
Message-ID: <20020828074148.B23738@hq.fsmlabs.com>
References: <20020827145631.B877@hq.fsmlabs.com> <Pine.LNX.3.95.1020828080308.14759A-101000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.3.95.1020828080308.14759A-101000@chaos.analogic.com>; from root@chaos.analogic.com on Wed, Aug 28, 2002 at 08:18:25AM -0400
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2002 at 08:18:25AM -0400, Richard B. Johnson wrote:
> On Tue, 27 Aug 2002 yodaiken@fsmlabs.com wrote:
> 
> > On Tue, Aug 27, 2002 at 04:44:34PM -0400, Richard B. Johnson wrote:
> > > On Tue, 27 Aug 2002 yodaiken@fsmlabs.com wrote:
> > > 
> 
> [SNIPPED...]B
> > 
> > You can do it in a tight loop. But you cannot do it otherwise.  RS232 works
> > because most UARTs have fifo buffers.  Old Windows did pretty well, because
> > you could grab the machine and let nothing else happen.
> > 
> > What makes me dubious about your claim is that it is easy to test
> > and see that a single ISA operation can take 18 microseconds
> > on most PC hardware.
> > 
> > try:
> > 	cli
> > 	loop:
> > 		read tsc
> > 		inb 
> > 		read tsc
> > 		compute difference
> > 		print worst case every 1000000 times.
> > 
> > 	sti
> > 
> > run for an hour on a busy machine.
> > 
> >
> 
> No, no, no. There is no such port read that takes 18 microseconds, even
> on old '386 machines with real ISR slots. A port read on those took

Sorry, but the numbers don't lie. It's an easy test to make.
The test you have below tests something else entirely. It tests
average time over a period of something around 1 second.


>     (void)alarm(1);
>     run++;
>     while(run)
>     {
>         foo[0] = inb(0x378);  /* Actually put into memory */
>         count++;              /* This takes as long as bumping a pointer */
>     }
>     printf("\nPort reads in a second = %lu\n", count);
>     return 0;
> }

Average and worst case are different.

