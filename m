Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965367AbWHOKXK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965367AbWHOKXK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 06:23:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965364AbWHOKXK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 06:23:10 -0400
Received: from mtagate6.uk.ibm.com ([195.212.29.139]:40770 "EHLO
	mtagate6.uk.ibm.com") by vger.kernel.org with ESMTP id S965365AbWHOKXI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 06:23:08 -0400
Message-ID: <44E19765.7030301@de.ibm.com>
Date: Tue, 15 Aug 2006 11:44:05 +0200
From: Jan-Bernd Themann <ossthema@de.ibm.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: michael@ellerman.id.au
CC: netdev <netdev@vger.kernel.org>, Thomas Klein <tklein@de.ibm.com>,
       linux-ppc <linuxppc-dev@ozlabs.org>,
       Christoph Raisch <raisch@de.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Marcus Eder <meder@de.ibm.com>
Subject: Re: [PATCH 4/6] ehea: header files
References: <44D99F56.7010201@de.ibm.com>	 <1155190921.9801.43.camel@localhost.localdomain>	 <44E07267.7070007@de.ibm.com> <1155600499.9047.13.camel@localhost.localdomain>
In-Reply-To: <1155600499.9047.13.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Ellerman wrote:
> On Mon, 2006-08-14 at 14:53 +0200, Jan-Bernd Themann wrote:
>> Michael Ellerman wrote:
>>>> --- linux-2.6.18-rc4-orig/drivers/net/ehea/ehea.h	1969-12-31 16:00:00.000000000 -0800
>>>> +++ kernel/drivers/net/ehea/ehea.h	2006-08-08 23:59:39.927452928 -0700
>>>> +
>>>> +#define EHEA_PAGESHIFT  12
>>>> +#define EHEA_PAGESIZE   4096UL
>>>> +#define EHEA_CACHE_LINE 128
>>> This looks like a very bad idea, what happens if you're running on a
>>> machine with 64K pages?
>>>
>> The EHEA_PAGESIZE define is needed for queue management to hardware side.
> 
> You mean the eHEA has its own concept of page size? Separate from the
> page size used by the MMU?
> 

yes, the eHEA currently supports only 4K pages for queues

>>>> +/*
>>>> + *  h_galpa:
>>>> + *  for pSeries this is a 64bit memory address where
>>>> + *  I/O memory is mapped into CPU address space
>>>> + */
>>>> +
>>>> +struct h_galpa {
>>>> +	u64 fw_handle;
>>>> +};
>>> What is a h_galpa? And why does it need a struct if it's just a u64?
>>>
>> The eHEA chip is not PCI attached but directly connected to a proprietary
>> bus. Currently, we can access it by a simple 64 bit address, but this is not
>> true in all cases. Having a struct here allows us to encapsulate the chip
>> register access and to respond to changes to system hardware.
>>
>> We'll change the name to h_epa meaning "ehea physical address"
> 
> Hmm, I'm not convinced. Having the struct doesn't really encapsulate
> much, because most of the places where you use the h_galpa struct just
> pull out the fw_handle anyway. So if you change the layout of the struct
> you're going to have to change most of the code anyway. And in the
> meantime it makes the code a lot less readable, most people understand
> what "u64 addr" is about, whereas "struct h_galpa" is much less
> meaningful. </2c>
> 
> cheers
> 

We already use the h_galpa struct for simulation purposes where we use
this encapsulation to add further required fields to be able to access
the registers (h_galpa has been renamed to h_epa). The name of the
fw_handle element will be changed. Instead of fw_handle, we'll call it
ebus_addr which will make it more readable.

Regards,
Jan-Bernd

