Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932482AbVHIJ2o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932482AbVHIJ2o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 05:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932485AbVHIJ2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 05:28:44 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:22918 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S932482AbVHIJ2n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 05:28:43 -0400
Message-ID: <42F87730.5030804@gmail.com>
Date: Tue, 09 Aug 2005 11:28:16 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [PATCH -mm] removes pci_find_device from i6300esb.c
References: <42F73523.80205@gmail.com>	<200508082355.j78NtGNS029681@wscnet.wsc.cz> <20050808233429.36e6ebd5.akpm@osdl.org>
In-Reply-To: <20050808233429.36e6ebd5.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton napsal(a):

>Jiri Slaby <jirislaby@gmail.com> wrote:
>  
>
>>--- a/drivers/char/watchdog/i6300esb.c
>> +++ b/drivers/char/watchdog/i6300esb.c
>> @@ -368,12 +368,11 @@ static unsigned char __init esb_getdevic
>>           *      Find the PCI device
>>           */
>>  
>> -        while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
>> +        for_each_pci_dev(dev)
>>                  if (pci_match_id(esb_pci_tbl, dev)) {
>>                          esb_pci = dev;
>>                          break;
>>                  }
>> -        }
>>  
>>          if (esb_pci) {
>>          	if (pci_enable_device(esb_pci)) {
>> @@ -430,6 +429,7 @@ err_release:
>>  		pci_release_region(esb_pci, 0);
>>  err_disable:
>>  		pci_disable_device(esb_pci);
>> +		pci_dev_put(esb_pci);
>>    
>>
>
>That doesn't look right.  Each iteration of for_each_pci_dev() needs a
>pci_dev_put(), not just the final one.
>  
>
But pci_get_device do it for us on pci_get_subsys, line 249, doesn't it?

-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
241B347EC88228DE51EE A49C4A73A25004CB2A10

