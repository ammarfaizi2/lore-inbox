Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293562AbSCEDUy>; Mon, 4 Mar 2002 22:20:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293556AbSCEDUq>; Mon, 4 Mar 2002 22:20:46 -0500
Received: from phobos.hpl.hp.com ([192.6.19.124]:23264 "EHLO phobos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S293559AbSCEDUh>;
	Mon, 4 Mar 2002 22:20:37 -0500
Date: Mon, 4 Mar 2002 19:19:47 -0800
To: Paul Mackerras <paulus@samba.org>
Cc: jt@hpl.hp.com, linux-ppp@vger.kernel.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: PPP feature request (Tx queue len + close)
Message-ID: <20020304191947.A32730@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
In-Reply-To: <20020304144200.A32397@bougret.hpl.hp.com> <15492.13788.572953.6546@argo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15492.13788.572953.6546@argo.ozlabs.ibm.com>; from paulus@samba.org on Tue, Mar 05, 2002 at 02:05:00PM +1100
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2002 at 02:05:00PM +1100, Paul Mackerras wrote:
> Jean Tourrilhes writes:
> 
> > 	Problem : IrDA does its buffering (IrTTP is a sliding window
> > protocol). PPP does its buffering (1 packet in ppp_generic +
> > dev->tx_queue_len = 3). End result : a large number of packets queued
> > for transmissions, which result in some network performance issues.
> 
> How much buffering does IrTTP do?  How large is its window?  It is
> much more critical IMO to reduce the buffering below ppp_generic than
> it is to reduce the buffering above it.  The ppp_generic layer itself
> does as little buffering as possible.

	IrTTP is another problem. If I were to use TCP instead of
IrTTP, would you still ask me to reduce the window size of TCP ? Let's
try to be fair...
	I'm taking the approach that every little thing helps. There
is a trivial win in PPP, and I would be stupid to not exploit it.
	On the other hand, you are right that with IrTTP. I was
spending the day investigating this issue. As usual with Linux-IrDA,
it's very messy. I think I will need some architecture change to
implement proper flow control between IrLAP and IrTTP. And then
qualify that with all IrTTP users :-(

> > 	Solution : could we allow the PPP channel to overwrite
> > dev->tx_queue_len ?
> > 	This is similar to the channel beeing able to set the MTUs and
> > other parameters...
> 
> Not really, the channel can't set the bundle MTU, only its own MTU.
> It can set the header length (the desired amount of headroom) but that
> is really only an optimization.
> 
> What would happen in the case where two channels connected to the
> same ppp unit want to set the queue length to two different values?

	No idea, never had this case ;-) This is exactly for this
reason I ask you.

> In general I think it would be better to get pppd to set the transmit
> queue length than to have the channel magically influencing stuff two
> levels above it.

	I must have missed this option. I'll look again in the pppd
man page. That may be good enough...
	For stuff influencing level above, just think of
ap->chan.hdrlen. In my case, it goes from IrLAP to TCP via IrLMP,
IrTTP, IrNET, PPP and IP.

> Could you produce some numbers showing better throughput, fewer
> retransmissions, or whatever, with a smaller transmit queue length?

	Don't have number, but I don't need number to know that.

> Paul.

	Jean
