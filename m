Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932316AbVIJVlK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932316AbVIJVlK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 17:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932318AbVIJVlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 17:41:10 -0400
Received: from mail.dvmed.net ([216.237.124.58]:22165 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932316AbVIJVlJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 17:41:09 -0400
Message-ID: <432352F0.1080502@pobox.com>
Date: Sat, 10 Sep 2005 17:41:04 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jiri Slaby <jirislaby@gmail.com>
CC: Greg KH <gregkh@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 5/10] drivers/char: pci_find_device remove (drivers/char/specialix.c)
References: <200509101221.j8ACL9XI017246@localhost.localdomain> <43234860.7050206@pobox.com> <43234972.3010003@gmail.com> <20050910211711.GA13660@suse.de> <4323518E.9060407@gmail.com>
In-Reply-To: <4323518E.9060407@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby wrote:
> Greg KH napsal(a):
> 
>> On Sat, Sep 10, 2005 at 11:00:34PM +0200, Jiri Slaby wrote:
>>
>>> Jeff Garzik napsal(a):
>>>
>>>> Jiri Slaby wrote:
>>>>
>>>>
>>>>> Signed-off-by: Jiri Slaby <xslaby@fi.muni.cz>
>>>>>
>>>>> specialix.c |    9 ++++++---
>>>>> 1 files changed, 6 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/drivers/char/specialix.c b/drivers/char/specialix.c
>>>>> --- a/drivers/char/specialix.c
>>>>> +++ b/drivers/char/specialix.c
>>>>> @@ -2502,9 +2502,9 @@ static int __init specialix_init(void)
>>>>>                i++;
>>>>>                continue;
>>>>>            }
>>>>> -            pdev = pci_find_device (PCI_VENDOR_ID_SPECIALIX, 
>>>>> -                                    PCI_DEVICE_ID_SPECIALIX_IO8, 
>>>>> -                                    pdev);
>>>>> +            pdev = pci_get_device (PCI_VENDOR_ID_SPECIALIX,
>>>>> +                    PCI_DEVICE_ID_SPECIALIX_IO8,
>>>>> +                    pdev);
>>>>>            if (!pdev) break;
>>>>>
>>>>>            if (pci_enable_device(pdev))
>>>>> @@ -2517,7 +2517,10 @@ static int __init specialix_init(void)
>>>>>            sx_board[i].flags |= SX_BOARD_IS_PCI;
>>>>>            if (!sx_probe(&sx_board[i]))
>>>>>                found ++;
>>>>> +
>>>>>        }
>>>>> +        if (i >= SX_NBOARD)
>>>>> +            pci_dev_put(pdev);
>>>>
>>>>
>>>>
>>>> should be converted to PCI probing, rather than this.
>>>
>>>
>>> I won't do that, i did that for 2 drivers and nobody was interested 
>>> in that (and its much time left for nothing). These (unrewritten) 
>>> drivers would be deleted in some time. Greg wants simply wipe this 
>>> function out.
>>
>>
>>
>> No, I want it done correctly.  If I simply wanted the function removed,
>> I would have done this kind of wholesale conversion a long time ago.
>>
>> If the code needs to be converted to the proper pci probing logic,
>> that's the better way to do it, and that's what should be done.
> 
> I think so too, but some drivers, that uses pci_find_device are broken 
> for a long time and nobody uses it at all.
> 
> So what should I do? I want others not to use pci_find_device 
> furthermore, so I sent patch that marks it deprecated. Greg sent, that 
> he wants to remove them and wants to kill 'em all from the tree. When I 
> rewrote the 2 drivers, nobody wanted to test them and nobody acked them, 
> nobody did anything. So:
> a) rewrite non-broken drivers, the rest kill (or not to kill, only mark 
> find as deprecated and let them live for some next time)
> b) rewrite all
> c) change find to get + dev_put
> d) others: ................
> [What about oss drivers?]
> 
> So, Greg and Jeff, your opinions?


If the drivers aren't used or maintained, remove them from the kernel tree.

	Jeff


