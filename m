Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750732AbVKZUmz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbVKZUmz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 15:42:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750735AbVKZUmy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 15:42:54 -0500
Received: from xproxy.gmail.com ([66.249.82.206]:17133 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750732AbVKZUmy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 15:42:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:organization:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=tO3zvXQ5kcxi9STqr/BBdOtq+NHHf91maoi0vKNUFg2V/VhEyOD/P94FP7fLwk77J6Adaqaet25KV5ujk4H7ID90B+JjlUwwo5oOMMUl/F5JlYp5zjiKDGN7dmT+8bOl1XhhTU4VqbCjW67OZfcdn0uYCKacN2bllst+cGdIosU=
Message-ID: <4388C8C8.1050801@gmail.com>
Date: Sat, 26 Nov 2005 21:42:48 +0100
From: Patrizio Bassi <patrizio.bassi@gmail.com>
Reply-To: patrizio.bassi@gmail.com
Organization: patrizio.bassi@gmail.com
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051027)
X-Accept-Language: it, it-it, en-us, en
MIME-Version: 1.0
To: Alan Stern <stern@rowland.harvard.edu>
CC: Kernel development list <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       pavel@ucw.cz, shaohua.li@intel.com, akpm@osdl.org
Subject: Re: 2.6.15-rc2-git5 continues to fail suspending (USB issue)
References: <Pine.LNX.4.44L0.0511261522220.15363-100000@netrider.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0511261522220.15363-100000@netrider.rowland.org>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Stern ha scritto:

>On Sat, 26 Nov 2005, Patrizio Bassi wrote:
>
>  
>
>>>You wrote about it on lkml, not linux-usb-devel.  So it might not have 
>>>been noticed by the USB developers.
>>>
>>> 
>>>
>>>      
>>>
>>o sorry you're right. i tought usb team followed the main ml too.
>>    
>>
>
>Some do and some don't.
>
>  
>
>>globespan device is a zyxel prestige 630 adsl modem using eciadsl
>>userspace drivers.
>>after killing the driver it suspended and resumed.
>>
>>but i got a problem, trying to restart driver.
>>
>>[EciAdsl 3/5] Synchronization...
>>
>> ERROR reading interrupts
>>*** glibc detected *** double free or corruption (fasttop): 0x0804f158 ***
>>/usr/bin/eciadsl-start: line 517: 11399 Abortito               
>>"$BIN_DIR/eciadsl-synch" $synch_options
>>ERROR: failed to get synchronization
>>
>>usb 2-2: usbfs: USBDEVFS_CONTROL failed cmd eciadsl-synch rqt 192 rq 222
>>len 13 ret -110
>>
>>tried 3 times, always the same.
>>so i manually unplugged modem and replugged.
>>works perfectly (as usual).
>>
>>seems a problem on suspending and resuming attached device.
>>    
>>
>
>Maybe it's a problem in the device.
>
>  
>
no..why should after resume?
however i remember some kernels ago (.13/.14) it worked
after resume hotplug restarted my driver, now not.

>>i've access to eciadsl cvs so i can patch it.
>>the first problem (no suspend) i think can be fixed binding some signals
>>in userspace, which?
>>    
>>
>
>There are no signals sent to userspace on suspend.  It's too late to send 
>signals, because all tasks have already been frozen.
>
>Instead the usbfs code has to be changed to handle suspend/resume events 
>on behalf of userspace drivers.  Or you could use that patch I mentioned 
>before; it unbinds drivers that don't have suspend methods.
>
>  
>
i don't like to use such big patches, i'm sure Greg will merge fast ;)

>>the second seems an init problem, that i leave to you :)
>>    
>>
>
>I can't do anything about it, since I don't have one of those modems.
>
>Alan Stern
>
>
>  
>
i understand, i appreciate your help.
