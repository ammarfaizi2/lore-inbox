Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751214AbVKATnr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbVKATnr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 14:43:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751218AbVKATnr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 14:43:47 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:27583 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S1751214AbVKATnq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 14:43:46 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-git3: scheduling while atomic from cpufreq on Athlon64
Date: Tue, 1 Nov 2005 20:44:10 +0100
User-Agent: KMail/1.8.2
Cc: Ashok Raj <ashok.raj@intel.com>, Andrew Morton <akpm@osdl.org>,
       Dave Jones <davej@codemonkey.org.uk>, Ingo Molnar <mingo@elte.hu>,
       linux@brodo.de, venkatesh.pallipadi@intel.com
References: <200510311606.36615.rjw@sisk.pl> <200511012007.19762.rjw@sisk.pl> <20051101111417.A31379@unix-os.sc.intel.com>
In-Reply-To: <20051101111417.A31379@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511012044.11548.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 1 of November 2005 20:14, Ashok Raj wrote:
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

It fixes my problem.

Thanks,
Rafael
