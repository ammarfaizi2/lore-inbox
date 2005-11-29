Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932318AbVK2SLM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932318AbVK2SLM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 13:11:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932320AbVK2SLM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 13:11:12 -0500
Received: from palrel12.hp.com ([156.153.255.237]:21715 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S932318AbVK2SLL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 13:11:11 -0500
Date: Tue, 29 Nov 2005 10:09:03 -0800
From: Stephane Eranian <eranian@hpl.hp.com>
To: Ray Bryant <raybry@mpdtxmail.amd.com>
Cc: Andi Kleen <ak@suse.de>, discuss@x86-64.org, linux-kernel@vger.kernel.org,
       perfctr-devel@lists.sourceforge.net
Subject: Re: [Perfctr-devel] Re: Enabling RDPMC in user space by default
Message-ID: <20051129180903.GB6611@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <20051129151515.GG19515@wotan.suse.de> <200511291056.32455.raybry@mpdtxmail.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511291056.32455.raybry@mpdtxmail.amd.com>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi,

On Tue, Nov 29, 2005 at 10:56:31AM -0600, Ray Bryant wrote:
> >
> > I'm considering to enable CR4.PCE by default on x86-64/i386. Currently it's
> > 0 which means RDPMC doesn't work. On x86-64 PMC 0 is always programmed to
> > be a cycle counter, so it would be useful to be able to access
> > this for measuring instructions. That's especially useful because RDTSC
> > does not necessarily count cycles in the current P state (already
> > the case on Intel CPUs and AMD's future direction seems to also
> > to decouple it from cycles) Drawback is that it stops during idle, but
> > that shouldn't be a big issue for normal measuring. It's not useful
> > as a real timer anyways.
> >

Where did you see that PMC0 (PERSEL0/PERFCTR0) can only be programmed
to count cpu cycles (i.e. cpu_clk_unhalted)? As far as I can tell from
the documentation, the 4 counters are symetrical and can measure
any event that the processor offers.

If you look at the perfmon x86-64 patch, you will see that under certain
circumstances, we enable CR4.pce. The main motivation is to alloc reading
counters at ring 3 with RDPMC. By default, CR4.pce must be cleared for
security reasons (covert channel). Perfmon only allows RDPMC for
self-monitoring threads or upon special request.

-- 
-Stephane
