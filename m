Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932320AbVK2SNr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932320AbVK2SNr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 13:13:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932325AbVK2SNr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 13:13:47 -0500
Received: from ns2.suse.de ([195.135.220.15]:2732 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932320AbVK2SNq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 13:13:46 -0500
Date: Tue, 29 Nov 2005 19:13:44 +0100
From: Andi Kleen <ak@suse.de>
To: Stephane Eranian <eranian@hpl.hp.com>
Cc: Ray Bryant <raybry@mpdtxmail.amd.com>, Andi Kleen <ak@suse.de>,
       discuss@x86-64.org, linux-kernel@vger.kernel.org,
       perfctr-devel@lists.sourceforge.net
Subject: Re: [Perfctr-devel] Re: Enabling RDPMC in user space by default
Message-ID: <20051129181344.GN19515@wotan.suse.de>
References: <20051129151515.GG19515@wotan.suse.de> <200511291056.32455.raybry@mpdtxmail.amd.com> <20051129180903.GB6611@frankl.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051129180903.GB6611@frankl.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Where did you see that PMC0 (PERSEL0/PERFCTR0) can only be programmed
> to count cpu cycles (i.e. cpu_clk_unhalted)? As far as I can tell from
> the documentation, the 4 counters are symetrical and can measure
> any event that the processor offers.

Linux NMI watchdog does that.

All other perfctr users are supposed to keep their fingers away 
from the watchdog (it looks like oprofile doesn't but not for much
longer ...) 

I think it's also a useful convention - RDTSC is becomming more and more
useless and you cannot expect user applications who just want to
measure some cycles to rely on ever changing instable or non existing
performance counter APIs.

> If you look at the perfmon x86-64 patch, you will see that under certain
> circumstances, we enable CR4.pce. The main motivation is to alloc reading
> counters at ring 3 with RDPMC. By default, CR4.pce must be cleared for
> security reasons (covert channel). Perfmon only allows RDPMC for

The same covert channel would exist with RDTSC so that argument is bogus.

-Andi

