Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751233AbVKATvG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233AbVKATvG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 14:51:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751231AbVKATvG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 14:51:06 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:36769 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751233AbVKATvF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 14:51:05 -0500
Subject: Re: 2.6.14-git3: scheduling while atomic from cpufreq on Athlon64
From: Lee Revell <rlrevell@joe-job.com>
To: Ashok Raj <ashok.raj@intel.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Dave Jones <davej@codemonkey.org.uk>,
       Ingo Molnar <mingo@elte.hu>, linux@brodo.de,
       venkatesh.pallipadi@intel.com
In-Reply-To: <20051101111417.A31379@unix-os.sc.intel.com>
References: <200510311606.36615.rjw@sisk.pl>
	 <200510312045.32908.rjw@sisk.pl>
	 <20051031124216.A18213@unix-os.sc.intel.com>
	 <200511012007.19762.rjw@sisk.pl>
	 <20051101111417.A31379@unix-os.sc.intel.com>
Content-Type: text/plain
Date: Tue, 01 Nov 2005 14:49:29 -0500
Message-Id: <1130874570.22089.11.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-01 at 11:14 -0800, Ashok Raj wrote:
> On Tue, Nov 01, 2005 at 08:07:19PM +0100, Rafael J. Wysocki wrote:
> > Hi,
> > 
> > > of taking cpucontrol lock in __cpufreq_driver_target().
> > 
> > Yes, that's it.
> > 
> > > The reason is we now enter the same code path from the cpu_up() and cpu_down()
> > > generated cpu notifier callbacks and ends up trying to lock when the 
> > > call path already has the cpucontrol lock.
> > > 
> > > Its happening because we do set_cpus_allowed() in powernowk8_target().
> > 
> > Unfortunately, powernowk8_target() calls schedule() right after
> > set_cpus_allowed(), so it throws "scheduling while atomic" on every call,
> > because of the preempt_disable()/_enable() around it.
> > 
> > Greetings,
> > Rafael
> > 
> 
> Thanks Rafael,
> 
> could you try this patch instead? I hate to keep these state variables 
> and thats why i went with the preempt approach, too bad it seems it wont
> work for more than just the case you mentioned.
> 
> seems ugly, but i dont find a better looking cure...

It can't possibly be uglier than disabling preemption to work around a
locking bug.

Lee

