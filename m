Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263668AbTDGVJR (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 17:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263672AbTDGVJR (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 17:09:17 -0400
Received: from mail.gmx.de ([213.165.65.60]:52292 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263668AbTDGVJP (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 17:09:15 -0400
Message-ID: <3E91EBA9.3090503@gmx.net>
Date: Mon, 07 Apr 2003 23:20:41 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: de, en
MIME-Version: 1.0
To: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Problems booting PDC20276 with new IDE setup code.
References: <5.2.0.9.0.20030407141330.00b346c0@mailhost.ivimey.org> <Pine.LNX.4.44.0304070201420.8701-100000@sharra.ivimey.org> <Pine.LNX.4.44.0304070201420.8701-100000@sharra.ivimey.org> <5.2.0.9.0.20030407141330.00b346c0@mailhost.ivimey.org> <5.2.0.9.0.20030407213727.0207ddf8@mailhost.ivimey.org>
In-Reply-To: <5.2.0.9.0.20030407213727.0207ddf8@mailhost.ivimey.org>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ruth Ivimey-Cook wrote:
> At 15:28 07/04/2003, Carl-Daniel Hailfinger wrote:
> 
>> Ruth Ivimey-Cook wrote:
>>
>>> At 03:34 07/04/2003, Carl-Daniel Hailfinger wrote:
>>>
>>>> Could you please try 2.4.21-pre7 (this has another batch of IDE 
>>>> updates) and enable the option
>>>> "Special FastTrak Feature"?
>>>> In your .config, the option would be
>>>> CONFIG_PDC202XX_FORCE=y
>>>> and report back to the list?
>>>
>>> For reasons reported in another mail (ac97 fails to build) my attempt 
>>> at pre7 failed. Also, as far as I know, the FastTrak feature enables 
>>> the Promise RAID mode: I am not using that. Instead, I just want 4 
>>> IDE disks which will be bound using Linux raid5.
>>
>> No, without the "Special FastTrak Feature" you cannot see the disks at 
>> all, regardless if you want RAID or plain IDE.
> 
> 
> I constructed a -pre7 kernel without sound support to get over the other 
> issue, and enabled the Special Feature. The disks were recognised as 
> ide2 and ide3 and init started ok. Sadly, another issue prevented the 
> machine from booting fully, so I am not sure if all is well. I will 
> pursue things further shortly.

Thanks. That's what I wanted to know.

> I don't understand, though, why in 2.4.20 we had 2 modes -- non-Special 
> to get IDE-only and Special to get FastTrak RAID support, and now we 
> only have one, with the non-Special setting being a no-op and, 
> apparently, Special being IDE only.
> 
> What is happening?

The config option is a little bit mislabeled. More clear would be:
"Support disks attached to a FastTrak controller if the controller is 
denying their existence"
And as help text:
"Promise FastTrak controllers tend to deny the existence of attached 
disks by claiming to have disabled the IDE ports because they want you 
to use the binary only driver. However, the kernel can ignore this trick 
and access the IDE disks just fine if you set this option to Y.
Say Y unless you want to use the slow binary only driver from Promise"

Was this text clear enough? If so, I might submit this as new help text ;-)

Regards,
Carl-Daniel
-- 
http://www.hailfinger.org

