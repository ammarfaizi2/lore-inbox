Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261294AbTKLCl1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 21:41:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261376AbTKLCl1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 21:41:27 -0500
Received: from cache1.telkomsel.co.id ([202.155.14.251]:17163 "EHLO
	cache1.telkomsel.co.id") by vger.kernel.org with ESMTP
	id S261294AbTKLClY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 21:41:24 -0500
Message-ID: <3FB19ACC.4070106@telkomsel.co.id>
Date: Wed, 12 Nov 2003 09:28:28 +0700
From: arief_mulya <arief_m_utama@telkomsel.co.id>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031024 Debian/1.4-4 StumbleUpon/1.8
X-Accept-Language: en
MIME-Version: 1.0
To: Dmitry Torokhov <dtor_core@ameritech.net>
CC: Andrew Morton <akpm@osdl.org>, vojtech@suse.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH?] psmouse-base.c
References: <3FAEF7BC.8060503@telkomsel.co.id> <200311110020.07251.dtor_core@ameritech.net> <3FB08798.7050805@telkomsel.co.id> <200311111829.50521.dtor_core@ameritech.net>
In-Reply-To: <200311111829.50521.dtor_core@ameritech.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:

>On Tuesday 11 November 2003 01:54 am, arief_mulya wrote:
>  
>
>>Dmitry Torokhov wrote:
>>    
>>
>
>  
>
>>>Unfortunately I do not suspend my laptop so I did not run it, just
>>>made sure it compiles. Arief? could you give this patch a try?
>>>      
>>>
>>I have tested it before.
>>My first attempts looked quite just like that.
>>
>>It didn't work quite nicely.
>>Especially with gpm, after resume, you cannot do Tap-to-Click behaviour
>>with that patch. You can still move it, use left and right button, but
>>no tap-to-click. I don't know why. That's why, finally, I use
>>serio_rescan().
>>
>>I haven't tested it with X, though, as I use gpm as a repeater, I
>>thought this was unnecessary.
>>
>>But I have try Andrew's tree. And it works flawlessly with the patch
>>(case PM_RESUME: serio_reconnect()). I think I'm going to stick with mm
>>tree, and dump my vanilla kernel.
>>
>>One more think, I also sets "psmouse_resetafter" to 1 at the
>>declaration. Without that, I get too many ugly message saying
>>"Synaptics lost sync at 1 byte..." or something like that. As it is a
>>module parameter, but on menuconfig synaptics does not available as
>>module, so I set it directly on the source. I don't know if I can set
>>it on boot time, can it?
>>
>>    
>>
>
>Ok, I somewhat confused as the sequence in psmouse_pm_callback is pretty
>much the same as in rescan/reconnect. Wait...
> 
>  
>
This is what  I thought, too.
Why did it work with serio_rescan() or serio_reconnect() but not with 
the one above?

But on second thought, I didn't know how the kernel works, not then. Not 
now. So when it works for me, my lazy brain, said. That's enough.  ;-)

>Does suspend/resume work at all if you don't set psmouse_resetafter to 1??
>  
>
Nope. At least, I didn't wait that long. (I hate seeing lots of "lost 
sync" messages in my console forever, so I always reboot. And in X, you 
just get un-moveable mouse.)

>The reason I am asking is that we have alot of different PM interfaces and
>this one is marked as deprecated. If it is not called during resume it would
>leave the touchpad in relative mode while kernel expects absolute and spews 
>"lost sync" messages... Until Synaptics decides that it's time to reset 
>after X bad packets. Does it make any sense?
>
>  
>
Personally, I don't think it makes any sense.
If something is broken. Why do I need to see lots of funny messages 
(which I didn't even know what it means) if then it could be fixed. Or 
is it has something to do with other serio devices?

>Btw, Synaptics is intergated into psmouse module so you don't really need
>to edit the source to set resetafter parameter. Either pass 
>"psmouse_resetafter=X" to the kernel on boot if psmouse compiled in or
>pass it to modprobe.
>
>  
>
I thought so, too.
But how do you pass to modprobe something that does not available as 
Module in menuconfig?

Best Regards.
-- 
arief_mulya
Peace is Beautiful.

>Dmitry
>
>  
>


