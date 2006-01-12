Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030420AbWALPus@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030420AbWALPus (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 10:50:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751408AbWALPus
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 10:50:48 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:4519 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751403AbWALPur (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 10:50:47 -0500
Message-ID: <43C67ACF.5000600@us.ibm.com>
Date: Thu, 12 Jan 2006 10:50:39 -0500
From: "Mike D. Day" <ncmike@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Macintosh/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: Greg KH <greg@kroah.com>, xen-devel@lists.xensource.com,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [Xen-devel] Re: [RFC] [PATCH] sysfs support for Xen attributes
References: <43C53DA0.60704@us.ibm.com> <20060111230704.GA32558@kroah.com>	 <43C5A199.1080708@us.ibm.com> <20060112005710.GA2936@kroah.com>	 <43C5B59C.8050908@us.ibm.com>	 <1137057022.5397.7.camel@localhost.localdomain>	 <43C66D12.5090503@us.ibm.com> <1137079724.5397.29.camel@localhost.localdomain>
In-Reply-To: <1137079724.5397.29.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:

>>Debugging is always a good reason :) but I'm specifically thinking of 
>>systems management tools, deployment of virtual machines, and migration. 
>>All of these attributes are important for tools that manage, deploy, or 
>>migrate.
> 
> 
> -ETOOMANYBUZZWORDS :)

How is this helping to reach consensus?

> One concern I have with this approach is that it is for things for which
> a need is _anticipated_, instead of things that are actually needed.  It
> is awesome that this is being done in advance, but you have to be
> careful not to throw the kitchen sink at the problem from the beginning.

I've got 2 problems with this comment. First, these things are actually 
needed. VMWare has tools that deploy, manage, and migrate virtual 
machines, PHYP does as well (it can't migrate partitions). Xen really 
needs tools that do the same. It would be best if these tools are 
open-source themselves and use GPL'd code to get the necessary 
information from xen. If you try to use xen I think you will agree.

My second problem with this comment the implication that anticipating 
needs is bad. I understand your argument but disagree on the kitchen 
sink comment.

> Would a potential workload manager contact the individual Xen partitions
> in order to get an overview of the entire machine?  Why would it not
> simply contact the controlling partition?

Not sure what you mean by controlling partition. Xen doesn't have a 
hardware management console like PHYP does. Xen management tools need to 
run on a regular linux kernel that is running within a domain. Usually 
this is the first domain created, aka domain 0.

So to answer your question, of course a "workload manager" would contact 
  domain 0. But how does domain 0 obtain an overview of the entire 
machine so it can relay that info back to the "workload manager"? Domain 
0  has to get the attributes from the hypervisor. How does it do that? 
The best way is to read attributes from sysfs.


-- 

Mike D. Day
STSM and Architect, Open Virtualization
IBM Linux Technology Center
ncmike@us.ibm.com
