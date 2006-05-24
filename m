Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932376AbWEXVl7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932376AbWEXVl7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 17:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932770AbWEXVl7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 17:41:59 -0400
Received: from ccerelbas04.cce.hp.com ([161.114.21.107]:9443 "EHLO
	ccerelbas04.cce.hp.com") by vger.kernel.org with ESMTP
	id S932376AbWEXVl6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 17:41:58 -0400
Message-ID: <4474D383.4030506@hp.com>
Date: Wed, 24 May 2006 21:43:31 +0000
From: Patrick Jefferson <patrick.jefferson@hp.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: greg@kroah.com
Cc: ink@jurassic.park.msu.ru, gregkh@suse.de, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH] PCI: fix MMIO addressing collisions
References: <4472FFDA.2040005@hp.com> <20060524020654.A19699@jurassic.park.msu.ru> <20060523224718.GA31629@kroah.com>
In-Reply-To: <20060523224718.GA31629@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 May 2006 21:41:57.0390 (UTC) FILETIME=[E19342E0:01C67F7A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Wed, May 24, 2006 at 02:06:54AM +0400, Ivan Kokshaysky wrote:
> 
>>On Tue, May 23, 2006 at 12:28:10PM +0000, Patrick Jefferson wrote:
>>
>>>Clearing PCI Command bits fixes machine halts observed during sizing 
>>>seqences using MMIO cycles. Clearing the bits is suggested by an 
>>>implementation note in the PCI spec.
>>
>>The patch is not acceptable. This was discussed back in 2002:
>>
>>  http://www.uwsg.iu.edu/hypermail/linux/kernel/0212.2/index.html#978
> 
> 
> I agree, it's not going to be accepted.
> 
> Patrick, are you trying to solve the same thing that Grant was back in
> 2002?  Why do you feel this patch is necessary?

No. The problem is similar, involving colliding addresses, but 
critically different. Sizing a device's BAR via memory-mapped 
configuration space accesses will do spectacular things when the size, 
say E0000000, unforeseeably equals the mapped config space address, like 
E0000000. The Memory bit in the PCI Command register must be cleared.

Either a) some other specific sequence exists for safe sizing,
Or b) disabling memory decoding by the device must be allowed, at 
minimum, as a special case,
Or c) a switch from MMCONFIG to CF8/CFC and back again should be used 
when sizing,
Or d) the resulting machine crash is acceptable during linux boot.

The patch, since it addresses d), is necessary unless b) or c) are 
feasible, or a) exists.

Any suggestions would be appreciated.

Thanks,
Patrick

