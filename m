Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266031AbUA1QMX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 11:12:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266033AbUA1QMX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 11:12:23 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:47054 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S266031AbUA1QMV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 11:12:21 -0500
In-Reply-To: <40157552.3040405@pobox.com>
References: <200401262002.i0QK2iAH031857@hera.kernel.org> <40157552.3040405@pobox.com>
Mime-Version: 1.0 (Apple Message framework v612)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <15D09760-51A9-11D8-AF96-000A95A0560C@us.ibm.com>
Content-Transfer-Encoding: 7bit
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       francis.wiran@hp.com, Greg KH <greg@kroah.com>
From: Hollis Blanchard <hollisb@us.ibm.com>
Subject: Re: [PATCH] cpqarray update
Date: Wed, 28 Jan 2004 09:46:06 -0600
To: Jeff Garzik <jgarzik@pobox.com>
X-Mailer: Apple Mail (2.612)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 26, 2004, at 2:15 PM, Jeff Garzik wrote:

> Linux Kernel Mailing List wrote:
>> ChangeSet 1.1288, 2004/01/26 16:58:21-02:00, francis.wiran@hp.com
>> @@ -616,7 +623,7 @@
>>   	/* detect controllers */
>>  	printk(DRIVER_NAME "\n");
>> -	pci_register_driver(&cpqarray_pci_driver);
>> +	pci_module_init(&cpqarray_pci_driver);
>>  	cpqarray_eisa_detect();
>>   	for(i=0; i< MAX_CTLR; i++) {
>
> You need to check the return value of pci_module_init() for errors.

I'm defining a new bus and had copied pci_module_init() to 
vio_module_init(). Here's what Greg KH had to say about that:
> Eeek!  I want to fix that code in pci_module_init() so it doesn't do
> this at all.  Please don't copy that horrible function.  Just register
> the driver with a call to vio_register_driver() and drop the whole
> vio_module_init() completly.  I'll be doing that for pci soon, and
> there's no reason you want to duplicate this broken logic (you always
> want your module probe to succeed, for lots of reasons...)

So there's no need for the quoted patch hunk at all.

-- 
Hollis Blanchard
IBM Linux Technology Center

