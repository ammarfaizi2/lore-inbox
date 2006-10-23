Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751842AbWJWJNZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751842AbWJWJNZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 05:13:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751854AbWJWJNZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 05:13:25 -0400
Received: from adsl-ull-137-166.41-151.net24.it ([151.41.166.137]:34600 "EHLO
	zeus.abinetworks.biz") by vger.kernel.org with ESMTP
	id S1751842AbWJWJNY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 05:13:24 -0400
Message-ID: <453C86ED.7070205@abinetworks.biz>
Date: Mon, 23 Oct 2006 11:10:05 +0200
From: Gianluca Alberici <gianluca@abinetworks.biz>
User-Agent: Mozilla Thunderbird 0.8 (X11/20041022)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Giridhar Pemmasani <pgiri@yahoo.com>
CC: Chase Venters <chase.venters@clientec.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.com
Subject: Re: incorrect taint of ndiswrapper
References: <20061023064114.49794.qmail@web32403.mail.mud.yahoo.com>
In-Reply-To: <20061023064114.49794.qmail@web32403.mail.mud.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

if that can help, the problem with the undefined syms in ndiswrapper is 
that the module was tainted, and couldnt get EXPORT_SYMBOL_GPL'd 
__create_workqueue...

I applied Chase patch...everything goes.

In my opinion i would avoid tainting ndiswrapper.

Gianluca

Giridhar Pemmasani wrote:

>--- Chase Venters <chase.venters@clientec.com> wrote:
>
>  
>
>>On Monday 23 October 2006 00:40, Giridhar Pemmasani wrote:
>>    
>>
>>>It seems that the kernel module loader taints ndiswrapper module as
>>>proprietary, but it is not - it is fully GPL: see
>>>http://directory.fsf.org/sysadmin/hookup/ndiswrapper.html
>>>      
>>>
>>Indeed. 'ndiswrapper' is intentionally tainted by kernel/module.c because
>>it 
>>is used to load and run unknown binary / proprietary code in kernel-space.
>>If 
>>this unknown binary / proprietary code were to contain a bug (which all
>>code 
>>of that complexity tends to), it might write to memory it doesn't own, or 
>>coerce a device to do so on its behalf, making a kernel crash dump analysis
>>
>>into a wild goose chase (hence the reason for kernel taint).
>>    
>>
>
>Yes, I agree on the purpose of tainting the kernel.
>
>  
>
>>>Note that when a driver is loaded, ndiswrapper does taint the kernel (to
>>>      
>>>
>>be
>>    
>>
>>>more accurate, it should check if the driver being loaded is GPL or not,
>>>but that is not done).
>>>      
>>>
>>Are you saying ndiswrapper voluntarily calls add_taint() whenever it loads
>>an 
>>NDIS driver?
>>    
>>
>
>Exactly - the loader within ndiswrapper taints kernel versions 2.6.10 and
>newer (older kernels don't have a way of tainting the kernel). The code is in
>loader.c in ndiswrapper.
>
>  
>
>>Are there even any examples of GPL-licensed NDIS drivers?
>>    
>>
>
>I don't remember off hand, but sometime back there was discussion on related
>topic of weather ndiswrapper should be in debian-main or not, and someone
>pointed out a GPL ndis driver. (BTW, after much discussion on debian devel
>list, the developers agreed that ndiswrapper belongs in debian-main.)
>
>Giri
>
>__________________________________________________
>Do You Yahoo!?
>Tired of spam?  Yahoo! Mail has the best spam protection around 
>http://mail.yahoo.com 
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>

