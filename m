Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261879AbVD0BOw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261879AbVD0BOw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 21:14:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261880AbVD0BOw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 21:14:52 -0400
Received: from fmr20.intel.com ([134.134.136.19]:43217 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S261879AbVD0BOu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 21:14:50 -0400
Subject: Re: [PATCH]broadcast IPI race condition on CPU hotplug
From: Li Shaohua <shaohua.li@intel.com>
To: Andi Kleen <ak@suse.de>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Zwane Mwaikambo <zwane@linuxpower.ca>
In-Reply-To: <20050426132149.GF5098@wotan.suse.de>
References: <1114482044.7068.17.camel@sli10-desk.sh.intel.com>
	 <20050426132149.GF5098@wotan.suse.de>
Content-Type: text/plain
Message-Id: <1114564068.12809.7.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 27 Apr 2005 09:11:59 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-04-26 at 21:21, Andi Kleen wrote:
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
We can't prevent a CPU to receive a broadcast interrupt. Ack the
interrupt and mark the cpu online can't be atomic operation, so the CPU
either receives unexpected interrupt or loses interrupt.

Thanks,
Shaohua

