Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262890AbUDTMnZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262890AbUDTMnZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 08:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262864AbUDTMnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 08:43:07 -0400
Received: from mail.gmx.de ([213.165.64.20]:50826 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262873AbUDTMlM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 08:41:12 -0400
X-Authenticated: #4512188
Message-ID: <40851A6E.8050409@gmx.de>
Date: Tue, 20 Apr 2004 14:41:18 +0200
From: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040413)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Konstantin Sobolev <kos@supportwizard.com>,
       Justin Cormack <justin@street-vision.com>,
       Ryan Geoffrey Bourgeois <rgb005@latech.edu>,
       Kernel mailing list <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org
Subject: Re: poor sata performance on 2.6
References: <200404150236.05894.kos@supportwizard.com> <1082039593.19568.75.camel@lotte.street-vision.com> <200404151848.05857.kos@supportwizard.com> <200404152030.51052.vda@port.imtp.ilyichevsk.odessa.ua> <407F315E.2000809@pobox.com>
In-Reply-To: <407F315E.2000809@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Denis Vlasenko wrote:
> 
>> On Thursday 15 April 2004 17:48, Konstantin Sobolev wrote:
>>
>>> On Thursday 15 April 2004 18:33, Justin Cormack wrote:
>>>
>>>> On Thu, 2004-04-15 at 15:26, Konstantin Sobolev wrote:
>>>>
>>>>> On Thursday 15 April 2004 18:00, Justin Cormack wrote:
>>>>>
>>>>>> hmm, odd. I get 50MB/s or so from normal (7200, 8MB cache) WD disks,
>>>>>> and Seagate from the same controller. Can you send lspci,
>>>>>> /proc/interrupts and dmesg...
>>>>>
>>>>>
>>>>> Attached are files for 2.6.5-mm5 with highmem, ACPI and APIC turned
>>>>> off.
>>>>
>>>>
>>>> ah. Make a filesystem on it and mount it and try again. I see you have
>>>> no partition table and so probably no filesystem. This means the block
>>>> size is set to default 512byte not 4k which makes disk operations slow.
>>>> Any filesystem should default to block size of 4k, eg ext2.
>>>
[snip]
>>> So first time it gave the same loosy 27 MB/s and subsequent tests give
>>> pretty good 68 MB/s! Why?
>>
>>
>>
>> Time to CC ide/libata/block layer folks
>>
>> Jeff Garzik <jgarzik@pobox.com>
>>     libata man
> 
> 
> 
> It seems like the situation is already resolved, to me.
> 
> When you mount a filesystem, it changes the default block size (512 or 
> 1024) to the filesystem block size, normally 4096.  This would certainly 
> increase the throughput.


Hi Jeff,

it is NOT resolved: I just tried libata again, and I can  observe the 
same behaviour: I just did a "cat /dev/sda >/dev/null" and watched 
gkrellm2 showing the throughoutput. The first tiem I do the cat I only 
got about 27mb/s, no matter how ong I waited, but all subsequent cat 
gave me about >60mb/s. So there is a tiny bug in libata, I guess, as 
when using the siimage.c ide driver, already the first cat gives me 
maximum throughoutput. I am using 2.6.5-mm4 based kernel. Filesystems 
were mounted/ I didn't change anything between first and secound cat.

bye,

Prakash
