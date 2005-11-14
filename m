Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750952AbVKNFwe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750952AbVKNFwe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 00:52:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750953AbVKNFwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 00:52:34 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:10882 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750951AbVKNFwe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 00:52:34 -0500
Date: Mon, 14 Nov 2005 11:24:57 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: Zachary Amsden <zach@vmware.com>, virtualization@lists.osdl.org,
       Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Martin Bligh <mbligh@mbligh.org>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>, ananth@in.ibm.com,
       anil.s.keshavamurthy@intel.com, davem@davemloft.net
Subject: Re: [PATCH 19/21] i386 Kprobes semaphore fix
Message-ID: <20051114055457.GA26887@in.ibm.com>
Reply-To: prasanna@in.ibm.com
References: <200511080439.jA84diI6009951@zach-dev.vmware.com> <200511091438.11848.ak@suse.de> <437227FD.6040905@vmware.com> <200511111625.57165.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511111625.57165.ak@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Let me stress that if you are running on modified segment state, you
> > have no way to safely determine the virtual address on which you took an
> > instruction trap (int3, general protection, etc..).  If you can't
> > determine the virtual address safely, you can't back out your code patch
> > to remove the breakpoint.  At this point, you can't execute the next
> 
> Kernel kprobes solves this by executing the code out of line. I don't know
> how they want to do that in user space though (need a safe address for that),
> but somehow that can be likely done.

In case of user space probes we adopt a similar method for executing the code
out-of-line. In user space probes  we find free space in the current
 process address space and copy the original instruction to that location and
 execute that instruction from that location. User processes use stack space
 to store local variables, agruments and return values. Normally the stack
 space either below or above the stack pointer indicates the free stack space.
Also in case of no stack free space, we can expand the process stack, copy the 
instruction and execute the instruction from that location.
Detials about this method is discussed on systemtap mailing lists. URL is below.

http://sourceware.org/ml/systemtap/2005-q3/msg00542.html

Please let me know if you have any other solution to the above problem.

Thanks
Prasanna
-- 
Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Email: prasanna@in.ibm.com
Ph: 91-80-25044636
