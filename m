Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267988AbUJLWj2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267988AbUJLWj2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 18:39:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268040AbUJLWj2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 18:39:28 -0400
Received: from smtp.Lynuxworks.com ([207.21.185.24]:32777 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP id S268043AbUJLWhM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 18:37:12 -0400
Date: Tue, 12 Oct 2004 15:36:42 -0700
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Bill Huey <bhuey@lnxw.com>, dwalker@mvista.com,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       amakarov@ru.mvista.com, ext-rt-dev@mvista.com,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Ext-rt-dev] Re: [ANNOUNCE] Linux 2.6 Real Time Kernel
Message-ID: <20041012223642.GB30966@nietzsche.lynx.com>
References: <20041010084633.GA13391@elte.hu> <1097437314.17309.136.camel@dhcp153.mvista.com> <20041010142000.667ec673.akpm@osdl.org> <20041010215906.GA19497@elte.hu> <1097517191.28173.1.camel@dhcp153.mvista.com> <20041011204959.GB16366@elte.hu> <1097607049.9548.108.camel@dhcp153.mvista.com> <1097610393.19549.69.camel@thomas> <20041012211201.GA28590@nietzsche.lynx.com> <1097618415.19549.190.camel@thomas>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1097618415.19549.190.camel@thomas>
User-Agent: Mutt/1.5.6+20040907i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2004 at 12:00:16AM +0200, Thomas Gleixner wrote:
> On Tue, 2004-10-12 at 23:12, Bill Huey wrote:
> > My tree is stable. I was able to hammer this machine for 2-3 days straight
> > (no networking, that's another major can of worms) with deadlocking
> > using multipule mass "find / -exec egrep" of some sort that stress both
> > process creation and all parts of the IO system.
> 
> He, a system without networking is a real measurement ? Ever heard of
> hackbench in combination with ping -f ?

The problem with doing this project is to create an identically
functioning system that's correct. The current track taking by Monta Vista
is highly unstable given the lack of locking throughout their kernel. It
has all of the complexities of mutex style conventions without any debugging
methodology attached to it. It's no longer the spinlock universe that
Linux is using since a deadlock situation just leaves use running in
cpu_idle wondering what is going on.

It's something that needs to be address in the large scheme of the project.
 
> > That graph that I saw from Lee is consistent with my results in that a
> > deadlock prone system will have phenomenal latency performance at the
> > expense of being absolutely incorrect. It's just a flat out broken
> > system at this point that they've released.
> 
> Thats a major problem caused by "dumb" priority inheritence. The goal is
> not priority inheritence at the very end. It's proxy execution, where
> priority inheritence is a subset.

This has been articulate a couple of times by both me and Ingo (recent email).
The MV's system is highly unstable, not because of priority inheritance,
but because of basic lock violation in the lock graph itself. It's another kind
of SMP granularity problem. The hard problem was just what Ingo was saying and
it's higher, but higher in the graph.

> > Yes, I agree, but the convention needs to be standardized.
> 
> That's all I was talking about.

Yeah, it needs to be done. I like the "_" methodology that both Monta Vista
and Ingo are using. I'll convert my stuff over to using it when I'm finished
with a couple of large items here.

> I'm not talking about automatic conversion of rules. I'm talking about
> automatic conversion of different concurrency controls into a
> equivillance function, which lets you better identify the neccecary
> manual changes and leaves room for simple and non intrusive replacement
> implementations.

This is kind of a sketchy problem. So far all of what I've seen really needs
to be done manually and can be done using the all of the normal Linux locking
and scheduler/interrupt masking primitives. I'd hate to see another system
added to this that solves a problem that may not exist. Please, correct
me if I'm not understanding you.

> > Give me a bit of time to upload those files. I was just given permission
> > to talk about this openly now. But I can definitely tell you that I had
> > this running months before Monta Vista's announcement over the weekend.
 
> There are a bunch of other efforts underway around the world, which
> might be concentrated now into one.

bill

