Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751112AbVIGRTf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751112AbVIGRTf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 13:19:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751116AbVIGRTf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 13:19:35 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:4237 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751112AbVIGRTe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 13:19:34 -0400
Date: Wed, 7 Sep 2005 22:47:56 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Nish Aravamudan <nish.aravamudan@gmail.com>
Cc: Bill Davidsen <davidsen@tmr.com>, Con Kolivas <kernel@kolivas.org>,
       linux-kernel@vger.kernel.org, akpm@osdl.org,
       ck list <ck@vds.kolivas.org>, rmk+lkml@arm.linux.org.uk
Subject: Re: [PATCH 1/3] dynticks - implement no idle hz for x86
Message-ID: <20050907171756.GB28387@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <200509031801.09069.kernel@kolivas.org> <20050903090650.B26998@flint.arm.linux.org.uk> <200509031814.49666.kernel@kolivas.org> <20050904201054.GA4495@us.ibm.com> <20050904212616.B11265@flint.arm.linux.org.uk> <20050905053225.GA4294@in.ibm.com> <20050905054813.GC25856@us.ibm.com> <20050905063229.GB4294@in.ibm.com> <431F11FF.2000704@tmr.com> <29495f1d0509070942688059a6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29495f1d0509070942688059a6@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2005 at 09:42:24AM -0700, Nish Aravamudan wrote:
> Hrm, got dropped from the Cc... :) Yes, the dynamic-tick generic
> infrastructure being proposed, with the idle CPU mask and the
> set_all_cpus_idle() tick_source hook, would allow exactly this in
> arch-specific code.

I think Bill is referring to the "resume" interface i.e an
unset_all_cpus_idle() interface, which is missing (set/unset
probably are not good prefixes maybe?). I feel we can
add one.

> Is there a generic location where the all-idle state is entered?

Should be from the place where the last cpu is set in the bitmap
and bitmap is found equal to cpu_online_map.

> Currently, I think we can do it via the generic reprogram() routine
> checking the mask and then calling set_all_cpus_idle(), if
> appropriate, after reprogramming the last idle CPU.

So are you saying that setting of the CPU in the bitmap will be done
inside reprogram_timer routine? If we consider that reprogram_timer can 
directly point to a routine in a interrupt source file (like apic.c/timer_pit.c)
I dont think that it is the right place to set bits in the nohz_cpu_mask.
It can be done by the callee of reprogram_timer itself.

-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
