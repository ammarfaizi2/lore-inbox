Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263026AbTHVFI4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 01:08:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263022AbTHVFIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 01:08:55 -0400
Received: from pop.gmx.net ([213.165.64.20]:56030 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263029AbTHVFHT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 01:07:19 -0400
Message-Id: <5.2.1.1.2.20030822065336.019d58b8@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Fri, 22 Aug 2003 07:11:26 +0200
To: Con Kolivas <kernel@kolivas.org>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH] O17int
Cc: Voluspa <lista1@comhem.se>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <1061510363.3f455cdb079d4@kolivas.org>
References: <5.2.1.1.2.20030821154224.01990b48@pop.gmx.net>
 <5.2.1.1.2.20030821090657.00b45af8@pop.gmx.net>
 <200308210723.42789.kernel@kolivas.org>
 <5.2.1.1.2.20030821090657.00b45af8@pop.gmx.net>
 <5.2.1.1.2.20030821154224.01990b48@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 09:59 AM 8/22/2003 +1000, Con Kolivas wrote:
>Quoting Mike Galbraith <efault@gmx.de>:
>
> > > > The most generally effective form of the "down-shift" anti-starvation
> > > > tactic that I've tried, is to periodically check the head of all queues
> > > > below current position (can do very quickly), and actively select the
> > > > oldest task who hasn't run since some defined deadline.  Queues are
> > > > serviced based upon priority most of the time, and based upon age some
> > of
> > > > the time.
> > >
> > >Hmm also sounds fudgy.
> >
> > Yeah.  I crossbred it with a ~deadline scheduler, and created a mutt.
>
>But how did this mutt perform?

At the time, I was more concerned by the very long semaphore hold times I 
was seeing than anything else.  That it helped quite a lot.  It didn't hurt 
throughput in any way I could see, and it improved irman's latency 
numbers.  (process load was routinely hitting ~1.5 seconds max latency at 
the time, that tree cut it to roughly 400-500ms iirc)  Just like anything 
else that increases fairness though, it hurt X feel somewhat in the 
presence of load.

         -Mike 

