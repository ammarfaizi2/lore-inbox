Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265577AbUABN40 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 08:56:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265578AbUABN4Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 08:56:25 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:9112 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265577AbUABNzj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 08:55:39 -0500
Date: Fri, 2 Jan 2004 19:30:26 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org, rusty@au1.ibm.com,
       lhcs-devel@lists.sourceforge.net, jun.nakajima@intel.com,
       asit.k.mallick@intel.com, sunil.saxena@intel.com, torvalds@osdl.org
Subject: Re: [lhcs-devel] Re: in_atomic doesn't count local_irq_disable?
Message-ID: <20040102193026.A19698@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <3FF044A2.3050503@colorfullife.com> <20031230185615.A9292@in.ibm.com> <20031231190553.B9041@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031231190553.B9041@in.ibm.com>; from vatsa@in.ibm.com on Wed, Dec 31, 2003 at 07:05:53PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, Dec 31, 2003 at 07:05:53PM +0530, Srivatsa Vaddagiri wrote:
> More debugging reveals that the page fault happens
> always while doing a prefetch. The prefetch is
> present inside list_for_each_entry macros.
> 
> For now I have disabled the x86 prefetch function
> to do nothing.
> 
> The test seems to run fine so far w/o any of the 
> page faults I was experiencing. Will update
> at the end of the overnight run if I hit the problem again.
> 
> Wonder if prefetch has some issues on Intel x86 (P3) SMP systems?
> 

Even after disabling prefetch, I continue
to hit page-faults. 

With prefetch disabled, it _always_
traps because of trying to dereference a NULL pointer in a
list-head.  If I break-in into the debugger, the 
list-head is actually valid (no NULL pointer is present) and 
hence I don't understand why it read a NULL pointer value in
a list head.

With prefetch enabled it traps
because of fetch from arbitrary (random) addresses.

So I am no longer sure if this is a prefetch issue
or/and a hotplug issue. I'm continuing to investigate
and will post any new observation I make here.

FYI, the /proc/cpuinfo output on my SMP system is as below:

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 10
model name      : Pentium III (Cascades)
stepping        : 1
cpu MHz         : 699.730
cache size      : 1024 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips        : 1376.25

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 10
model name      : Pentium III (Cascades)
stepping        : 1
cpu MHz         : 699.726
cache size      : 1024 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips        : 1396.73


processor       : 2
vendor_id       : GenuineIntel
cpu family      : 6
model           : 10
model name      : Pentium III (Cascades)
stepping        : 1
cpu MHz         : 699.726
cache size      : 1024 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips        : 1396.73


processor       : 3
vendor_id       : GenuineIntel
cpu family      : 6
model           : 10
model name      : Pentium III (Cascades)
stepping        : 1
cpu MHz         : 699.726
cache size      : 1024 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips        : 1396.73





-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
