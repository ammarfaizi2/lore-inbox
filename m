Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751092AbWC3ImN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751092AbWC3ImN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 03:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751093AbWC3ImN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 03:42:13 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:8336 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751092AbWC3ImM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 03:42:12 -0500
Date: Thu, 30 Mar 2006 10:41:54 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Ashok Raj <ashok.raj@intel.com>
Cc: Nigel Cunningham <ncunningham@cyclades.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, rjw@sisk.pl
Subject: Re: [rfc] fix Kconfig, hotplug_cpu is needed for swsusp
Message-ID: <20060330084153.GC8485@elf.ucw.cz>
References: <20060329220808.GA1716@elf.ucw.cz> <20060329144746.358a6b4e.akpm@osdl.org> <20060329150950.A12482@unix-os.sc.intel.com> <200603300936.22757.ncunningham@cyclades.com> <20060329154748.A12897@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060329154748.A12897@unix-os.sc.intel.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > So if you have a single core x86, you want X86_PC, and if you have HT or SMP, 
> > you want GENERICARCH? If so, could this be done via selects or depends or at 
> > least defaults in Kconfig?
> 
> Yes, i think only SUSPEND_SMP is affect by this. I thought Rafael cced Pavel during 
> that exchange, maybe i missed.
> 
> > 
> > Regards,
> > 
> > Nigel
> 
> How about this patch.
> 
> Make SUSPEND_SMP depend on X86_GENERICARCH, since hotplug cpu requires !X86_PC 
> due to some race in IPI handling.  See more discussion here
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=114303306032338&w=2

I can't see useful discussion there.

> Index: linux-2.6.16-git16/kernel/power/Kconfig
> ===================================================================
> --- linux-2.6.16-git16.orig/kernel/power/Kconfig
> +++ linux-2.6.16-git16/kernel/power/Kconfig
> @@ -96,5 +96,5 @@ config SWSUSP_ENCRYPT
> 
>  config SUSPEND_SMP
>         bool
> -       depends on HOTPLUG_CPU && X86 && PM
> +       depends on HOTPLUG_CPU && X86 && PM && X86_GENERICARCH
>         default y


Heh, great, so one more magic option that is required.

Plus GENERICARCH does not sound like something normal users would
enable:

config X86_GENERICARCH
       bool "Generic architecture (Summit, bigsmp, ES7000, default)"
       depends on SMP
       help
          This option compiles in the Summit, bigsmp, ES7000, default subarchitectures.
          It is intended for a generic binary kernel.

(What does "default" mean there, anyway? X86_PC?)

								Pavel
-- 
Picture of sleeping (Linux) penguin wanted...
