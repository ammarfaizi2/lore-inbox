Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264371AbTEHBGY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 21:06:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264373AbTEHBGY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 21:06:24 -0400
Received: from h-68-165-86-241.DLLATX37.covad.net ([68.165.86.241]:15177 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S264371AbTEHBGW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 21:06:22 -0400
Subject: Re: 2.5.69 Interrupt Latency
From: Paul Fulghum <paulkf@microgate.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030507152856.2a71601d.akpm@digeo.com>
References: <1052323940.2360.7.camel@diemos>
	 <1052336482.2020.8.camel@diemos>  <20030507152856.2a71601d.akpm@digeo.com>
Content-Type: text/plain
Organization: 
Message-Id: <1052353539.1495.11.camel@doobie>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 07 May 2003 19:25:39 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-05-07 at 17:28, Andrew Morton wrote:
> Paul Fulghum <paulkf@microgate.com> wrote:
> >
> > 2.5.69
> > Latency 100-110usec (5x increase)
> > Spikes from 5-10 milliseconds
> > 
> > This is all on a PCI adapter not sharing interrupts
> > on a dual Pentium II-400 Netserver LC3.
> > 
> > Any ideas what happened?
> 
> Could be that some random piece of code forgot to reenable interrupts, and
> things stay that way until they get reenabled again by schedule() or
> syscall return.
> 
> One way of finding the culprit would be:
> 
> 	my_isr()
> 	{
> 		if (this interrupt is more than 5 milliseconds delayed)
> 			dump_stack();
> 	}
> 
> the stack dump will point up at the place where interrupts finally got
> enabled.

I'll give that a try tomorrow.

> If you can describe what drivers are in use, and what workload triggers the
> problem then it may be locatable by inspection.

It happens on both of the machines I tried (server and laptop).
I think the only common hardware between the two is the net
controller which is intel etherpro 100 based. I'll check tomorrow
to be sure.

There was essentially no work load (no net traffic, no CPU
intensive program, no disk activity). I was just doing simple
loopback tests on our serial devices (PCI based on server
and PC Card on laptop).

Paul Fulghum
paulkf@microgate.com




