Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261897AbVEXI3e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261897AbVEXI3e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 04:29:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261464AbVEXI1n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 04:27:43 -0400
Received: from fmr18.intel.com ([134.134.136.17]:62416 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S261456AbVEXITC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 04:19:02 -0400
Message-Id: <20050524081113.409604000@csdlinux-2.jf.intel.com>
Date: Tue, 24 May 2005 01:11:13 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: ak@muc.de, akpm@osdl.org
Cc: zwane@arm.linux.org.uk, rusty@rustycorp.com.au, vatsa@in.ibm.com,
       shaohua.li@intel.com, linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: [patch 0/4] CPU Hotplug support for X86_64
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Oops: This is correct version: i send from the wrong directory earlier]
[Sorry about that spam... now i thin i know how to use quilt :-)]

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
--
