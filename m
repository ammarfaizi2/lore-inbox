Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267376AbUGVX25@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267376AbUGVX25 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 19:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267375AbUGVX24
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 19:28:56 -0400
Received: from fmr03.intel.com ([143.183.121.5]:3977 "EHLO hermes.sc.intel.com")
	by vger.kernel.org with ESMTP id S266124AbUGVX1G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 19:27:06 -0400
Date: Thu, 22 Jul 2004 16:23:27 -0700
From: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
To: Nathan Lynch <nathanl@austin.ibm.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>,
       Dave Hansen <haveblue@us.ibm.com>,
       "Matthew C. Dobson [imap]" <colpatch@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: sched domains bringup race?
Message-ID: <20040722162327.A27935@unix-os.sc.intel.com>
Reply-To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
References: <1089944026.32312.47.camel@nighthawk> <20040718134559.A25488@unix-os.sc.intel.com> <40FB78D5.1070604@yahoo.com.au> <1090533339.3041.13.camel@booger>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1090533339.3041.13.camel@booger>; from nathanl@austin.ibm.com on Thu, Jul 22, 2004 at 04:55:40PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 22, 2004 at 04:55:40PM -0500, Nathan Lynch wrote:
> On Mon, 2004-07-19 at 02:31, Nick Piggin wrote:
> > Keshavamurthy Anil S wrote:
> > > Even on my system which is Intel 865 chipset (P4 with HT enabled system) 
> > > I see a bug check somewhere in the schedular_tick during boot.
> > > However if I move the sched_init_smp() after do_basic_setup() the
> > > kernel boots without any problem. Any clue here?

  This was happening even without CONFIG_SCHED_SMT and later found to be
ACPI bug. Sorry for the confusion.

> > 
> > There shouldn't be any problem doing that if we have to, obviously we
> > need to know why. Is it possible that cpu_sibling_map, or one of the
> > CPU masks isn't set up correctly at the time of the call?
> 
> In 2.6.8-rc1-mm1 at least, backing this patch out fixed it for me on
> ppc64:
> 
> http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.8-rc1/2.6.8-rc1-mm1/broken-out/detect-too-early-schedule-attempts.patch
> 
> Code with statements of the form:
> 
> if (system_state == SYSTEM_BOOTING)
> 	/* do something boot-specific */
> else
> 	/* do something assuming system_state == SYSTEM_RUNNING */
> 
> is broken by this change.  Parts of the cpu bringup code in arch/ppc64
> do this (and thus need to be fixed if the above change is kept). 
> Chances are there is similar code in some x86 setups.
> 
> Nathan
> 
