Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290249AbSAXEN2>; Wed, 23 Jan 2002 23:13:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290250AbSAXENT>; Wed, 23 Jan 2002 23:13:19 -0500
Received: from zero.tech9.net ([209.61.188.187]:26889 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S290249AbSAXENH>;
	Wed, 23 Jan 2002 23:13:07 -0500
Subject: Re: Low latency for recent kernels
From: Robert Love <rml@tech9.net>
To: Dan Maas <dmaas@dcine.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <036a01c1a48a$0480da40$1d01a8c0@allyourbase>
In-Reply-To: <fa.h7o6q7v.lha792@ifi.uio.no> <fa.divhjuv.3guviq@ifi.uio.no> 
	<036a01c1a48a$0480da40$1d01a8c0@allyourbase>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 23 Jan 2002 23:17:54 -0500
Message-Id: <1011845875.7028.63.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-01-23 at 22:48, Dan Maas wrote:

> Two situations where I would expect low-latency/preemption to have a
> positive effect on responsiveness are 1) when the system is under heavy CPU
> and disk load (e.g. kernel compile); due to the interactive tasks being able
> to run earlier/more often, and 2) when performing UI operations that depend
> on tight synchronization between X/the WM/the X client, particularly opaque
> window resizing. (my theory is that low-latency/preemption results in the
> CPU switching more rapidly or evenly among these processes, reducing the
> perceptible "lag" between the client window and its WM frame)

This is exactly the area preempt/low-latency helps and I think your
theory is pretty much dead on.

With preempt-kernel, ideally, an interactive task finds itself runnable
like this: user event causes interrupt, interrupt sets need_resched, on
return from interrupt we cause a preemption of current task (which can
happen whether task is in kernel or userland, now), and schedule the
interactive task onto the CPU.

This leads to better scheduling fairness and short scheduling latency.

If you or Havoc are interested in any tests or further work with the
preemptive kernel, I'd be more than willing.  Hey, I use GNOME ;)

	Robert Love

