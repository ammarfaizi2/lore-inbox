Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932286AbWBBVfX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932286AbWBBVfX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 16:35:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932291AbWBBVfX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 16:35:23 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:47815 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932286AbWBBVfV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 16:35:21 -0500
Date: Thu, 2 Feb 2006 22:34:50 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Dave Jones <davej@redhat.com>, Chuck Ebbert <76306.1226@compuserve.com>,
       Andrew Morton <akpm@osdl.org>, Ashok Raj <ashok.raj@intel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch -mm4] i386: __init should be __cpuinit
Message-ID: <20060202213450.GA2405@elf.ucw.cz>
References: <200601312352_MC3-1-B748-FCE9@compuserve.com> <20060201053357.GA5335@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060201053357.GA5335@redhat.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>  > When CONFIG_HOTPLUG_CPU on i386 there are places where __init[data] is
>  > referenced from normal code.
>  > 
>  > On startup:
>  >         arch/i386/kernel/cpu/amd.c::amd_init_cpu():
>  >                 cpu_devs[X86_VENDOR_AMD] = &amd_cpu_dev;        
>  >         amd_cpu_dev is declared __initdata and is freed
>  > 
>  > On CPU hotplug:
>  >         arch/i386/kernel/cpu/common.c::get_cpu_vendor():
>  >                for (i = 0; i < X86_VENDOR_NUM; i++) {
>  >                         if (cpu_devs[i]) {
>  >                                 if (!strcmp(v,cpu_devs[i]->c_ident[0]) ||
>  > 
>  > To fix this, change every instance of __init that seems suspicious
>  > into __cpuinit.  When !CONFIG_HOTPLUG_CPU there is no change in .text
>  > or .data size.  When enabled, .text += 3248 bytes; .data += 2148 bytes.
>  > 
>  > This should be safe in every case; the only drawback is the extra code and
>  > data when CPU hotplug is enabled.
> 
> Especially as for the bulk of them, those CPUs aren't hotplug capable.
> (I seriously doubt we'll ever see a hotplugable cyrix for eg, which
>  takes up the bulk of your diff).
> 
> How about leaving it __init on non-hotplug systems, and somehow removing
> those from cpu_devs, so get_cpu_vendor() just skips them ?
> NULL'ing those entries should be just a few bytes, instead of adding 5KB.

We use cpu hotplug system for swsusp; but unless someone makes
cyrix/SMP machine and tries to suspend it, we are ok.

							Pavel
-- 
Thanks, Sharp!
