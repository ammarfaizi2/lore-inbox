Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261965AbVBIXS1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261965AbVBIXS1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 18:18:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261966AbVBIXS1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 18:18:27 -0500
Received: from gate.crashing.org ([63.228.1.57]:30386 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261965AbVBIXSX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 18:18:23 -0500
Subject: Re: [PATCH] PPC64 collect and export low-level cpu usage statistics
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
       ahuja@austin.ibm.com, Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20050209150643.60812d3f.akpm@osdl.org>
References: <16906.34562.379000.336836@cargo.ozlabs.ibm.com>
	 <20050209150643.60812d3f.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 10 Feb 2005 10:17:34 +1100
Message-Id: <1107991054.7734.150.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-02-09 at 15:06 -0800, Andrew Morton wrote:
> Paul Mackerras <paulus@samba.org> wrote:
> >
> > POWER5 machines have a per-hardware-thread register which counts at a
> > rate which is proportional to the percentage of cycles on which the
> > cpu dispatches an instruction for this thread (if the thread gets all
> > the dispatch cycles it counts at the same rate as the timebase
> > register).  This register is also context-switched by the hypervisor.
> > Thus it gives a fine-grained measure of the actual cpu usage by the
> > thread over time.
> > 
> > This patch adds code to read this register every timer interrupt and
> > on every context switch.
> 
> fyi: This patch consumes another entry from thread_struct.pad[]. 
> ppc64-implement-a-vdso-and-use-it-for-signal-trampoline.patch consumes two
> more entries, so with both patches, you have none left.

Why couldn't we extend the structure ? That would at worse break modules
binary compatibility, who cares ? :)

Those pads are just stuff that aren't used any more, and back then, when
removing them, we did care about modules binary compat...

Anyways, I don't think there's anything to worry about at this point.
Paul ?

Ben.


