Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751714AbWGZRQi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751714AbWGZRQi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 13:16:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751715AbWGZRQh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 13:16:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:53918 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751712AbWGZRQg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 13:16:36 -0400
Date: Wed, 26 Jul 2006 10:09:46 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Dave Jones <davej@redhat.com>
cc: Arjan van de Ven <arjan@linux.intel.com>, Ingo Molnar <mingo@elte.hu>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       Ashok Raj <ashok.raj@intel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] Reorganize the cpufreq cpu hotplug locking to not be
 totally bizare
In-Reply-To: <20060726155114.GA28945@redhat.com>
Message-ID: <Pine.LNX.4.64.0607261007530.29649@g5.osdl.org>
References: <200607242023_MC3-1-C5FE-CADB@compuserve.com>
 <Pine.LNX.4.64.0607241752290.29649@g5.osdl.org> <20060725185449.GA8074@elte.hu>
 <1153855844.8932.56.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0607251355080.29649@g5.osdl.org>
 <1153921207.3381.21.camel@laptopd505.fenrus.org> <20060726155114.GA28945@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 26 Jul 2006, Dave Jones wrote:
> 
> Looks sensible to me.   Assuming it passes testing..

It looked sensible to me too, although it still shows some "Lukewarm IQ" 
notices for the ondemand driver:

	Lukewarm IQ detected in hotplug locking
	BUG: warning at kernel/cpu.c:38/lock_cpu_hotplug()
	 [<c0103d07>] show_trace+0xd/0x10
	 [<c01042ec>] dump_stack+0x19/0x1b
	 [<c013778d>] lock_cpu_hotplug+0x43/0x69
	 [<c012f9df>] __create_workqueue+0x52/0x11f
	 [<df0ec34b>] cpufreq_governor_dbs+0x9f/0x2bd [cpufreq_ondemand]
	 [<c0305542>] __cpufreq_governor+0x57/0xd8
	 [<c0305700>] __cpufreq_set_policy+0x13d/0x1a9
	 [<c0305906>] store_scaling_governor+0x12d/0x155
	 [<c0304fbd>] store+0x34/0x45
	 [<c01998fc>] sysfs_write_file+0x99/0xbf
	 [<c0164953>] vfs_write+0xab/0x157
	 [<c0164f8c>] sys_write+0x3b/0x60
	 [<c0102d41>] sysenter_past_esp+0x56/0x79

but is sure looks better than it used to. Which is why I already applied 
it ;)

		Linus
