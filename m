Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261232AbUE1J5t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbUE1J5t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 05:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263045AbUE1J5s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 05:57:48 -0400
Received: from mail003.syd.optusnet.com.au ([211.29.132.144]:27860 "EHLO
	mail003.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261232AbUE1J5r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 05:57:47 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Peter Williams <peterw@aurema.com>
Subject: Re: [RFC][PATCH][2.6.6] Replacing CPU scheduler active and expired with a single array
Date: Fri, 28 May 2004 19:57:04 +1000
User-Agent: KMail/1.6.1
Cc: Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <40B6C571.3000103@aurema.com> <20040528090536.GA12933@elte.hu> <40B70542.2060006@aurema.com>
In-Reply-To: <40B70542.2060006@aurema.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405281957.04753.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 May 2004 19:24, Peter Williams wrote:
> Ingo Molnar wrote:
> > just try it - run a task that runs 95% of the time and sleeps 5% of the
> > time, and run a (same prio) task that runs 100% of the time. With the
> > current scheduler the slightly-sleeping task gets 45% of the CPU, the
> > looping one gets 55% of the CPU. With your patch the slightly-sleeping
> > process can easily monopolize 90% of the CPU!

> This does, of course, not take into account the interactive bonus.  If
> the task doing the shorter CPU bursts manages to earn a larger
> interactivity bonus than the other then it will get more CPU but isn't
> that the intention of the interactivity bonus?

No. Ideally the interactivity bonus should decide what goes first every time 
to decrease the latency of interactive tasks, but the cpu percentage should 
remain close to the same for equal "nice" tasks. Interactive tasks need low 
scheduling latency and short bursts of high cpu usage; not more cpu usage 
overall. When the cpu percentage differs significantly from this the logic 
has failed.

Con
