Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262405AbVAPFS4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262405AbVAPFS4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 00:18:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262430AbVAPFS4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 00:18:56 -0500
Received: from ozlabs.org ([203.10.76.45]:42369 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262405AbVAPFSy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 00:18:54 -0500
Subject: Re: [PATCH] i386/x86-64: Fix timer SMP bootup race
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, manpreet@fabric7.com,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       discuss@x86-64.org
In-Reply-To: <20050115075946.GA28981@wotan.suse.de>
References: <20050115040951.GC13525@wotan.suse.de>
	 <1105765760.12263.12.camel@localhost.localdomain>
	 <20050115052311.GC22863@wotan.suse.de>
	 <1105774495.12263.21.camel@localhost.localdomain>
	 <20050115075946.GA28981@wotan.suse.de>
Content-Type: text/plain
Date: Sun, 16 Jan 2005 15:20:47 +1100
Message-Id: <1105849247.5711.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-01-15 at 08:59 +0100, Andi Kleen wrote: 
> I think my patch is better. It at least keeps all the 
> baggage out of the normal run paths. Doing this check at each timer interrupt
> doesn't make much sense.

It doesn't penalize the architectures which do the right thing already.
If this weren't i386 we were talking about...

But adding a bizarro "pre-prepare" notifier verged on nonsensical 8(.  I
prefer an explicit "init_timers_early()" call as a workaround; I'll code
that up and test tomorrow, when I'm back in the office with an SMP box
to test.

I'm also not clear on why we need to enable interrupts around
calibrate_delay() on secondary processors, but I'll try that too and
find out 8)

Thanks,
Rusty.
-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

