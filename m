Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750917AbVL2U0M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750917AbVL2U0M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 15:26:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750960AbVL2U0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 15:26:12 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:51872 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750915AbVL2U0M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 15:26:12 -0500
Date: Thu, 29 Dec 2005 21:25:50 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Adrian Bunk <bunk@stusta.de>
Cc: lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       Matt Mackall <mpm@selenic.com>, Dave Jones <davej@redhat.com>
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
Message-ID: <20051229202550.GB29546@elte.hu>
References: <20051228114637.GA3003@elte.hu> <20051229043835.GC4872@stusta.de> <20051229075936.GC20177@elte.hu> <20051229135250.GE3811@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051229135250.GE3811@stusta.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.9 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.9 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Adrian Bunk <bunk@stusta.de> wrote:

> It won't be dropped on the floor indefinitely.
> 
> "I do plan to look at this" means that I'd currently estimate this 
> being 2.6.19 stuff.

you must be kidding ...

> Yes that's one year from now, but we need it properly analyzed and 
> tested before getting it into Linus' tree, and I do really want it 
> untangled from and therefore after 4k stacks.

you are really using the wrong technology for this.

look at the latency tracing patch i posted today: it includes a feature 
that prints the worst-case stack footprint _as it happens_, and thus 
allows the mapping of such effects in a very efficient and very 
practical way. As it works on a live system, and profiles live function 
traces, it goes through function pointers and irq entry nesting effects 
too. We could perhaps put that into Fedora for a while and get the 
worst-case footprints mapped.

in fact i've been running this feature in the -rt kernel for quite some 
time, and it enabled the fixing of a couple of bad stack abusers, and it 
also told us what our current worst-case stack footprint is [when 4K 
stacks are enabled]: it's execve of an ELF binary.

	Ingo
