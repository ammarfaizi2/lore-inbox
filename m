Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753418AbWKMJIp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753418AbWKMJIp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 04:08:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753482AbWKMJIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 04:08:45 -0500
Received: from ns1.suse.de ([195.135.220.2]:4246 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1753418AbWKMJIn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 04:08:43 -0500
From: Andi Kleen <ak@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] genapic: optimize & fix APIC mode setup
Date: Mon, 13 Nov 2006 10:08:37 +0100
User-Agent: KMail/1.9.5
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ashok.raj@intel.com
References: <20061111151414.GA32507@elte.hu> <200611130332.07569.ak@suse.de> <20061113081616.GA25604@elte.hu>
In-Reply-To: <20061113081616.GA25604@elte.hu>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200611131008.37810.ak@suse.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 November 2006 09:16, Ingo Molnar wrote:
> 
> * Andi Kleen <ak@suse.de> wrote:
> 
> > Now if it causes device driver issues that's different of course. I 
> > wasn't aware of this before.
> 
> lets try my patch in -mm for a while.

I don't think that's a good idea.

> 
> Had i ever noticed this hack in the first place i would have NAK-ed it. 
> There is a fundamental design friction of a high-level feature like 
> HOTPLUG_CPU /requiring/ a fundamental change to the lowlevel IRQ 
> delivery mode! 

Well to be honest masked mode isn't that useful anyways. It's only
theoretical advantage would be a bit more performance for multicast IPIs, 
but Ashok did benchmarks and it didn't make any significant difference. With that
I prefer to use always the same mode for small and large systems.
Ok should probably drop the ifdef and just always use physical mode.


> Such a requirement is broken and just serves to hide a  
> flaw in the hotplug design - which flaw would trigger on i386 /anyway/, 
> because i386 still uses logical delivery mode for APIC IPIs. 

i386 cpu hotplug is somewhat broken anyways, but it should be fixed
there too eventually. But some very old chipsets don't seem to support
physical properly so it wasn't changed there.

> Also, i'd  
> like to have a description of how to reproduce those CPU hotplug 
> problems, so that i can try to fix it.

iirc they just did stress tests. Plug/unplug cpus in a tight loop and 
do some workloads and see what happens.

-Andi
 
