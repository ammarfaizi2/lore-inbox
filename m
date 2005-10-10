Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750807AbVJJOiP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbVJJOiP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 10:38:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750814AbVJJOiP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 10:38:15 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:9658 "EHLO e36.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750807AbVJJOiO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 10:38:14 -0400
Date: Mon, 10 Oct 2005 10:37:47 -0400
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, anil.s.keshavamurthy@intel.com, davem@davemloft.net,
       prasanna@in.ibm.com
Subject: [PATCH 0/9] Kprobes: scalability enhancements
Message-ID: <20051010143747.GA4389@in.ibm.com>
Reply-To: ananth@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following set of patches are aimed at improving kprobes scalability.
We currently serialize kprobe registration, unregistration and handler
execution using a single spinlock - kprobe_lock.

With these changes, kprobe handlers can run without any locks held.
It also allows for simultaneous kprobe handler executions on different
processors as we now track kprobe execution on a per processor basis.
It is now necessary that the handlers be re-entrant since handlers can
run concurrently on multiple processors.

All changes have been tested on i386, ia64, ppc64 and x86_64, while
sparc64 has been compile tested only.

The patches can be viewed as 3 logical chunks:

patch 1: 	Reorder preempt_(dis/en)able calls
patches 2-7: 	Introduce per_cpu data areas to track kprobe execution
patches 8-9: 	Use RCU to synchronize kprobe (un)registration and handler
		execution.

Thanks to Maneesh Soni, James Keniston and Anil Keshavamurthy for their
review and suggestions. Thanks again to Anil, Hien Nguyen and Kevin Stafford
for testing the patches.

Ananth
