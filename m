Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262402AbSJ2WR3>; Tue, 29 Oct 2002 17:17:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262410AbSJ2WR3>; Tue, 29 Oct 2002 17:17:29 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:16883 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262402AbSJ2WR2>;
	Tue, 29 Oct 2002 17:17:28 -0500
Message-ID: <3DBF096D.6080703@us.ibm.com>
Date: Tue, 29 Oct 2002 14:19:25 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Erich Focht <efocht@ess.nec.de>
CC: davidm@hpl.hp.com, linux-ia64 <linux-ia64@linuxia64.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] topology for ia64
References: <200210051904.22480.efocht@ess.nec.de> <15796.38594.516266.130894@napali.hpl.hp.com> <200210221123.37145.efocht@ess.nec.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erich Focht wrote:
> On Tuesday 22 October 2002 02:07, David Mosberger wrote:
> 
>>Why does the cpu_to_node_map[] exist for non-NUMA configurations?  It
>>seems to me that it would be better to make cpu_to_node_map a macro
>>that uses an array-check for NUMA configurations and a simple test
>>against phys_cpu_present_map() for non-NUMA.
> 
> Attached is a modified patch for implementing the topology stuff on ia64.
> It's on top of your 2.5.39 tree including acpi_numa and the acpi_numa fix
> which I've sent you separately.
> 
> I dropped the cpu_to_node_map array for the non-NUMA case. The macro
> __cpu_to_node() returns 0 in this case. In the places where it is used
> (e.g. in the NUMA scheduler) we either run on a valid CPU or have
> cpu_online() checks before using it, therefore I also removed the
> phys_cpu_present_map check when building the cpu to node map.

Hi Erich!  Apologies for the long response delay...  I think our mail 
server must be a bit lagged.  ;)

It looks good to me.  As far as this comment:
+/*
+ * Returns the number of the first CPU on Node 'node'.
+ * Slow in the current implementation.
+ * Who needs this?
+ */
+/* #define __node_to_first_cpu(node) pool_cpus[pool_ptr[node]] */
+static inline int __node_to_first_cpu(int node)

No one is using it now.  I think that I will probably deprecate this 
function in the near future as it is pretty useless.  Anyone looking for 
that functionality can just do an __ffs(__node_to_cpu_mask(node)) 
instead, and hope that there is a reasonably quick implementation of 
__node_to_cpu_mask.


> Hope this can be included now...

I agree!  Linus or another maintainer, please pick this up.  These 
macros should be implemented intelligently on as many architectures as 
possible, now that they're beginning to be used in more and more places.

Cheers!

-Matt

> 
> Regards,
> Erich
 >
 > <patch snip>
 >

