Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261496AbVFCS5D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261496AbVFCS5D (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 14:57:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261502AbVFCS5C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 14:57:02 -0400
Received: from fmr24.intel.com ([143.183.121.16]:28801 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S261496AbVFCS4n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 14:56:43 -0400
Date: Fri, 3 Jun 2005 11:56:04 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Andi Kleen <ak@muc.de>
Cc: YhLu <YhLu@tyan.com>, Ashok Raj <ashok.raj@intel.com>,
       linux-kernel@vger.kernel.org, suresh.b.siddha@intel.com
Subject: Re: 2.6.12-rc5 is broken in nvidia Ck804 Opteron MB/with dual cor e dual way
Message-ID: <20050603115604.B29609@unix-os.sc.intel.com>
References: <3174569B9743D511922F00A0C94314230A403985@TYANWEB> <20050603160932.GH1683@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050603160932.GH1683@muc.de>; from ak@muc.de on Fri, Jun 03, 2005 at 06:09:32PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2005 at 06:09:32PM +0200, Andi Kleen wrote:
> On Thu, Jun 02, 2005 at 01:42:00PM -0700, YhLu wrote:
> > 
> > for Intel it would be 
> > 	c->x86_num_cores  is 2 and smp_num_siblings is 2 too....
> > 	so every core will be HT....
> 
> If that was true, then a true DC+HT machine would report 4.
> 
> I doubt it is, but Suresh can probably clarify.

On  a DC+HT, x86_num_cores will be 2 and kernel will set smp_num_siblings 
to 2 (even though number of logical processors per physical package as
seen by cpuid.1.EBX.bits[23:16] will be 4).
Remember, smp_num_siblings in kernel will just represent HT logical siblings.

If CPU is just DC capable, cpuid.1.EBX.bits[23:16] will return '2' and
number of cores computation from cpuid.4.EAX.bits[31:26] will be 2. 
And kernel will set x86_num_cores to 2 and smp_num_siblings will be set to 1

If CPU is just HT capable,cpuid.1.EBX.bits[23:16] will return '2' and
number of cores computation from cpuid.4.EAX.bits[31:26] will be 1.
And kernel will set x86_num_cores to 1 and smp_num_siblings will be set to 2.

> > Function 0000_0001[EBX]
> > EBX[23:16] Logical Processor Count. If CPUID Fn[8000_0001, 0000_0001][EDX:
> > HTT, ECX:
> > CMPLegacy] = 11b, then this field indicates the number of CPU cores in the
> > processor.
> > Otherwise, this field is reserved.
> > 
> > what is intel value about cpuid(1) ebx [23:16], when the CPU is dual core,
> > but HT is disabled.
> > 1?

If CPU is DC+HT capable, but HT is disabled in bios, cpuid.1.EBX.bits[23:16] 
will still be 4 and during bootup, kernel will figure out that no HT
siblings came up and will reset smp_num_siblings to 1.

I am planning to do more cleanup post 2.6.12, so that smp_num_siblings will
be moved to per cpuinfo.

thanks,
suresh
