Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268739AbUIQNZD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268739AbUIQNZD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 09:25:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268745AbUIQNZD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 09:25:03 -0400
Received: from dmz.tecosim.com ([195.135.152.162]:6579 "EHLO dmz.tecosim.de")
	by vger.kernel.org with ESMTP id S268739AbUIQNYt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 09:24:49 -0400
Date: Fri, 17 Sep 2004 15:24:40 +0200
From: Utz Lehmann <lkml@de.tecosim.com>
To: Andrea Arcangeli <andrea@novell.com>
Cc: Utz Lehmann <lkml@de.tecosim.com>, linux-kernel@vger.kernel.org,
       arjanv@redhat.com, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] flexmmap: optimise mmap_base gap for hard limited stack
Message-ID: <20040917132440.GB15000@de.tecosim.com>
References: <20040916165613.GA10825@de.tecosim.com> <20040916173821.GG15426@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040916173821.GG15426@dualathlon.random>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli [andrea@novell.com] wrote:
> I developed a sysctl several years ago in all my 2.2 and 2.4 kernels
> including all 2.2 and 2.4 SUSE kernels that major software vendors
> requires for safety of their apps. IIRC I tried to merge it once but I
> failed (got not applied to mainline). Now I'v just got another bugzilla
> open about the lack of the sysctl and the major app is now again not
> foolproof. A fixed number won't work, so I have to drop such a fixed GAP
> anyways and rewrite it by forward porting my patch.
> 
> The sysctl in question is /proc/sys/vm/heap-stack-gap, so I recommend to
> drop all those fixed GAP sizes and implement this instead:
> 
> 	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.23aa3/00_silent-stack-overflow-20
> 
> If you reinvet the wheel and you prefer not to share the above code to
> make a sysctl, at least make sure to use the name "heap-stack-gap" to
> avoid any pointless incompatibility.

I dont know if i understand your patch correctly. It looks that there is a
gap wandering below the actual stack. If this is the case than i think it's
not suited for the flexmmap layout. With flexmmap the mappings are top down
from mmap_base.
