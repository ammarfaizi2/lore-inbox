Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310220AbSCEVSe>; Tue, 5 Mar 2002 16:18:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292891AbSCEVSW>; Tue, 5 Mar 2002 16:18:22 -0500
Received: from ithilien.qualcomm.com ([129.46.51.59]:40681 "EHLO
	ithilien.qualcomm.com") by vger.kernel.org with ESMTP
	id <S310240AbSCEVSC>; Tue, 5 Mar 2002 16:18:02 -0500
Message-Id: <5.1.0.14.2.20020305125056.01b5e1b8@mail1.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 05 Mar 2002 13:17:42 -0800
To: jt@hpl.hp.com
From: Maksim Krasnyanskiy <maxk@qualcomm.com>
Subject: Re: PPP feature request (Tx queue len + close)
Cc: Paul Mackerras <paulus@samba.org>, linux-ppp@vger.kernel.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20020305122343.A1094@bougret.hpl.hp.com>
In-Reply-To: <5.1.0.14.2.20020305112314.01c3cea8@mail1.qualcomm.com>
 <5.1.0.14.2.20020305095825.01b61fd8@mail1.qualcomm.com>
 <15492.21937.402798.688693@argo.ozlabs.ibm.com>
 <20020304144200.A32397@bougret.hpl.hp.com>
 <15492.13788.572953.6546@argo.ozlabs.ibm.com>
 <20020304191947.A32730@bougret.hpl.hp.com>
 <15492.21937.402798.688693@argo.ozlabs.ibm.com>
 <20020305094535.A792@bougret.hpl.hp.com>
 <5.1.0.14.2.20020305095825.01b61fd8@mail1.qualcomm.com>
 <20020305102835.B847@bougret.hpl.hp.com>
 <5.1.0.14.2.20020305112314.01c3cea8@mail1.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > effectively makes your window equal to 1 segment. In any case small PPP
> > queue won't make any good for you.
>
>         Nope. Remember that I have buffers below PPP. The transmit
>path within PPP and IrNET is minimal (no framing), so buffers in PPP
>and below PPP are logically equivalent.
True. PPP is a sort of "pass through" thing in your case.

> > I was under assumption that you know for sure that buffering is bad for 
> you :)
>
>         We are running circles. I want to reduce the amount of buffers
>below TCP. This includes PPP buffers and buffers below PPP (both are
>logically equivalent).
>         Both of you are saying "increase buffers at PPP level and
>reduce below TCP", but this doesn't make sense, and that's what I was
>pointing out. You have to think on the whole stack, not each
>individual component.
Yes. I see your point. It doesn't really make any difference which layer
buffers stuff (unless that layer introduces delays). So I guess in your case
you can just set txqueuelen to 1 if you're sure that underlying layer has long
enough queues.

> > All this depends on what you want to achieve. If you're looking for max TCP
> > performance. I'd recommend to use tcptrace and see what actually is 
> going on.
> > May be your RTT is to high and you need bigger windows or may be there is
> > something else.
>
>         I get 3.2 Mb/s TCP throughput over a 4Mb/s IrDA link layer, so
>I'm not concernet with max performance. My question is more "how much
>buffers can I trim without impacting performance". The goal is to
>improve latency and decrease ressource consumption.
I see.
Did you try ifconfig txqueuelen 1 ?

Max

