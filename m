Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264851AbUFDJ3y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264851AbUFDJ3y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 05:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265155AbUFDJ3y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 05:29:54 -0400
Received: from mx2.elte.hu ([157.181.151.9]:64961 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S264851AbUFDJ3w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 05:29:52 -0400
Date: Fri, 4 Jun 2004 11:30:59 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Suresh Siddha <suresh.b.siddha@intel.com>
Cc: Andi Kleen <ak@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: [announce] [patch] NX (No eXecute) support for x86, 2.6.7-rc2-bk2
Message-ID: <20040604093059.GB11034@elte.hu>
References: <20040602205025.GA21555@elte.hu> <200406031224.13319.suresh.b.siddha@intel.com> <20040603203709.GB868@wotan.suse.de> <200406031558.27495.suresh.b.siddha@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406031558.27495.suresh.b.siddha@intel.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Suresh Siddha <suresh.b.siddha@intel.com> wrote:

> On Thursday 03 June 2004 13:37, Andi Kleen wrote:
> > > What do you mean by "in the future"? on x86, with the current no execute 
> > > patch, malloc() will be non-exec
> > 
> > On x86-64 the heap is executable right now at least.
> 
> oh! I see. Looks like only Ingo's exec-shield patch is doing that.

yep. The patch also detaches the brk area from the binary's image and
bss, and randomizes it. (this isolates them better and makes it harder
to overflow between these sections.)

For the segment-limit method on non-NX CPUs a non-executable brk (heap,
malloc() space) has another significance: since it must be above the
binary image [there's simply not enough brk space below the binary], the
CS segment limit does not cover the binary's .data/bss sections - hence
that is non-executable as well. [for NX there's no difference - the
.data/bss sections are non-executable.]

but for the mainstream kernel the most important step would be to make
brk non-executable.

	Ingo
