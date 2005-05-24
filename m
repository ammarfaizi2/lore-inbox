Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261439AbVEXISJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261439AbVEXISJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 04:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261442AbVEXIQk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 04:16:40 -0400
Received: from fmr20.intel.com ([134.134.136.19]:63379 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S261439AbVEXIOE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 04:14:04 -0400
Message-Id: <20050524075201.351504000@csdlinux-2.jf.intel.com>
Date: Tue, 24 May 2005 00:27:49 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: ak@muc.de, akpm@osdl.org
Cc: zwane@arm.linux.org.uk, rusty@rustycorp.com.au, vatsa@in.ibm.com,
       shaohua.li@intel.com, linux-kernel@vger.kernel.org, discuss@x86-64.org,
       ashok.raj@intel.com
Subject: [patch 0/4] CPU Hotplug support for X86_64
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This implements cpu hotplug support for X86_64. 
Modified after initial feedback from Andi.

[PS: hopefully subject is now fixed with different subject lines]

Seems to hold up for make -j, with online/offline activity.

The series of patches are split as follows:

1. initcall cleanup
	- Left __cpuinit cases as before per Andi
	- Added a few new ones, and removed couple that could stay __init
	  even with cpu hotplug.
2. Core logical online/offline of cpus
	- start with maxcpus=1, and then echo 1 to /sys/devices/system/online
	- Can also bringup all cpus and then bring up/down all but cpu0.
	- Also tested with numa=fake=2
3. Cleanup sibling map for cpu hotplug support.
4. Dont use IPI broadcast in smp_call_function() when using CPU hotplug.
   Hopefully this is some reasonable middle ground starting point.
	- Dont let a new cpu respond to IPI's. 
	- Automaticaly selected if CPU hotplus is choosen. 
	- Can also be turned on cmdline via safe_ipi=1


TBD: 

1. Track down CONFIG_SCHED_SMT Oops with both cpu up/down.
2. Test on real NUMA hw. 


Cheers,
Ashok Raj
