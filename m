Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932754AbVINTQ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932754AbVINTQ5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 15:16:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932755AbVINTQ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 15:16:57 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:32133 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S932754AbVINTQ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 15:16:56 -0400
Message-ID: <43287712.3040503@gmail.com>
Date: Wed, 14 Sep 2005 21:16:34 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Manu Abraham <manu@kromtek.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: PCI driver
References: <4327EE94.2040405@kromtek.com> <4327F586.3030901@gmail.com> <4327F551.6070903@kromtek.com> <4327FB6C.3070708@gmail.com> <43280F2F.2060708@gmail.com> <432815FA.5040202@gmail.com> <43281C27.1060305@kromtek.com> <43284CE6.3080302@gmail.com> <43285951.7050702@kromtek.com> <4328734E.2080607@gmail.com> <4328735B.70800@kromtek.com>
In-Reply-To: <4328735B.70800@kromtek.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manu Abraham napsal(a):
> Jiri Slaby wrote:
> 
>> Manu Abraham napsal(a):
>>
>>> Jiri Slaby wrote:
>>>
>>>> you do NOT do this at all, because you have pdev already (the param 
>>>> of the probe function)
>>>>
>>>
>>> I rewrote the entire thing like this including the pci_remove 
>>> function too, but now it so seems that in the remove function, 
>>> pci_get_drvdata(pdev) returns NULL, and hence i get an Oops at module 
>>> removal.
>>
>>
>> Maybe because this is badly written driver.
> 
> 
> I have not written the driver, but this is my first go at it ..
> 
>>
>>> static int mantis_pci_probe(struct pci_dev *pdev, const struct 
>>> pci_device_id *mantis_pci_table)
>>> {
>>>     struct mantis_pci *mantis;
>>>     struct mantis_eeprom eeprom;
>>>     u8 revision, latency;
>>>     u8 data[2];      if (pci_enable_device(pdev)) {               
>>> dprintk(verbose, MANTIS_DEBUG, 1, "Found a mantis chip");
>>>         if ((mantis = (struct mantis_pci *) kmalloc(sizeof (struct 
>>> mantis_pci), GFP_KERNEL)) == NULL) {
>>>             dprintk(verbose, MANTIS_ERROR, 1, "Out of memory");
>>>             return -ENOMEM;
>>>         }
>>>         pci_set_master(pdev);
>>>         mantis->mantis_addr = pci_resource_start(pdev, 0);
>>>         if (!request_mem_region(pci_resource_start(pdev, 0),
>>>             pci_resource_len(pdev, 0), DRIVER_NAME)) {
>>>             kfree(mantis);
>>>             return -EBUSY;
>>>         }
>>>         pci_read_config_byte(pdev, PCI_CLASS_REVISION, &revision);
>>>         pci_read_config_byte(pdev, PCI_LATENCY_TIMER, &latency);
>>>         mantis->mantis_mmio = ioremap(mantis->mantis_addr, 0x1000);
>>>         pci_set_drvdata(pdev, mantis);       
>>
>>
>> if pci_enable_device fails, you set this?? Maybe you haven't read the 
>> doc enough.
> 
> 
> 
> I just found that, pci_enable_device() fails. So what's the way to go 
> ahead ?
JESUS.
int retval = 0;

if ((retval = pci_enable_device()))
	goto end;

...
pci_set_drvdata(pdev, mantis);
...

end:
	return retval;

not
if (pci_enable_device())
	do something
-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
241B347EC88228DE51EE A49C4A73A25004CB2A10
