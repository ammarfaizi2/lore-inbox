Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261872AbVD0A6T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261872AbVD0A6T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 20:58:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261875AbVD0A6T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 20:58:19 -0400
Received: from 70-56-217-9.albq.qwest.net ([70.56.217.9]:19944 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261872AbVD0A6G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 20:58:06 -0400
Date: Tue, 26 Apr 2005 19:00:28 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Andi Kleen <ak@suse.de>
cc: Li Shaohua <shaohua.li@intel.com>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH]broadcast IPI race condition on CPU hotplug
In-Reply-To: <20050426132149.GF5098@wotan.suse.de>
Message-ID: <Pine.LNX.4.61.0504261858240.12903@montezuma.fsmlabs.com>
References: <1114482044.7068.17.camel@sli10-desk.sh.intel.com>
 <20050426132149.GF5098@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Apr 2005, Andi Kleen wrote:

> On Tue, Apr 26, 2005 at 10:20:44AM +0800, Li Shaohua wrote:
> > Hi,
> > After a CPU is booted but before it's officially up (set online map, and
> > enable interrupt), the CPU possibly will receive a broadcast IPI. After
> > it's up, it will handle the stale interrupt soon and maybe cause oops if
> > it's a smp-call-function-interrupt. This is quite possible in CPU
> > hotplug case, but nearly can't occur at boot time. Below patch replaces
> > broadcast IPI with send_ipi_mask just like the cluster mode.
> 
> No way we are making this common operation much slower just
> to fix an obscure race at boot time. PLease come up with a fix
> that only impacts the boot process.

The fix only for smp_call_function seems fine to me since we really don't 
want to broadcast to all processors but only online ones. 
smp_call_function is particularly dangerous because the interrupt handler 
accesses stack data which wouldn't be persistent due to the calling 
processor not waiting for non online processors.

Thanks,
	Zwane

