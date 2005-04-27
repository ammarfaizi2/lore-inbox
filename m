Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261560AbVD0M4v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261560AbVD0M4v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 08:56:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261570AbVD0M4v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 08:56:51 -0400
Received: from ns1.suse.de ([195.135.220.2]:50572 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261560AbVD0M4f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 08:56:35 -0400
Date: Wed, 27 Apr 2005 14:56:23 +0200
From: Andi Kleen <ak@suse.de>
To: Li Shaohua <shaohua.li@intel.com>
Cc: Andi Kleen <ak@suse.de>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Zwane Mwaikambo <zwane@linuxpower.ca>
Subject: Re: [PATCH]broadcast IPI race condition on CPU hotplug
Message-ID: <20050427125622.GG13305@wotan.suse.de>
References: <1114482044.7068.17.camel@sli10-desk.sh.intel.com> <20050426132149.GF5098@wotan.suse.de> <1114564068.12809.7.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1114564068.12809.7.camel@sli10-desk.sh.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2005 at 09:11:59AM +0800, Li Shaohua wrote:
> On Tue, 2005-04-26 at 21:21, Andi Kleen wrote:
> > On Tue, Apr 26, 2005 at 10:20:44AM +0800, Li Shaohua wrote:
> > > Hi,
> > > After a CPU is booted but before it's officially up (set online map, and
> > > enable interrupt), the CPU possibly will receive a broadcast IPI. After
> > > it's up, it will handle the stale interrupt soon and maybe cause oops if
> > > it's a smp-call-function-interrupt. This is quite possible in CPU
> > > hotplug case, but nearly can't occur at boot time. Below patch replaces
> > > broadcast IPI with send_ipi_mask just like the cluster mode.
> > 
> > No way we are making this common operation much slower just
> > to fix an obscure race at boot time. PLease come up with a fix
> > that only impacts the boot process.
> We can't prevent a CPU to receive a broadcast interrupt. Ack the
> interrupt and mark the cpu online can't be atomic operation, so the CPU
> either receives unexpected interrupt or loses interrupt.

Cant you just check at the end of the CPU bootup if the CPU
got such an APIC interrupt and ack it then? 

-Andi
