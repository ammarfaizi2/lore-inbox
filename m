Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261650AbUKHOPw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261650AbUKHOPw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 09:15:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261651AbUKHOPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 09:15:52 -0500
Received: from smtp4.netcabo.pt ([212.113.174.31]:6480 "EHLO
	exch01smtp12.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S261650AbUKHOPi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 09:15:38 -0500
Message-ID: <52473.195.245.190.93.1099923323.squirrel@195.245.190.93>
In-Reply-To: <20041108095048.GA11920@elte.hu>
References: <20041020094508.GA29080@elte.hu> <20041021132717.GA29153@elte.hu>
    <20041022133551.GA6954@elte.hu> <20041022155048.GA16240@elte.hu>
    <20041022175633.GA1864@elte.hu> <20041025104023.GA1960@elte.hu>
    <20041027001542.GA29295@elte.hu> <20041103105840.GA3992@elte.hu>
    <20041106155720.GA14950@elte.hu> <20041108091619.GA9897@elte.hu>
    <20041108095048.GA11920@elte.hu>
Date: Mon, 8 Nov 2004 14:15:23 -0000 (WET)
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm3-V0.7.20
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, "Lee Revell" <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       "Bill Huey" <bhuey@lnxw.com>, "Adam Heath" <doogie@debian.org>,
       "Florian Schmidt" <mista.tapas@gmx.net>,
       "Thomas Gleixner" <tglx@linutronix.de>,
       "Michal Schmidt" <xschmi00@stud.feec.vutbr.cz>,
       "Fernando Pablo Lopez-Lezcano" <nando@ccrma.stanford.edu>,
       "Karsten Wiese" <annabellesgarden@yahoo.de>,
       "Gunther Persoons" <gunther_persoons@spymac.com>, emann@mrv.com,
       "Shane Shrybman" <shrybman@aei.ca>,
       "Peter Zijlstra" <peter@programming.kicks-ass.net>
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 08 Nov 2004 14:15:37.0144 (UTC) FILETIME=[6B268380:01C4C59D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
>
> i have released the -V0.7.20 Real-Time Preemption patch, which can be
> downloaded from the usual place:
>
>    http://redhat.com/~mingo/realtime-preempt/
>

I'm seeing many of these on dmesg, almost everytime a module is getting
loaded:

BUG: sleeping function called from invalid context insmod(1357) at
kernel/rt.c:1322
in_atomic():1 [00000001], irqs_disabled():1
 [<c0105040>] dump_stack+0x23/0x25 (20)
 [<c0116026>] __might_sleep+0xbc/0xcf (36)
 [<c01321d1>] __spin_lock+0x38/0x57 (24)
 [<c013220d>] _spin_lock+0x1d/0x1f (16)
 [<c0145386>] kmem_cache_alloc+0x3f/0xfe (32)
 [<c01358ff>] use_module+0xa8/0x13a (32)
 [<c01363db>] resolve_symbol+0x79/0x8c (40)
 [<c0136a1d>] simplify_symbols+0xc4/0xfe (44)
 [<c013779b>] load_module+0x64f/0x989 (144)
 [<c0137b2c>] sys_init_module+0x57/0x23d (32)
 [<c0104201>] sysenter_past_esp+0x52/0x71 (-8124)
---------------------------
| preempt count: 00000002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<c013637f>] .... resolve_symbol+0x1d/0x8c
.....[<c0136a1d>] ..   ( <= simplify_symbols+0xc4/0xfe)
.. [<c0133cdf>] .... print_traces+0x1b/0x54
.....[<c0105040>] ..   ( <= dump_stack+0x23/0x25)


Another critical issue is that USB is not working properly; the ohci_hcd
module gets loaded but devices don't get listed by lsusb at all, which I
think is a "bonus" from upstream 2.6.9-rc1-mm3.

In fact I think -mm3 is breaking many things around here, at least on my
laptop; another notorious is my wifi stuff (linux-wlan-ng/prism2_cs) now
failing due to unresolved symbols, such as these:

prism2_cs: Unknown symbol p80211netdev_rx
prism2_cs: Unknown symbol register_wlandev
prism2_cs: Unknown symbol wlan_unsetup
prism2_cs: Unknown symbol unregister_wlandev
prism2_cs: Unknown symbol p80211netdev_hwremoved
prism2_cs: Unknown symbol wlan_setup
prism2_cs: Unknown symbol p80211skb_rxmeta_attach

But I guess this is off-topic by now.

Take care.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org


