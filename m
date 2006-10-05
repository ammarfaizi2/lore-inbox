Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750760AbWJELQ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbWJELQ1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 07:16:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750765AbWJELQ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 07:16:27 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:6110 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750760AbWJELQ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 07:16:27 -0400
Message-ID: <4524E983.6010208@garzik.org>
Date: Thu, 05 Oct 2006 07:16:19 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Heiko Carstens <heiko.carstens@de.ibm.com>
CC: Cornelia Huck <cornelia.huck@de.ibm.com>, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Ashok Raj <ashok.raj@intel.com>, Nathan Lynch <nathanl@austin.ibm.com>
Subject: Re: [PATCH] drivers/base: error handling fixes
References: <20061004130554.GA25974@havoc.gtf.org> <20061004172434.1a2ddb71@gondolin.boeblingen.de.ibm.com> <20061005081705.GA6920@osiris.boeblingen.de.ibm.com>
In-Reply-To: <20061005081705.GA6920@osiris.boeblingen.de.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Heiko Carstens wrote:
> On Wed, Oct 04, 2006 at 05:24:34PM +0200, Cornelia Huck wrote:
>> On Wed, 4 Oct 2006 09:05:54 -0400,
>> Jeff Garzik <jeff@garzik.org> wrote:
>>
>>>  static int __cpuinit topology_cpu_callback(struct notifier_block *nfb,
>>> @@ -112,17 +110,18 @@ static int __cpuinit topology_cpu_callba
>>>  {
>>>  	unsigned int cpu = (unsigned long)hcpu;
>>>  	struct sys_device *sys_dev;
>>> +	int rc = 0;
>>>  
>>>  	sys_dev = get_cpu_sysdev(cpu);
>>>  	switch (action) {
>>>  	case CPU_ONLINE:
>>> -		topology_add_dev(sys_dev);
>>> +		rc = topology_add_dev(sys_dev);
>>>  		break;
>>>  	case CPU_DEAD:
>>>  		topology_remove_dev(sys_dev);
>>>  		break;
>>>  	}
>>> -	return NOTIFY_OK;
>>> +	return rc ? NOTIFY_BAD : NOTIFY_OK;
>>>  }
>> Wouldn't that also require that _cpu_up checked the return code when
>> doing CPU_ONLINE notification (and clean up on error)?
> 
> After all code that gets a CPU_ONLINE notification is not supposed to fail.
> For allocating resources while bringing up a cpu CPU_UP_PREPARE is supposed
> to be used. That one is allowed to fail.

It's a bug no matter how you look at it... I just lessen the impact.  :)

If someone wants to provide a better fix, let's see the patch...

	Jeff



