Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135441AbRDMInx>; Fri, 13 Apr 2001 04:43:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135446AbRDMInn>; Fri, 13 Apr 2001 04:43:43 -0400
Received: from mailgw.prontomail.com ([216.163.180.10]:56538 "EHLO
	c0mailgw04.prontomail.com") by vger.kernel.org with ESMTP
	id <S135441AbRDMInb>; Fri, 13 Apr 2001 04:43:31 -0400
Message-ID: <3AD6BBDD.D5BA23EE@mvista.com>
Date: Fri, 13 Apr 2001 01:42:05 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ben Greear <greearb@candelatech.com>
CC: Bret Indrelee <bret@io.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        high-res-timers-discourse@lists.sourceforge.net
Subject: Re: No 100 HZ timer!
In-Reply-To: <Pine.LNX.4.21.0104122258060.7396-100000@fnord.io.com> <3AD69D7F.36B2BA87@candelatech.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Greear wrote:
> 
> Bret Indrelee wrote:
> >
> > On Thu, 12 Apr 2001, george anzinger wrote:
> > > Bret Indrelee wrote:
> > > >
> > > > On Thu, 12 Apr 2001, george anzinger wrote:
> > > > > Bret Indrelee wrote:
> > > > > > Keep all timers in a sorted double-linked list. Do the insert
> > > > > > intelligently, adding it from the back or front of the list depending on
> > > > > > where it is in relation to existing entries.
> > > > >
> > > > > I think this is too slow, especially for a busy system, but there are
> > > > > solutions...
> > > >
> > > > It is better than the current solution.
> > >
> > > Uh, where are we talking about.  The current time list insert is real
> > > close to O(1) and never more than O(5).
> >
> > I don't like the cost of the cascades every (as I recall) 256
> > interrupts. This is more work than is done in the rest of the interrupt
> > processing, happens during the tick interrupt, and results in a rebuild of
> > much of the table.

Right, it needs to go, we need to eliminate the "lumps" in time :)
> >
> > -Bret
> 
> Wouldn't a heap be a good data structure for a list of timers?  Insertion
> is log(n) and finding the one with the least time is O(1), ie pop off the
> front....  It can be implemented in an array which should help cache
> coherency and all those other things they talked about in school :)
> 
I must be missing something here.  You get log(n) from what?  B-trees? 
How would you manage them to get the needed balance?  Stopping the world
to re-balance is worse than the cascade.  I guess I need to read up on
this stuff.  A good pointer would be much appreciated. 

Meanwhile, I keep thinking of a simple doubly linked list in time
order.  To speed it up keep an array of pointers to the first N whole
jiffie points and maybe pointers to coarser points beyond the first N. 
Make N, say 512.  Build the pointers as needed.  This should give
something like O(n/N) insertion and O(1) removal.

George
