Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265089AbUFBIwo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265089AbUFBIwo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 04:52:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265187AbUFBIwo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 04:52:44 -0400
Received: from [213.239.201.226] ([213.239.201.226]:64994 "EHLO
	mail.shadowconnect.com") by vger.kernel.org with ESMTP
	id S265089AbUFBIwl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 04:52:41 -0400
Message-ID: <40BD96E3.20903@shadowconnect.com>
Date: Wed, 02 Jun 2004 10:59:15 +0200
From: Markus Lidel <Markus.Lidel@shadowconnect.com>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Davide Rossetti <davide.rossetti@roma1.infn.it>
CC: linux-kernel@vger.kernel.org
Subject: Re: Problem with ioremap which returns NULL in 2.6 kernel
References: <40BC788A.3020103@shadowconnect.com> <20040601142122.GA7537@havoc.gtf.org> <40BC9EF7.4060502@shadowconnect.com> <40BCB821.5050903@roma1.infn.it>
In-Reply-To: <40BCB821.5050903@roma1.infn.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Davide Rossetti wrote:
>>>> could someone help me with a ioremap problem. If there are two 
>>>> controllers plugged in, the ioremap request for the first controller 
>>>> is successfull, but the second returns NULL. Here is the output of 
>>>> the driver:
>>>> i2o: Checking for PCI I2O controllers...
>>>> i2o: I2O controller on bus 0 at 72.
>>>> i2o: PCI I2O controller at 0xD0000000 size=134217728
>>>> I2O: MTRR workaround for Intel i960 processor
>>>> i2o/iop0: Installed at IRQ17
>>>> i2o: I2O controller on bus 0 at 96.
>>>> i2o: PCI I2O controller at 0xD8000000 size=134217728
>>>> i2o: Unable to map controller.
>>> If "size=xxxx" indicates the size you are remapping, then that's
> I saw the same problem on a PCI card with a 128MB BAR. it is triggered 
> on an Tyan opteron mobo, while on a old Dell P4 mobo it is ok. I 

Ah, so it could maybe a mainboard problem?

> followed a bit the source code for ioremap and found two places in which 
> it can fail,
>    area = get_vm_area(size, VM_IOREMAP);
>    if (!area)
>        return NULL;
>    addr = area->addr;
>    if (remap_area_pages(VMALLOC_VMADDR(addr), phys_addr, size, flags)) {
>        vfree(addr);
>        return NULL;
>    }
> I had not time to add debug printk and recompila the kernel to check 
> which one is faulty...
> The strange thing is that the BARs seems to be laid out correctly, so it 
> does not look like a bios bug...

But even if it's not a bug, maybe a BIOS update would help...

I'll check this out too...

>>> probably too large an area to be remapping.  Try remapping only the
>>> memory area needed, and not the entire area.
>> Is there a way, to increase the size, which could be remapped, or is 
>> there a way, to find out what is the maximum size which could be 
>> remapped?
> we tried with half and it was ok, then we moved up a bit and found the 
> maximum around 80MB I think...

Okay, i'll let try it out with only 64MB.


Thanks for your help!

Best regards,


Markus Lidel
------------------------------------------
Markus Lidel (Senior IT Consultant)

Shadow Connect GmbH
Carl-Reisch-Weg 12
D-86381 Krumbach
Germany

Phone:  +49 82 82/99 51-0
Fax:    +49 82 82/99 51-11

E-Mail: Markus.Lidel@shadowconnect.com
URL:    http://www.shadowconnect.com
