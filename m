Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262288AbVC2OPu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262288AbVC2OPu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 09:15:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262294AbVC2OPu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 09:15:50 -0500
Received: from indonesia.procaptura.com ([193.214.130.21]:6791 "EHLO
	indonesia.procaptura.com") by vger.kernel.org with ESMTP
	id S262288AbVC2OPi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 09:15:38 -0500
Message-ID: <42496309.3080007@procaptura.com>
Date: Tue, 29 Mar 2005 16:15:37 +0200
From: Toralf Lund <toralf@procaptura.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: insmod segfault in pci_find_subsys()
References: <423A9B65.1020103@procaptura.com> <20050318170709.GD14952@kroah.com>
In-Reply-To: <20050318170709.GD14952@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

>On Fri, Mar 18, 2005 at 10:12:05AM +0100, Toralf Lund wrote:
>  
>
>>Am I seeing an issue with the PCI functions here, or is it just that I 
>>fail to spot an obvious mistake in the module itself?
>>    
>>
>
>I think it's a problem in your code.  I built and ran the following
>example module just fine (based on your example, which wasn't the
>smallest or cleanest...), with no oops.  Does this code work for you?
>  
>
OK, I've finally been able to test this, and no, it does not work. 
insmod segfaults and the system log says

kernel: Unable to handle kernel paging request at virtual address 533e3762



>Oh, and the pci_find* functions are depreciated, do not use them, they
>are going away in the near future.  Please use the pci_get* functions
>instead.
>
>thanks,
>
>greg k-h
>
>-----------------
>#include <linux/pci.h>
>#include <linux/module.h>
>
>MODULE_LICENSE("GPL");
>
>	
>static void __exit exit(void)
>{  
>}
>
>static __init int init(void)
>{
>	struct pci_dev *dev;
> 
>	printk(KERN_DEBUG "Scanning all devices...\n");
> 
>	dev = NULL;
>	while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev))) {
>		printk(KERN_DEBUG "Device %04hx:%04hx\n",
>			dev->vendor, dev->device);
>	}
>	return 0;
>}
>
>module_init(init);
>module_exit(exit);
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>


