Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310191AbSCEUYK>; Tue, 5 Mar 2002 15:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310190AbSCEUYC>; Tue, 5 Mar 2002 15:24:02 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:63713 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S310185AbSCEUXs>;
	Tue, 5 Mar 2002 15:23:48 -0500
Date: Tue, 5 Mar 2002 12:23:43 -0800
To: Maksim Krasnyanskiy <maxk@qualcomm.com>
Cc: Paul Mackerras <paulus@samba.org>, linux-ppp@vger.kernel.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: PPP feature request (Tx queue len + close)
Message-ID: <20020305122343.A1094@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
In-Reply-To: <5.1.0.14.2.20020305095825.01b61fd8@mail1.qualcomm.com> <15492.21937.402798.688693@argo.ozlabs.ibm.com> <20020304144200.A32397@bougret.hpl.hp.com> <15492.13788.572953.6546@argo.ozlabs.ibm.com> <20020304191947.A32730@bougret.hpl.hp.com> <15492.21937.402798.688693@argo.ozlabs.ibm.com> <20020305094535.A792@bougret.hpl.hp.com> <5.1.0.14.2.20020305095825.01b61fd8@mail1.qualcomm.com> <20020305102835.B847@bougret.hpl.hp.com> <5.1.0.14.2.20020305112314.01c3cea8@mail1.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <5.1.0.14.2.20020305112314.01c3cea8@mail1.qualcomm.com>; from maxk@qualcomm.com on Tue, Mar 05, 2002 at 11:39:59AM -0800
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2002 at 11:39:59AM -0800, Maksim Krasnyanskiy wrote:
> 
> I looked at the code again and tried to trace TCP xmit path. Seems like it 
> should not
> back off because it does check return status of the dev_queue_xmit (send 
> packet to the driver).

	Ok. That sounds much more logical than the first explanation.

> But it does not seem to retry either. Looks like it's just waits for an ack 
> from the other side which

	Ok. The mysteries of TCP/IP implementation.

> effectively makes your window equal to 1 segment. In any case small PPP 
> queue won't make any
> good for you.

	Nope. Remember that I have buffers below PPP. The transmit
path within PPP and IrNET is minimal (no framing), so buffers in PPP
and below PPP are logically equivalent.

> >         If what you say is true, I should *increase* the buffering
> >below PPP to make sure that packet don't get dropped above PPP.
> I was under assumption that you know for sure that buffering is bad for you :)

	We are running circles. I want to reduce the amount of buffers
below TCP. This includes PPP buffers and buffers below PPP (both are
logically equivalent).
	Both of you are saying "increase buffers at PPP level and
reduce below TCP", but this doesn't make sense, and that's what I was
pointing out. You have to think on the whole stack, not each
individual component.

> >         Think about it : for TCP, it doesn't matter if buffers are
> >above or below PPP, what matter is only how many there are. TCP can't
> >make the difference between buffers at the PPP and at IrDA level.
> >         Actually, it's probably better to keep the buffers as low as
> >possible in the stack, because less processing remain to be done on
> >them before beeing transmitted.
>
> All this depends on what you want to achieve. If you're looking for max TCP
> performance. I'd recommend to use tcptrace and see what actually is going on.
> May be your RTT is to high and you need bigger windows or may be there is
> something else.

	I get 3.2 Mb/s TCP throughput over a 4Mb/s IrDA link layer, so
I'm not concernet with max performance. My question is more "how much
buffers can I trim without impacting performance". The goal is to
improve latency and decrease ressource consumption.

> Max

	Regards,

	Jean
