Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293644AbSCERp6>; Tue, 5 Mar 2002 12:45:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293643AbSCERpr>; Tue, 5 Mar 2002 12:45:47 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:15847 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S293638AbSCERph>;
	Tue, 5 Mar 2002 12:45:37 -0500
Date: Tue, 5 Mar 2002 09:45:35 -0800
To: Paul Mackerras <paulus@samba.org>
Cc: linux-ppp@vger.kernel.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: PPP feature request (Tx queue len + close)
Message-ID: <20020305094535.A792@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
In-Reply-To: <20020304144200.A32397@bougret.hpl.hp.com> <15492.13788.572953.6546@argo.ozlabs.ibm.com> <20020304191947.A32730@bougret.hpl.hp.com> <15492.21937.402798.688693@argo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15492.21937.402798.688693@argo.ozlabs.ibm.com>; from paulus@samba.org on Tue, Mar 05, 2002 at 04:20:49PM +1100
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2002 at 04:20:49PM +1100, Paul Mackerras wrote:
> Jean Tourrilhes writes:
> 
> >       IrTTP is another problem. If I were to use TCP instead of
> > IrTTP, would you still ask me to reduce the window size of TCP ? Let's
> 
> Yes, absolutely. :)  It just takes an ioctl to do that for TCP.

	Up to a certain point. If you reduce TCP to only one buffer, I
don't think it will work properly.
	I told you, the IrDA queues are totally under my control, so I
can fix them when I need, as opposed to PPP... What bugs me is that
each layer is having reasonably sized queues in itself, and that the
problem is just when we add those layers together...

> > 	I'm taking the approach that every little thing helps. There
> > is a trivial win in PPP, and I would be stupid to not exploit it.
> 
> Given that the default queue length is only 3 packets for PPP, it
> seems to me to be a very minor win.  I don't think we could reduce it
> below 1 packet, and I'm not sure whether that would have other
> negative consequences.  This is one reason why I asked if you had
> tried it.

	No, I didn't tried it because it was not obvious how to do it.

> It doesn't exist at the moment, but it would be easy enough to add
> it.  In the short term, you could even add an ifconfig to your
> /etc/ppp/ip-up script to set the transmit queue length there.

	Will try that.
	Actually, this is why I ask you in advance, so that we have
the time to think about it without rushing...

> > > Could you produce some numbers showing better throughput, fewer
> > > retransmissions, or whatever, with a smaller transmit queue length?
> > 
> > 	Don't have number, but I don't need number to know that.
> 
> Your case for wanting something done will be so much stronger if you
> show that there is a measurable benefit as opposed to just a gut
> feeling. :)

	Well, it's pretty obvious when watching tcpdump. You see all
the Tx clustered together and then nothing get Tx until the TCP window
opens again. In other word, you have a full TCP window queued in PPP
and IrDA.
	This is pretty bad for latency. Actually, you can verify that
by doing ping while a TCP connection is active, you will see huge
roundtrips.

> My gut feeling is that the transmit queue length is already about as
> short as we want it, and that if we make it any shorter then we will
> start dropping a lot of packets at the transmit queue, and lose
> performance because of that.  But I could be wrong - any networking
> gurus care to comment?

	I believe that you won't drop packet, but just flow control
TCP (which in turn will flow control the application). At least, this
is the way it's happening within the IrDA stack.

> Paul.

	Have fun...

	Jean
