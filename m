Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267556AbUJNWOr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267556AbUJNWOr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 18:14:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267984AbUJNWNp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 18:13:45 -0400
Received: from lirs02.phys.au.dk ([130.225.28.43]:11398 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S267294AbUJNVxN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 17:53:13 -0400
Date: Thu, 14 Oct 2004 23:52:08 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Mark_H_Johnson@raytheon.com, Andrew Morton <akpm@osdl.org>,
       Bill Huey <bhuey@lnxw.com>, Dipankar Sarma <dipankar@in.ibm.com>,
       Adam Heath <doogie@debian.org>, Daniel Walker <dwalker@mvista.com>,
       "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Lorenzo Allegrucci <l_allegrucci@yahoo.it>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U1
In-Reply-To: <20041014194854.GA14763@elte.hu>
Message-Id: <Pine.OSF.4.05.10410142338390.20883-100000@da410.ifa.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-DAIMI-Spam-Score: -2.82 () ALL_TRUSTED
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Oct 2004, Ingo Molnar wrote:

> 
> * Mark_H_Johnson@raytheon.com <Mark_H_Johnson@raytheon.com> wrote:
> 
> > >the overhead we can try to optimize later on. What problems do you see
> > >with setting priorities on those IRQs?
> > 
> > Perhaps I am old fashioned, but in building a real time system, I
> > consider hardware interrupt processing as something that is always at
> > a higher priority than real time tasks. [...]


Let us say you have a server taking in requests over the network. Then you
want to run the ethernet device at very high priority - you can just as
well run it in the interrupt directly. But let us say you are making an
embedded device handling some hardware real-time but having a
web-interface to configure it. Then you dont want the traffic on the
network to take CPU from you real-time thread (if you don't have DMA it
can take a lot of CPU just to read the packets out of the controller!)

I do have real life experience with exactly this problem and the solution
was to move the interrupt-handler into a low-priority thread.

As I said on comments on lwn.net: Make these things parameters for the
real-time guys to choose per driver for their specific system. There is no
good setting useable for everybody. On normal systems let them stay in
interrupt context and use normal spinlocks for must things That _performs_
much better but gives higher latencies. Just make it possible for the
real-time system developeres to configure their system compiletime along
with choosing drivers, file systems etc.


Esben



