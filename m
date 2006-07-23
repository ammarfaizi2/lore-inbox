Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751161AbWGWI3s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbWGWI3s (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jul 2006 04:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbWGWI3s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jul 2006 04:29:48 -0400
Received: from [216.208.38.107] ([216.208.38.107]:13708 "EHLO
	OTTLS.pngxnet.com") by vger.kernel.org with ESMTP id S1751157AbWGWI3r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jul 2006 04:29:47 -0400
Subject: Re: remove cpu hotplug bustification in cpufreq.
From: Arjan van de Ven <arjan@linux.intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, ashok.raj@intel.com,
       linux-kernel@vger.kernel.org, davej@redhat.com,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20060722223425.c94a858e.akpm@osdl.org>
References: <20060722194018.GA28924@redhat.com>
	 <Pine.LNX.4.64.0607221707400.29649@g5.osdl.org>
	 <20060722180602.ac0d36f5.akpm@osdl.org>
	 <Pine.LNX.4.64.0607221813020.29649@g5.osdl.org>
	 <20060722223425.c94a858e.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 23 Jul 2006 10:29:40 +0200
Message-Id: <1153643380.7359.24.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

> > Well, I just got Ashok's trial patches which turns the thing into a rwsem 
> > as I outlined earlier.
> 
> Mark my words ;)
> 
> > I'll try them out. If they don't work, we should just delete the lock and 
> > go totally back to square 1.
> 
> rwsem conversion has the potential to merely hide the problem.  Ingo, does
> lockdep detect recursive down_read()?

lockdep detects and warns about those.

I think we're about equally skeptical about this; I'm extremely hesitant
about any place in the kernel that uses rwsems for anything other than a
performance tweak. I've ended up with a mental model of rwsems that
basically comes down to "you need to be able to replace it with a mutex
without breaking correctness". Now of course that model is somewhat of
an oversimplification, but not by that much...

Greetings,
   Arjan van de Ven
