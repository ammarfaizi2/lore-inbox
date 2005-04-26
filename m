Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261295AbVDZEpj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261295AbVDZEpj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 00:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261315AbVDZEpj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 00:45:39 -0400
Received: from 70-56-217-9.albq.qwest.net ([70.56.217.9]:9685 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261295AbVDZEpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 00:45:34 -0400
Date: Mon, 25 Apr 2005 22:47:53 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Li Shaohua <shaohua.li@intel.com>
cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>
Subject: Re: [PATCH]broadcast IPI race condition on CPU hotplug
In-Reply-To: <1114489490.7416.2.camel@sli10-desk.sh.intel.com>
Message-ID: <Pine.LNX.4.61.0504252245530.26521@montezuma.fsmlabs.com>
References: <1114482044.7068.17.camel@sli10-desk.sh.intel.com> 
 <Pine.LNX.4.61.0504252222230.26521@montezuma.fsmlabs.com>
 <1114489490.7416.2.camel@sli10-desk.sh.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Apr 2005, Li Shaohua wrote:

> On Tue, 2005-04-26 at 12:25, Zwane Mwaikambo wrote:
> > 
> > > After a CPU is booted but before it's officially up (set online map, and
> > > enable interrupt), the CPU possibly will receive a broadcast IPI. After
> > > it's up, it will handle the stale interrupt soon and maybe cause oops if
> > > it's a smp-call-function-interrupt. This is quite possible in CPU
> > > hotplug case, but nearly can't occur at boot time. Below patch replaces
> > > broadcast IPI with send_ipi_mask just like the cluster mode.
> > 
> > Ok, but isn't it sufficient to use send_ipi_mask in smp_call_function 
> > instead?
> I'm not sure if other routines using broadcast IPI have this bug. Fixing
> the send_ipi_all API looks more generic. Is there any reason we should
> use broadcast IPI?

I'd prefer only touching smp_call_function because the others are 
primitives, we should only be fixing the users of the primitives, 
otherwise we'll end up with code which won't be as versatile.

Thanks,
	Zwane
