Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267535AbUIGFsa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267535AbUIGFsa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 01:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267565AbUIGFsa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 01:48:30 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:14757 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S267535AbUIGFs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 01:48:27 -0400
Subject: Re: sleep and wakeup at microsecond boundary
From: "NucleoDyne Systems, " "Inc." <nucleon@nucleodyne.com>
Reply-To: nucleon@nucleodyne.com
To: Mike Galbraith <efault@gmx.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <5.2.1.1.2.20040905085650.00b1e640@pop.gmx.net>
References: <5.2.1.1.2.20040905085650.00b1e640@pop.gmx.net>
Content-Type: text/plain
Organization: NucleoDyne Corporation
Message-Id: <1094536010.3436.34.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 06 Sep 2004 22:46:50 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
      Let me explain the requirement a little more in detail.

Consider the routine sleep_on_timeout(, timeout) in sched.c:

A timer is started and then schedule() is called. The timer expires
after present jiffies + timeout (in jiffies) period.

On  x86 the jiffies is updated every time PIT raises interrupt and
do_timer() is called, i.e. once in every 10ms.

So we can set timeout in multiples of 10ms. 

We are developing a very powerful system (not x86 based) with multiple
CPUs, one of them will be running linux and will act as a co-processor
for the other CPUs running different OS.

On the CPU running linux we need to be able to call sleep_on_timeout()
with more granular expiration time, may be in multiples of microseconds.

I already have done the investigation and looking for feedback from the
developers on all possible issues.

Hope this explains.


Thanks,
Kallol Biswas



On Sun, 2004-09-05 at 00:09, Mike Galbraith wrote:
> At 12:51 PM 9/4/2004 -0700, NucleoDyne Systems, " "Inc. wrote:
> >Hello,
> >       We have a requirement to implement the sleep and wakeup mechanism
> >at microsecond boundary in 2.4 kernel.
> 
> I've re-visited this message about 10 times now, so I suppose I'm curious 
> enough to ask:  why on God's green Earth would someone want to do 
> that?  (to _any_ kernel, but I'm mostly wondering why [TILT] anyone would 
> do such a thing to a GP kernel)
> 
>          -Mike

On Sat, 2004-09-04 at 12:51, NucleoDyne Systems, Inc. wrote: \

> Hello,
>       We have a requirement to implement the sleep and wakeup mechanism
> at microsecond boundary in 2.4 kernel. The intent of this mail is to
> start a discussion on this topic and collect inputs from the kernel
> developers. Any reply on the issues of implementing such a feature will
> be greatly appreciated.
> 
> Thanks,
> Kallol Biswas


-- 
--
NucleoDyne Corporation
nucleon@nucleodyne.com
www.nucleodyne.com
-- 


