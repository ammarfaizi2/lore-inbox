Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030418AbWFVWO6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030418AbWFVWO6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 18:14:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030419AbWFVWO6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 18:14:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:2523 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030418AbWFVWO5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 18:14:57 -0400
From: Andi Kleen <ak@suse.de>
To: rohitseth@google.com
Subject: Re: [RFC, patch] i386: vgetcpu(), take 2
Date: Fri, 23 Jun 2006 00:14:17 +0200
User-Agent: KMail/1.9.3
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, discuss@x86-64.org
References: <200606210329_MC3-1-C305-E008@compuserve.com> <200606221008.41873.ak@suse.de> <1151010387.14536.39.camel@galaxy.corp.google.com>
In-Reply-To: <1151010387.14536.39.camel@galaxy.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606230014.17067.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Would sgdt not be sufficient?  I agree that we will have to end up
> giving RO access to user for the gdt page.

I meant exporting the GDT page

> I agree that we should not overload a single call (though cpu, package
> and node numbers do belong in one category IMO).  We can have multiple
> calls if that is required as long as there is an efficient mechanism to
> provide that information.

The current mechanism doesn't scale to much more calls, but I guess
i'll have to do a vDSO sooner or later.
 
> Why maintain that extra logic in user space when kernel can easily give
> that information.

It already does.
 
> > I've been pondering to put some more information about that
> > in the ELF aux vector, but exporting might work too. I suppose
> > exporting would require the vDSO first to give a sane interface.
> > 
> Can you please tell me what more information you are thinking of putting
> in aux vector?

One proposal (not fully fleshed out was) number of siblings / sockets / nodes 
I don't think bitmaps would work well there (and if someone really needs
those they can read cpuinfo again) 

This is mostly for OpenMP and tuning of a few functions (e.g. on AMD
the memory latencies varies with the number of nodes so some functions
can be tuned in different ways based on that) 

> You are absolutely right that the mechanism I'm proposing makes sense
> only if we have more fields AND if any of those fields are dynamically
> changing.  But this is a generic mechanism that could be extended to
> share any user visible information in efficient way.  Once we have this
> in place then information like whole cpuinfo, percpu interrupts etc. can
> be retrieved easily.

The problem with exposing too much is that it might be a nightmare
to guarantee a stable ABI for this. At least it would
constrain the kernel internally. Probably less is better here. 

Also I'm still not sure why user space should care about interrupts?

-Andi
