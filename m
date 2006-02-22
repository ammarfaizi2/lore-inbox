Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750862AbWBVChG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750862AbWBVChG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 21:37:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750885AbWBVChG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 21:37:06 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:41402 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750862AbWBVChE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 21:37:04 -0500
Message-ID: <43FBCDB6.4090909@jp.fujitsu.com>
Date: Wed, 22 Feb 2006 11:34:30 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>, Jeff Garzik <jgarzik@pobox.com>,
       Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       akpm@osdl.org, rmk+lkml@arm.linux.org.uk
Subject: Re: [PATCH 3/6] PCI legacy I/O port free driver (take2) - Add device_flags
 into pci_device_id
References: <43FAB283.8090206@jp.fujitsu.com> <200602212231.55879.ak@suse.de> <43FB8C4F.6070802@pobox.com> <200602212306.24342.ak@suse.de> <43FBABA4.7020906@pobox.com> <20060222001142.GA31605@kroah.com>
In-Reply-To: <20060222001142.GA31605@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Tue, Feb 21, 2006 at 07:09:08PM -0500, Jeff Garzik wrote:
> 
>>Andi Kleen wrote:
>>
>>>On Tuesday 21 February 2006 22:55, Jeff Garzik wrote:
>>>
>>>
>>>
>>>>It doesn't matter how easily its added, it is the wrong place to add 
>>>>such things.
>>>>
>>>>This is what the various functions called during pci_driver::probe() do...
>>>
>>>
>>>The problem is that at least on the e1000 it only applies to some of the 
>>>many PCI-IDs it supports. So the original patch had an long ugly switch
>>>with PCI IDs to check it. I suggested to use driver_data for it then,
>>>but Kenji-San ended up with this new field.  I actually like the idea
>>>of the new field because it would allow to add such things very easily
>>>without adding lots of code.
>>>
>>>it's not an uncommon situation. e.g. consider driver A which supports
>>>a lot of PCI-IDs but MSI only works on a few of them. How do you
>>>handle this? Add an ugly switch that will bitrot? Or put all the 
>>>information into a single place which is the pci_device_id array.
>>
>>You do what tons of other drivers do, and indicate this via driver_data. 
>> An enumerated type in driver_data can be used to uniquely identify any 
>>device or set of devices.
>>
>>No need to add anything.
> 
> 
> Yes, I agree, use driver_data, it's simpler, and keeps the PCI core
> clean.
> 
> thanks,
> 
> greg k-h
> 

Hi,

Thank you very much for all of the comments.

The reason why I added the new field into struct pci_device_id is
as follows, though these are already explained completely by Andi.

    - By adding the new field instead of using driver_data, drivers
      can pass the flags to the kernel directly. That is, drivers
      don't need to call any new APIs to tell something to the kernel
      after checking their own driver_data in their .probe().

    - This new field can be used not only for ioport but also
      other purpose (e.g. MSI).

But according to the discussion, it doesn't look a good idea to add
the new field into pci_device_id this time. So I'll update my patches
to use the driver_data field instead.

Thanks,
Kenji Kaneshige
