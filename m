Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288781AbSAIRL0>; Wed, 9 Jan 2002 12:11:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288828AbSAIRLV>; Wed, 9 Jan 2002 12:11:21 -0500
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:11970 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S288781AbSAIRLH>; Wed, 9 Jan 2002 12:11:07 -0500
Date: Wed, 9 Jan 2002 12:10:59 -0500
From: Arjan van de Ven <arjanv@redhat.com>
To: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
Cc: arjanv@redhat.com, Andrea Arcangeli <andrea@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-ID: <20020109121059.A15002@devserv.devel.redhat.com>
In-Reply-To: <000a01c19917$0b567ec0$0501a8c0@psuedogod> <20020109152717.J1543@inspiron.school.suse.de> <3C3C58E0.EB1333F0@redhat.com> <200201091705.g09H5YQ25146@maila.telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200201091705.g09H5YQ25146@maila.telia.com>; from roger.larsson@skelleftea.mail.telia.com on Wed, Jan 09, 2002 at 06:02:53PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2002 at 06:02:53PM +0100, Roger Larsson wrote:
> The difference is that the preemptive kernel mostly uses existing 
> infrastructure. When SMP scalability gets better due to holding locks
> for a shorter time then the preemptive kernel will improve as well!

Ehm. Holding locks for a shorter time is not guaranteed to improve smp
scalability. In fact it can completely kill it due to cacheline pingpong
effects.

> > and if with 40 we can get <= 1ms then everybody will be happy; if you
> > want, say, 50 usec
> > latency instead you need RTLinux anyway. With 1ms _worst case_ latency
> > the "mean" latency
> > is obviously also very good.......
> 
> Worst case latency... is VERY hard to prove if you rely on schedule points.

Agreed. It's "worst case" in the soft real time sence. But we've beaten the
kernel quite hard during such tests....

> With preemptive kernel your worst latency is the longest held spinlock. 
> PERIOD.

Yes and without the same stuff akpm does that's about 80 to 90 ms right now. 

> Note: that akpm patches usually hava a - "do not do this list" with known
> problem spots (ok, usually in a hard to break spinlocks).

Usually in hardware related parts. Even with -preempt you'll get this.
Hopefully only during hardware initialisation, but there are just cases
where you need to go WAAAY too far if you want to go below, say, 5ms during
device init.


