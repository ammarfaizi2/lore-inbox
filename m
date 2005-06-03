Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261229AbVFCL4O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261229AbVFCL4O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 07:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbVFCL4O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 07:56:14 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:17313 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261229AbVFCL4I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 07:56:08 -0400
Date: Fri, 3 Jun 2005 13:56:06 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@infradead.org>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>
Subject: Re: [rfc] [patch] consolidate/clean up spinlock.h files
In-Reply-To: <20050603051629.GB14059@elte.hu>
Message-ID: <Pine.LNX.4.61.0506031300420.3743@scrub.home>
References: <20050602144004.GA31807@elte.hu> <Pine.LNX.4.61.0506021817390.3743@scrub.home>
 <20050603051629.GB14059@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 3 Jun 2005, Ingo Molnar wrote:

> yes, that's what i'm working towards - separating type from 
> implementation on the arch level was the first step needed. I already 
> had it at such a state yesterday (complete separation of type 
> definitions, API definitions and asm implementation - it needed the 
> initializers in the asm/spinlock_types.h file, but otherwise it was 
> straightforward), but undid it in the last minute because sched.c and 
> kernel_lock.c used some intermediate/raw primitives, leading to ugly 
> dependencies. I'll re-try this angle today and repost the patch.

Some time ago I posted these patches: http://www.xs4all.nl/~zippel/task_patches/
They basically only move the type definitions into separate header files, 
but would basically allow a much better cleanup of e.g. the spinlock 
header file. Right now it's an ifdef jungle with lots of duplicated code.
In the end I'd like to see a single set of spinlock functions, which are 
either inlined or instantiated in kernel/spinlock.c. But for the macros to 
become inline functions, we need to cleanup the header dependencies, so 
that we get: spinlock implementation -> preempt/irq implementation -> 
task/thread definitions -> spinlock definitions.
In this context I'm a little concerned whether your up/smp separation 
really works out. A proper cleanup needs changes outside the spinlock 
code and not just splitting the existing header into smaller headers.

bye, Roman
