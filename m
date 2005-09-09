Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030247AbVIIRBr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030247AbVIIRBr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 13:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030254AbVIIRBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 13:01:46 -0400
Received: from fsmlabs.com ([168.103.115.128]:38077 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S1030247AbVIIRBq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 13:01:46 -0400
Date: Fri, 9 Sep 2005 10:07:28 -0700 (PDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Ashok Raj <ashok.raj@intel.com>
cc: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch 13/14] x86_64: Use common functions in cluster and physflat
 mode
In-Reply-To: <20050906161215.B19592@unix-os.sc.intel.com>
Message-ID: <Pine.LNX.4.61.0509091003490.978@montezuma.fsmlabs.com>
References: <200509032135.j83LZ8gX020554@shell0.pdx.osdl.net>
 <20050905231628.GA16476@muc.de> <20050906161215.B19592@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Sep 2005, Ashok Raj wrote:

> On Tue, Sep 06, 2005 at 01:16:28AM +0200, Andi Kleen wrote:
> > On Sat, Sep 03, 2005 at 02:33:30PM -0700, akpm@osdl.org wrote:
> > > 
> > > From: Ashok Raj <ashok.raj@intel.com>
> > > 
> > > Newly introduced physflat_* shares way too much with cluster with only a very
> > > differences.  So we introduce some common functions in that can be reused in
> > > both cases.

On a slightly different topic, how come we're using physflat for hotplug 
cpu?

-#ifndef CONFIG_CPU_HOTPLUG
 		/* In the CPU hotplug case we cannot use broadcast mode
 		   because that opens a race when a CPU is removed.
-		   Stay at physflat mode in this case.
-		   It is bad to do this unconditionally though. Once
-		   we have ACPI platform support for CPU hotplug
-		   we should detect hotplug capablity from ACPI tables and
-		   only do this when really needed. -AK */
+		   Stay at physflat mode in this case. - AK */
+#ifdef CONFIG_HOTPLUG_CPU
 		if (num_cpus <= 8)
 			genapic = &apic_flat;

Thanks,
	Zwane

