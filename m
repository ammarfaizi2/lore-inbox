Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135422AbRDMGGV>; Fri, 13 Apr 2001 02:06:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135424AbRDMGGL>; Fri, 13 Apr 2001 02:06:11 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:39428 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S135422AbRDMGF7>;
	Fri, 13 Apr 2001 02:05:59 -0400
Message-ID: <3AD69D7F.36B2BA87@candelatech.com>
Date: Thu, 12 Apr 2001 23:32:31 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Bret Indrelee <bret@io.com>
CC: george anzinger <george@mvista.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        high-res-timers-discourse@lists.sourceforge.net
Subject: Re: No 100 HZ timer!
In-Reply-To: <Pine.LNX.4.21.0104122258060.7396-100000@fnord.io.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bret Indrelee wrote:
> 
> On Thu, 12 Apr 2001, george anzinger wrote:
> > Bret Indrelee wrote:
> > >
> > > On Thu, 12 Apr 2001, george anzinger wrote:
> > > > Bret Indrelee wrote:
> > > > > Keep all timers in a sorted double-linked list. Do the insert
> > > > > intelligently, adding it from the back or front of the list depending on
> > > > > where it is in relation to existing entries.
> > > >
> > > > I think this is too slow, especially for a busy system, but there are
> > > > solutions...
> > >
> > > It is better than the current solution.
> >
> > Uh, where are we talking about.  The current time list insert is real
> > close to O(1) and never more than O(5).
> 
> I don't like the cost of the cascades every (as I recall) 256
> interrupts. This is more work than is done in the rest of the interrupt
> processing, happens during the tick interrupt, and results in a rebuild of
> much of the table.
> 
> -Bret

Wouldn't a heap be a good data structure for a list of timers?  Insertion
is log(n) and finding the one with the least time is O(1), ie pop off the
front....  It can be implemented in an array which should help cache
coherency and all those other things they talked about in school :)

Ben
> 
> ------------------------------------------------------------------------------
> Bret Indrelee |  Sometimes, to be deep, we must act shallow!
> bret@io.com   |  -Riff in The Quatrix
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Ben Greear (greearb@candelatech.com)  http://www.candelatech.com
Author of ScryMUD:  scry.wanfear.com 4444        (Released under GPL)
http://scry.wanfear.com               http://scry.wanfear.com/~greear
