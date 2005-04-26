Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261314AbVDZE25@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261314AbVDZE25 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 00:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261345AbVDZE24
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 00:28:56 -0400
Received: from fmr18.intel.com ([134.134.136.17]:8679 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S261314AbVDZE2A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 00:28:00 -0400
Subject: Re: [PATCH]broadcast IPI race condition on CPU hotplug
From: Li Shaohua <shaohua.li@intel.com>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>
In-Reply-To: <Pine.LNX.4.61.0504252222230.26521@montezuma.fsmlabs.com>
References: <1114482044.7068.17.camel@sli10-desk.sh.intel.com>
	 <Pine.LNX.4.61.0504252222230.26521@montezuma.fsmlabs.com>
Content-Type: text/plain
Message-Id: <1114489490.7416.2.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 26 Apr 2005 12:24:50 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Tue, 2005-04-26 at 12:25, Zwane Mwaikambo wrote:
> 
> > After a CPU is booted but before it's officially up (set online map, and
> > enable interrupt), the CPU possibly will receive a broadcast IPI. After
> > it's up, it will handle the stale interrupt soon and maybe cause oops if
> > it's a smp-call-function-interrupt. This is quite possible in CPU
> > hotplug case, but nearly can't occur at boot time. Below patch replaces
> > broadcast IPI with send_ipi_mask just like the cluster mode.
> 
> Ok, but isn't it sufficient to use send_ipi_mask in smp_call_function 
> instead?
I'm not sure if other routines using broadcast IPI have this bug. Fixing
the send_ipi_all API looks more generic. Is there any reason we should
use broadcast IPI?

Thanks,
Shaohua

