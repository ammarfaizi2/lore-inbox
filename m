Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262578AbTCITZZ>; Sun, 9 Mar 2003 14:25:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262579AbTCITZY>; Sun, 9 Mar 2003 14:25:24 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:32786 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262578AbTCITZX>; Sun, 9 Mar 2003 14:25:23 -0500
Date: Sun, 9 Mar 2003 19:35:59 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.64-bk[2-4]: CONFIG_CPU_FREQ_24_API breaks kernel/cpufreq.c compile
Message-ID: <20030309193559.A26266@flint.arm.linux.org.uk>
Mail-Followup-To: "Adam J. Richter" <adam@yggdrasil.com>,
	linux-kernel@vger.kernel.org
References: <200303091917.LAA02587@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200303091917.LAA02587@adam.yggdrasil.com>; from adam@yggdrasil.com on Sun, Mar 09, 2003 at 11:17:29AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 09, 2003 at 11:17:29AM -0800, Adam J. Richter wrote:
> 	linux-2.5.64-bk2 added the following lines to
> cpufreq_add_dev in kernel/cpufreq.c:
> 
> #ifdef CONFIG_CPU_FREQ_24_API
>         cpu_min_freq[cpu] = cpufreq_driver->policy[cpu].cpuinfo.min_freq;
>         cpu_max_freq[cpu] = cpufreq_driver->policy[cpu].cpuinfo.max_freq;
>         cpu_cur_freq[cpu] = cpufreq_driver->cpu_cur_freq[cpu];
> #endif
> 
> 
> 	However, cpu_{min,max,cur}_freq are static variables in
> drivers/cpufreq/userspace.c.  Making the variables global is not a
> sufficient fix, because drivers/cpufreq/userspace.c can be built as
> separate module.  So, I guess the variables should be moved to
> kernel/cpufreq.c or the code that I quoted above should somehow be
> moved.

Yes, a known problem.  Please note that Dominik no longer maintains
CPUfreq, please don't copy him with reports anymore.

The above is a result of a mismerge between the CPUfreq bits Dominik
sent me and the bits Dominik sent Linus.  Dominik left a set of seven
patches which need to go in, which davej took care of, but afaik Linus
hasn't accepted them (in fact, Linus has been quiet on the subject.)
Since davej has taken these patches under his wing, I'm not intending
pushing the patches to Linus.

So, this poses us with a small problem...  will it remain broken for
2.5.65 or will Linus merge the required patches...

I'll forward the patches to LKML in a moment.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

