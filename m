Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030415AbWD1OwK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030415AbWD1OwK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 10:52:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030418AbWD1OwK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 10:52:10 -0400
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:5572 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S1030415AbWD1OwI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 10:52:08 -0400
In-Reply-To: <20060427214357.4eacd58f.akpm@osdl.org>
References: <20060428001758.GA18917@kroah.com> <Pine.LNX.4.44.0604272328380.5047-100000@gate.crashing.org> <20060427214357.4eacd58f.akpm@osdl.org>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <DE38C452-B9E4-4365-8DC1-39B19BAEE772@kernel.crashing.org>
Cc: greg@kroah.com, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH][UPDATE] PCI: Add pci_assign_resource_fixed -- allow fixed address assignments
Date: Fri, 28 Apr 2006 09:52:02 -0500
To: Andrew Morton <akpm@osdl.org>
X-Mailer: Apple Mail (2.749.3)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - nommos.sslcatacombnetworking.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.crashing.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Apr 27, 2006, at 11:43 PM, Andrew Morton wrote:

> Kumar Gala <galak@kernel.crashing.org> wrote:
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 2329f94..955a96e 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -947,6 +947,9 @@ EXPORT_SYMBOL_GPL(pci_intx);
>>  EXPORT_SYMBOL(pci_set_dma_mask);
>>  EXPORT_SYMBOL(pci_set_consistent_dma_mask);
>>  EXPORT_SYMBOL(pci_assign_resource);
>> +#ifdef CONFIG_EMBEDDED
>> +EXPORT_SYMBOL(pci_assign_resource_fixed);
>> +#endif
>
> This is a good argument for putting the export at the definition  
> site ;)
>
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -496,6 +496,9 @@ int pci_set_dma_mask(struct pci_dev *dev
>>  int pci_set_consistent_dma_mask(struct pci_dev *dev, u64 mask);
>>  void pci_update_resource(struct pci_dev *dev, struct resource  
>> *res, int resno);
>>  int pci_assign_resource(struct pci_dev *dev, int i);
>> +#ifdef CONFIG_EMBEDDED
>> +int pci_assign_resource_fixed(struct pci_dev *dev, int i);
>> +#endif
>
> Debatable - if we omit the ifdefs, it fails at link time or depmod  
> time.
> The ifdefs will make it warn (but not fail) at compile-time.  Given  
> that
> the warning is non-fatal, the ifdefs don't add much value and are best
> omitted.

I'll make these changes.  I didn't care for the ifdef in the header  
but was following the example already in it for isa_bridge.

- k

