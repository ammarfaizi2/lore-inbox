Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293551AbSCEDHV>; Mon, 4 Mar 2002 22:07:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293550AbSCEDHM>; Mon, 4 Mar 2002 22:07:12 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:53770 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S293514AbSCEDGy>;
	Mon, 4 Mar 2002 22:06:54 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15492.13788.572953.6546@argo.ozlabs.ibm.com>
Date: Tue, 5 Mar 2002 14:05:00 +1100 (EST)
To: jt@hpl.hp.com
Cc: linux-ppp@vger.kernel.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: PPP feature request (Tx queue len + close)
In-Reply-To: <20020304144200.A32397@bougret.hpl.hp.com>
In-Reply-To: <20020304144200.A32397@bougret.hpl.hp.com>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Tourrilhes writes:

> 	Problem : IrDA does its buffering (IrTTP is a sliding window
> protocol). PPP does its buffering (1 packet in ppp_generic +
> dev->tx_queue_len = 3). End result : a large number of packets queued
> for transmissions, which result in some network performance issues.

How much buffering does IrTTP do?  How large is its window?  It is
much more critical IMO to reduce the buffering below ppp_generic than
it is to reduce the buffering above it.  The ppp_generic layer itself
does as little buffering as possible.

> 	Solution : could we allow the PPP channel to overwrite
> dev->tx_queue_len ?
> 	This is similar to the channel beeing able to set the MTUs and
> other parameters...

Not really, the channel can't set the bundle MTU, only its own MTU.
It can set the header length (the desired amount of headroom) but that
is really only an optimization.

What would happen in the case where two channels connected to the
same ppp unit want to set the queue length to two different values?

In general I think it would be better to get pppd to set the transmit
queue length than to have the channel magically influencing stuff two
levels above it.

Could you produce some numbers showing better throughput, fewer
retransmissions, or whatever, with a smaller transmit queue length?

Paul.
