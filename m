Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751336AbWIKR47@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336AbWIKR47 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 13:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751337AbWIKR47
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 13:56:59 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:27529 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751336AbWIKR46 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 13:56:58 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrew Morton <akpm@osdl.org>
Cc: Brandon Philips <brandon@ifup.org>, linux-kernel@vger.kernel.org,
       Brice Goglin <brice@myri.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
       Robert Love <rml@novell.com>
Subject: Re: 2.6.18-rc6-mm1 2.6.18-rc5-mm1 Kernel Panic on X60s
References: <20060908174437.GA5926@plankton.ifup.org>
	<20060908121319.11a5dbb0.akpm@osdl.org>
	<20060908194300.GA5901@plankton.ifup.org>
	<20060908125053.c31b76e9.akpm@osdl.org>
	<20060911021400.GA6163@plankton.ifup.org>
	<20060911095106.2a7d6d95.akpm@osdl.org>
Date: Mon, 11 Sep 2006 11:55:32 -0600
In-Reply-To: <20060911095106.2a7d6d95.akpm@osdl.org> (Andrew Morton's message
	of "Mon, 11 Sep 2006 09:51:06 -0700")
Message-ID: <m1ac569tkb.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> OK, thanks.
>
> I don't think this necessarily tells us where the bug lies.  It could be
> some pre-existing thing in MSI, or it could be added by Bryce's changes. 
> Or by Eric's.  Or, of course, by
> genirq-convert-the-i386-architecture-to-irq-chips.patch.
>
> There doesn't seem to be a lot of movement on this and we want to get the
> x86 genirq conversion into 2.6.19.  Could be that we end up having to merge
> known-buggy stuff into mainline and crash enough computers to irritate
> someone into fixing it.  Rather sad.

My planning to take a good hard look at it, in a bit.
Since it was failing in do_IRQ with a page fault something is obviously being
left as NULL, so this should be quite easy to track down once we look
closely.

I'm very suspicious that this failure started happening in just
the last two -mm releases.  That seems to implicate Bryce's work,
but if it is just about enabling MSI he should not have touched
the code path where the failure happened.

Also I noticed a little while ago that I didn't quite take the
msi code far enough.  In particular the generic code still does some
apic accesses which doesn't make any sense at all for architectures
like ppc.

I'm currently sitting on a queue of 30 about 99% complete struct pid
conversions, that I just need to review one last time and then send
out to get merged, hopefully I can get the rest of these patches sent
out in the next day or two, so I can focus on irq issues for a bit.

Eric
