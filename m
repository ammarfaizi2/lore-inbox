Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932113AbWC3IbR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113AbWC3IbR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 03:31:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932116AbWC3IbR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 03:31:17 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:47770 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932113AbWC3IbQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 03:31:16 -0500
Date: Thu, 30 Mar 2006 10:30:59 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Ashok Raj <ashok.raj@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [rfc] fix Kconfig, hotplug_cpu is needed for swsusp
Message-ID: <20060330083059.GB8485@elf.ucw.cz>
References: <20060329220808.GA1716@elf.ucw.cz> <20060329144746.358a6b4e.akpm@osdl.org> <20060329150950.A12482@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060329150950.A12482@unix-os.sc.intel.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On St 29-03-06 15:09:51, Ashok Raj wrote:
> On Wed, Mar 29, 2006 at 02:47:46PM -0800, Andrew Morton wrote:
> > Pavel Machek <pavel@ucw.cz> wrote:
> > >
> > > HOTPLUG_CPU is needed on normal PCs, too -- it is neccessary for
> > > software suspend.
> > > 
> > 
> > OK, this will get ugly.  APICs are involved.
> 
> I guess you need only on systems that support >1 cpu right? I doubt you will need
> it on a system that cannot run with the config-generic-arch on. although we use bigsmp 
> when hotplug is turned on, all we really end up is using flat physical mode instead
> of using logical mode.
> 
> I still havent understood why this wont work. Choosing CONFIG_X86_GENERICARCH shouldnt
> break anything AFAICT.

If X86_GENERICARCH is not breaking anything, why does X86_PC exist? If
you say X86_GENERICARCH is okay for everyone, at least help texts need
to be fixed.

config X86_PC
        bool "PC-compatible"
        help
          Choose this option if your computer is a standard PC or compatible.
 
config X86_BIGSMP
        bool "Support for other sub-arch SMP systems with more than 8 CPUs"
        depends on SMP
        help
          This option is needed for the systems that have more than 8 CPUs
          and if the system is not of any sub-arch type above.

          If you don't have such a system, you should say N here.

I certainly have PCtype machine here, and definitely not more than 8 CPUs.

> Pavel, you could use CONFIG_HOTPLUG_CPU, just need to enable X86_GENERICARCH now. 
> Is there a reason you think that wont work? I wish we would revert it for a strong 
> reason that we know will not make hotplug work on certain systems because of this choise
> not that we currently have X86_PC now, and are unwiling to change the config.
> 
> (PS: the word bigsmp although sounds like some large NR_CPUS, its just using a mode that
> permits the system to work from 1 .. >8 cpus. So there is really nothing determental 
> to selecting this.)

At least config texts need to be fixed if you want people to use
X86_BIGSMP. And why keep X86_PC when X86_BIGSMP works as well?

							Pavel
-- 
Picture of sleeping (Linux) penguin wanted...
