Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293089AbSCEFqH>; Tue, 5 Mar 2002 00:46:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293608AbSCEFp6>; Tue, 5 Mar 2002 00:45:58 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:45064 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S293089AbSCEFpo>;
	Tue, 5 Mar 2002 00:45:44 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15492.21937.402798.688693@argo.ozlabs.ibm.com>
Date: Tue, 5 Mar 2002 16:20:49 +1100 (EST)
To: jt@hpl.hp.com
Cc: linux-ppp@vger.kernel.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: PPP feature request (Tx queue len + close)
In-Reply-To: <20020304191947.A32730@bougret.hpl.hp.com>
In-Reply-To: <20020304144200.A32397@bougret.hpl.hp.com>
	<15492.13788.572953.6546@argo.ozlabs.ibm.com>
	<20020304191947.A32730@bougret.hpl.hp.com>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Tourrilhes writes:

> 	IrTTP is another problem. If I were to use TCP instead of
> IrTTP, would you still ask me to reduce the window size of TCP ? Let's

Yes, absolutely. :)  It just takes an ioctl to do that for TCP.

> try to be fair...
> 	I'm taking the approach that every little thing helps. There
> is a trivial win in PPP, and I would be stupid to not exploit it.

Given that the default queue length is only 3 packets for PPP, it
seems to me to be a very minor win.  I don't think we could reduce it
below 1 packet, and I'm not sure whether that would have other
negative consequences.  This is one reason why I asked if you had
tried it.

> 	I must have missed this option. I'll look again in the pppd
> man page. That may be good enough...

It doesn't exist at the moment, but it would be easy enough to add
it.  In the short term, you could even add an ifconfig to your
/etc/ppp/ip-up script to set the transmit queue length there.

> > Could you produce some numbers showing better throughput, fewer
> > retransmissions, or whatever, with a smaller transmit queue length?
> 
> 	Don't have number, but I don't need number to know that.

Your case for wanting something done will be so much stronger if you
show that there is a measurable benefit as opposed to just a gut
feeling. :)

My gut feeling is that the transmit queue length is already about as
short as we want it, and that if we make it any shorter then we will
start dropping a lot of packets at the transmit queue, and lose
performance because of that.  But I could be wrong - any networking
gurus care to comment?

Paul.
