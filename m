Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261925AbUCSBhd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 20:37:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262488AbUCSBhc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 20:37:32 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:19431 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S261925AbUCSBhS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 20:37:18 -0500
X-AuthUser: davidel@xmailserver.org
Date: Thu, 18 Mar 2004 17:37:20 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Ingo Molnar <mingo@elte.hu>
cc: Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       Ulrich Drepper <drepper@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: sched_setaffinity usability
In-Reply-To: <20040318214646.GA12865@elte.hu>
Message-ID: <Pine.LNX.4.44.0403181726040.8903-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Mar 2004, Ingo Molnar wrote:

> 
> * Davide Libenzi <davidel@xmailserver.org> wrote:
> 
> > > Right now the VDSO mostly contains code and exception-handling data, but
> > > it could contain real, userspace-visible data just as much: info that is
> > > only known during the kernel build. There's basically no cost in adding
> > > more fields to the VDSO, and it seems to be superior to any of the other
> > > approaches. Is there any reason not to do it?
> > 
> > With /proc/something you can have a single piece of code for all archs
> > that exports NR_CPUS. The VDSO should be added to all missing archs.
> > IMO performance is not an issue in getting NR_CPUS from userspace.
> 
> you just cannot beat the mapping performance of a near-zero-overhead
> (V)DSO. No copying. No syscalls to set it up. No runtime dependencies on
> having some filesystem mounted in the right spot. Already existing
> framework to handle various API issues. Debuggers know the layout.

Talking about performance for a function that returns NR_CPUS seems a 
little out of scope IMO (I'd rather exclude tight loops calling sysconf, 
since the info will be const). My objection was more to look at the 
standard way we currently have to export information toward 
userspace/glibc. At this time /proc/ is a standard supported by all 
architectures. The (V)DSO is currently not. If the (V)DSO would have been 
a standard, we wouldn't have had this conversation ;)



- Davide


