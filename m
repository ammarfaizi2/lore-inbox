Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162557AbWLGRYq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162557AbWLGRYq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 12:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162560AbWLGRYq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 12:24:46 -0500
Received: from cantor2.suse.de ([195.135.220.15]:43329 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1162557AbWLGRYp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 12:24:45 -0500
From: Andi Kleen <ak@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] x86_64: do not enable the NMI watchdog by default
Date: Thu, 7 Dec 2006 18:24:33 +0100
User-Agent: KMail/1.9.5
Cc: Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
References: <20061206223025.GA17227@elte.hu> <200612061857.30248.len.brown@intel.com> <20061207121135.GA15529@elte.hu>
In-Reply-To: <20061207121135.GA15529@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612071824.33169.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> and it needs to be  
> undone via the patch attached further below.

I disagree. And it has often saved my ass on 64bit. I

On 32bit it might be reevaluated -- i didn't expect that amount
of laptop firmware bugs triggered by it, but I'm not quite
ready to give up on that yet.

> If Andi wants to debug stuff via the NMI wachdog, he should use the 
> nmi_watchdog=2 boot option:

This means for most lockups which are hard to reproduce we don't 
get any backtrace.

And nmi_watchdog=2 is bad because it runs at HZ frequency 
and has quite high overhead.

> also, lock debugging facilities catch lockup possibilities (and actual 
> lockups) alot more efficiently, 

Production kernels don't have lock debugging enabled because it 
has far too much overhead.

> 8 were caught by lockdep, 8 by atomicity checks in the scheduler, 7 by 
> DEBUG_PREEMPT and 1 by DEBUG_SPINLOCK.

None of which is enabled on non debug kernels.
 
> Note: zero were caught by the NMI watchdog, and i run the NMI watchdog 
> enabled by default on all architectures, and i have serial logging of 
> everything.

Sure lock debugging will probably catch most of this earlier,
but we don't have it usually.

-Andi
