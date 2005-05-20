Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261276AbVETWkF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261276AbVETWkF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 18:40:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261467AbVETWkF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 18:40:05 -0400
Received: from fmr18.intel.com ([134.134.136.17]:65455 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S261276AbVETWjv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 18:39:51 -0400
Message-Id: <20050520221622.124069000@csdlinux-2.jf.intel.com>
Date: Fri, 20 May 2005 15:16:22 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: ak@muc.de
Cc: zwane@arm.linux.org.uk, discuss@x86-64.org, shaohua.li@intel.com,
       linux-kernel@vger.kernel.org
Subject: [patch 0/4] CPU hot-plug support for x86_64
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi

Attached are patches that would apply over 2.6.12-rc4-mm2 to provide
cpu hotplug support. It seems to hold up to stress (make -j's) on a 4way
HT system)

FYI: Iam sending this via quilt mail, hopefully it makes its way ok, 
otherwise please pardon, and i will resend my usuall way again if this 
doesn't work.

- I tested with booting maxcpus=1, then you can kick each cpu online.
  * I also manually migrate interrupts to the new CPU, and ensure they are off
    when that same cpu is being offlined.
  * Seems to have trouble with CONFIG_SCHED_SMT, i need to look into this
    later.
- Offline works as well

Andi: You had mentioned that you would not prefer to replace the broadcast IPI
      with the mask version for performance. Currently this seems to be the
	  most optimal way without putting a sledge hammer on the cpu_up process.

	  If there are any known performance issues that we are worried about
	  we should look for alternative mechanism. 

TBD: 
0. Verify with CONFIG_NUMA (not done yet)
1. ACPI integration for physical cpu hotplug support.
2. replace fixup_irqs() with a correct implementation. This works fine for now
   but has potential to miss interrupts. (in works).


Cheers,
Ashok Raj
