Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262289AbSJ2XxS>; Tue, 29 Oct 2002 18:53:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262409AbSJ2XxS>; Tue, 29 Oct 2002 18:53:18 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:21444 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262289AbSJ2XxR>;
	Tue, 29 Oct 2002 18:53:17 -0500
Message-ID: <3DBF1FE3.2050804@us.ibm.com>
Date: Tue, 29 Oct 2002 15:55:15 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michael Hohnbaum <hohnbaum@us.ibm.com>
CC: Erich Focht <efocht@ess.nec.de>, davidm@hpl.hp.com,
       linux-ia64 <linux-ia64@linuxia64.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-ia64] Re: [PATCH] topology for ia64
References: <200210051904.22480.efocht@ess.nec.de>	<15796.38594.516266.130894@napali.hpl.hp.com>	<200210221123.37145.efocht@ess.nec.de>  <3DBF096D.6080703@us.ibm.com> <1035930929.1274.1766.camel@dyn9-47-17-164.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Hohnbaum wrote:
> On Tue, 2002-10-29 at 14:19, Matthew Dobson wrote:
> 
>>Erich Focht wrote:
>>+/*
>>+ * Returns the number of the first CPU on Node 'node'.
>>+ * Slow in the current implementation.
>>+ * Who needs this?
>>+ */
>>+/* #define __node_to_first_cpu(node) pool_cpus[pool_ptr[node]] */
>>+static inline int __node_to_first_cpu(int node)
>>
>>No one is using it now.  I think that I will probably deprecate this 
>>function in the near future as it is pretty useless.  Anyone looking for 
>>that functionality can just do an __ffs(__node_to_cpu_mask(node)) 
>>instead, and hope that there is a reasonably quick implementation of 
>>__node_to_cpu_mask.
> 
> I'm using this in the simple NUMA scheduler.  This is quite useful
> for iterating through a specific node's CPUs.  Yes, the functionality
> can be obtained in a different manner, but is less obvious.

Hmmm...  This is true, but I'd like to keep the topology functions as 
minimal as possible.  Since the functionality is so easily duplicated, 
and in almost every arch, is implemented almost identically, it seems a 
waste.  In most architectures, they itterate across cpus, either 
returning the first one on the node, or adding each to a mask and 
returning that.

Besides, it's not gone yet... ;)

Cheers!

-Matt

