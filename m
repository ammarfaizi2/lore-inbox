Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276309AbRJPN4Q>; Tue, 16 Oct 2001 09:56:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276329AbRJPN4H>; Tue, 16 Oct 2001 09:56:07 -0400
Received: from inway98.cdi.cz ([213.151.81.98]:48115 "EHLO luxik.cdi.cz")
	by vger.kernel.org with ESMTP id <S276309AbRJPNzx>;
	Tue, 16 Oct 2001 09:55:53 -0400
Posted-Date: Tue, 16 Oct 2001 15:56:11 +0200
Date: Tue, 16 Oct 2001 15:56:11 +0200 (CEST)
From: Martin Devera <devik@cdi.cz>
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: sendto syscall is slow
In-Reply-To: <3BCC2F60.1753212@evision-ventures.com>
Message-ID: <Pine.LNX.4.10.10110161551340.13894-100000@luxik.cdi.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > i'm doing new qos discipline developement and use own
> > mesurment tool. It simply uses PF_PACKET and then
> > doing sendto/recv simulating various flows.
> > (I use both lo and eth0 where I short-connected RX-TX
> >  pins in single ethcard)
> > 
> > I can't get beyond 25 000 packets per second. gprof:
> > Each sample counts as 0.01 seconds.
> >   %   cumulative   self              self     total
> >  time   seconds   seconds    calls  ms/call  ms/call  name
> >  35.67      5.39     5.39   498750     0.01     0.01  sendto
> >  26.67      9.42     4.03  1000826     0.00     0.00  poll
> >  19.06     12.30     2.88   498750     0.01     0.01  recv
> >[snip] 
> 
> Increase the HZ constant in the kernel, which is determining the
> sceduler frequency, which is apparently due to BH handling acting
> as a low-pass filder for your siganls here. However please
> beware of many possible sideffects this may have on your system.

I did. The no of packets decreased:
 37.40      6.63     6.63   439050     0.02     0.02  sendto
 25.66     11.19     4.55   881028     0.01     0.01  poll
 20.19     14.77     3.58   439050     0.01     0.01  recv

Not it is about 23 000/sec probably due to higher system overhead.
I don't think it could affect this case because recieve queue is
drained from softirq which is run when syscall returns to userspace.
So that is should not be bound to scheculer timing (as I both send
and recieve from single process).

Martin

