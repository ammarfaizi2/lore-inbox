Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275183AbRIZOBt>; Wed, 26 Sep 2001 10:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275203AbRIZOBk>; Wed, 26 Sep 2001 10:01:40 -0400
Received: from curlew.cs.man.ac.uk ([130.88.13.7]:54286 "EHLO
	curlew.cs.man.ac.uk") by vger.kernel.org with ESMTP
	id <S275183AbRIZOB0>; Wed, 26 Sep 2001 10:01:26 -0400
Date: Wed, 26 Sep 2001 15:01:50 +0100
From: John Levon <moz@compsoc.man.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: EXPORT_SYMBOL(local_apic_enabled);
Message-ID: <20010926150150.B4276@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.19i
X-Url: http://www.movement.uklinux.net/
X-Record: Truant - Neither Work Nor Leisure
X-Toppers: N/A
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


My module needs use of the local APIC for performance counter setup.

Currently I am detecting the various ways it can be enabled/disabled as follows :

static int __init apic_needs_setup(void)
{
        return
/* if enabled, the kernel has already set it up */
#ifdef CONFIG_X86_UP_APIC
        0 &&
#else
/* 2.4.10 and above do the necessary setup */
#if LINUX_VERSION_CODE > KERNEL_VERSION(2,4,9)
        0 &&
#else
/* otherwise, we detect SMP hardware via the MP table */
        !smp_hardware &&
#endif /* 2.4.10 */
#endif /* CONFIG_X86_UP_APIC */
        smp_num_cpus == 1;
}

this is obviously ugly, and more importantly fails when passing noapic,nosmp etc.
as boot options.

How would people feel about exporting a flag for local APIC setup that modules can look at ?
If it's OK I'll send a patch.

My module is not the only one that needs this (e.g. the APIC timers module)

regards
john

-- 
"Khendon's Law: If the same point is made twice by the same person,
 the thread is over."
