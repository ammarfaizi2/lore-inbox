Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932397AbWCMTyj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932397AbWCMTyj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 14:54:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932403AbWCMTyj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 14:54:39 -0500
Received: from smtp.osdl.org ([65.172.181.4]:59347 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932397AbWCMTyi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 14:54:38 -0500
Date: Mon, 13 Mar 2006 11:51:55 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ashok Raj <ashok.raj@intel.com>
Cc: olel@ans.pl, venkatesh.pallipadi@intel.com, linux-kernel@vger.kernel.org,
       ashok.raj@intel.com, suresh.b.siddha@intel.com, rajesh.shah@intel.com
Subject: Re: More than 8 CPUs detected and CONFIG_X86_PC cannot handle it on
 2.6.16-rc6
Message-Id: <20060313115155.24dfb6f3.akpm@osdl.org>
In-Reply-To: <20060313113615.A24797@unix-os.sc.intel.com>
References: <Pine.LNX.4.64.0603120256480.14567@bizon.gios.gov.pl>
	<20060311210353.7eccb6ed.akpm@osdl.org>
	<Pine.LNX.4.64.0603121202540.31039@bizon.gios.gov.pl>
	<20060312032523.109361c1.akpm@osdl.org>
	<Pine.LNX.4.64.0603121359540.31039@bizon.gios.gov.pl>
	<20060312073524.A9213@unix-os.sc.intel.com>
	<Pine.LNX.4.64.0603122206110.19689@bizon.gios.gov.pl>
	<20060312143053.530ef6c9.akpm@osdl.org>
	<20060313113615.A24797@unix-os.sc.intel.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ashok Raj <ashok.raj@intel.com> wrote:
>
> When CONFIG_HOTPLUG_CPU is turned on we always use physflat mode (bigsmp) even 
>  when #of CPUs are less than 8 to avoid sending IPI to offline processors.
> 
>  Without having BIGSMP on it spits out a warning during boot on systems that
>  seems misleading, since it complains even on systems that have less
>  than 8 cpus.
> 
> ...
>
>  --- linux-2.6.16-rc6-mm1.orig/arch/i386/Kconfig
>  +++ linux-2.6.16-rc6-mm1/arch/i386/Kconfig
>  @@ -760,7 +760,7 @@ config PHYSICAL_START
>   
>   config HOTPLUG_CPU
>   	bool "Support for hot-pluggable CPUs (EXPERIMENTAL)"
>  -	depends on SMP && HOTPLUG && EXPERIMENTAL && !X86_VOYAGER
>  +	depends on SMP && HOTPLUG && EXPERIMENTAL && !X86_VOYAGER && (X86_GENERICARCH || X86_BIGSMP)
>   	---help---
>   	  Say Y here to experiment with turning CPUs off and on.  CPUs
>   	  can be controlled through /sys/devices/system/cpu.

One of the main reasons for turning on CONFIG_HOTPLUG_CPU on x86 is
actually for suspend-to-disk on SMP.  I don't think it's desirable to force
all those little machines to use X86_GENERICARCH || X86_BIGSMP.  And it'd
be good to make that warning go away for 2.6.16.
