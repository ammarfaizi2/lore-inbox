Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751457AbWDPJiS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457AbWDPJiS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Apr 2006 05:38:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751460AbWDPJiS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Apr 2006 05:38:18 -0400
Received: from mailhub1.otago.ac.nz ([139.80.64.218]:46250 "EHLO
	mailhub1.otago.ac.nz") by vger.kernel.org with ESMTP
	id S1751457AbWDPJiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Apr 2006 05:38:16 -0400
In-Reply-To: <20060415212147.6e9b0c11.rdunlap@xenotime.net>
References: <20060412230439.WMCC8268.mta4-rme.xtra.co.nz@[202.27.184.228]> <20060415212147.6e9b0c11.rdunlap@xenotime.net>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <0829C3E1-F140-4561-9DFA-F865C7DECBB6@cs.otago.ac.nz>
Cc: penberg@cs.helsinki.fi, hnagar2@gmail.com, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: zhiyi huang <hzy@cs.otago.ac.nz>
Subject: Re: Slab corruption after unloading a module
Date: Sun, 16 Apr 2006 21:38:44 +1200
To: "Randy.Dunlap" <rdunlap@xenotime.net>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 16/04/2006, at 4:21 PM, Randy.Dunlap wrote:

> On Thu, 13 Apr 2006 11:04:39 +1200 Zhiyi Huang wrote:
>
>>> 2.6.8 is an old kernel, you could very well be hitting a kernel bug
>>> that has been fixed already. Can you reproduce this with 2.6.16?
>>
>> I will try that soon.
>>
>>> Also,
>>> you're not including sources to your module so it's impossible to  
>>> tell
>>> whether you're doing something wrong.
>>>
>>>                                                          Pekka
>>
>> Below is my baby module which only uses kmalloc and kfree for my  
>> device
>> structure. I found the slab corruption address is the address of  
>> the structure.
>> It seems to be a bug for kmalloc and kfree.
>
>> /* The parameter for testing */
>> int major=0;
>> MODULE_PARM(major, "i");
>> MODULE_PARM_DESC(major, "device major number");
>
> Hi,
> I had no problem loading and unloading your module on
> 2.6.17-rc1 [after changing MODULE_PARM() to
> module_param(major, int, 0644);
> ].
>
> ---
> ~Randy

There was no problem if I just load and unload the module. But if I  
write to the device using "ls > /dev/temp" and then unload the  
module, I would get slab corruption.  I tried to install 2.6.16.5 at  
the moment but got stuck when I was making an initrd image file (no  
output file produced! and no errors displayed). Once I get around  
this problem, I should be able to test it on the new kernel.
Zhiyi
