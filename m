Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261595AbSKHIDt>; Fri, 8 Nov 2002 03:03:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266775AbSKHIDt>; Fri, 8 Nov 2002 03:03:49 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:51888 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261595AbSKHIDs>; Fri, 8 Nov 2002 03:03:48 -0500
Date: Fri, 8 Nov 2002 13:53:27 +0530
From: "Vamsi Krishna S ." <vamsi@in.ibm.com>
To: Rusty Lynch <rusty@linux.co.intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Is there a way to interrupt MMIO with kprobes/ltt/etc...
Message-ID: <20021108135327.A12978@in.ibm.com>
Reply-To: vamsi@in.ibm.com
References: <009e01c286d8$2a44e010$77d40a0a@amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <009e01c286d8$2a44e010$77d40a0a@amr.corp.intel.com>; from rusty@linux.co.intel.com on Fri, Nov 08, 2002 at 03:40:58AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 08, 2002 at 03:40:58AM +0000, Rusty Lynch wrote:
> I have been looking into the possible ways a fault injection tool could be
> implemented on the available tools/hooks in the 2.5 kernel.  I can see how
> kprobes would help by allowing me to setup handlers when a specific address
> is executed, but what about when a specific memory mapped IO address is
> touched or looked at?
> 
> I know there has been a lot of activity on kprobes, LTT, and others (isn't
> there something else?).  Do any of these patches allow a handler to be
> called just before some MMIO is accessed?  Messing with architecture
> specific debug registers seems problematic since it makes the solution
> architecture specific and the number of watch points is pretty limited.
> 
You could do this with the interface provided by kwatchpoints patch [1]
without directly mucking with debug registers. The interface is simple:

int register_kwatch(unsigned long addr, u8 length, u8 type,
                kwatch_handler_t handler)

If you don't want to use debug registers or if they are not enough,
only other possibility I can think of is to find all code locations 
where the MMIO space of interest is touched and put execution 
probes there.

[1] You will need these two patches:
http://marc.theaimsgroup.com/?l=linux-kernel&m=103528454215523&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=103528454015520&w=2

Cheers,
Vamsi.
-- 
Vamsi Krishna S.
Linux Technology Center,
IBM Software Lab, Bangalore.
Ph: +91 80 5044959
Internet: vamsi@in.ibm.com
