Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264565AbTIDCsM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 22:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264553AbTIDCsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 22:48:12 -0400
Received: from k-kdom.nishanet.com ([65.125.12.2]:27657 "EHLO
	mail2k.k-kdom.nishanet.com") by vger.kernel.org with ESMTP
	id S264565AbTIDCrm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 22:47:42 -0400
Message-ID: <3F56A50A.2010604@boxho.com>
Date: Wed, 03 Sep 2003 22:35:54 -0400
From: Resident Boxholder <resid@boxho.com>
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test4, psmouse doesn't autoload, CONFIG_SERIO doesn't module
References: <E19uTjL-000DJ5-00.arvidjaar-mail-ru@f23.mail.ru>
In-Reply-To: <E19uTjL-000DJ5-00.arvidjaar-mail-ru@f23.mail.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One reason it would be nice to be able to reload all the psmouse and 
serio code is
that a kvm ps2 switch can cause mouse sync to get lost when a pc is not 
the active
one on the kvm switch. Reboot seems rather drastic, but it's the only 
way to get
mouse sync back until the day that psmouse serio modules can be reloaded.

Further making it important, usb kvm won't work if usb won't work, never 
mind
why many of us are boot-strapping from such that primitive state. Boot 
on a usb
keyboard, what a laugh at this point. At least by not kern config 
"legacy psaux",
and using psmouse.c /dev/input/mice, we don't have to endure the 
"legacy" label.
We're not dinosaurs, we're sheeple.

-Bob

Andrey Borzenkov wrote:

>[...] 
>  
>
>>>In general there seems to be no way to load low-level input drivers
>>>on access because there is no instance that ever accesses them. And
>>>as it stands now there is not way to auto-load using some other means.
>>>So we are back in static configuration times ...
>>>      
>>>
>>Ok, I guess.  But isn't there some module reference that can trigger the
>>install of psmouse?
>>
>>    
>>
>
>not that I am aware of. You will need more tham just psmouse ...
>
>1. psmouse sits below serio driver. So you have to load serio. It
>could be done buy hotplug but I guess at least for 8042 (standard
>PC keyboard/mouse controller) it belongs to PnP BIOS subsystem
>and PnP BIOS subsystem does not support hotplug currently.
>
>2. After you have loaded corr. serio driver you need to know what
>mouse driver to load. It requires some sort of autoporbing and I am
>not sure it is actually done in current driver. I presume it is
>possible because both Microsoft and Solaris do it. I just do not
>know if it is implemented and do not have access to sources now. And
>it requires support from hotplug again :)
>
>[...]
>  
>
>>>>3. Documentation/kmod.txt says "passing the name (to modprobe) that was
>>>>requested", couldn't this be more explicit?
>>>>        
>>>>
>>>what exactly do you mean?
>>>      
>>>
>>Something like "...passing the name of the device in the form
>>'char-major-x-y' for misc devices and 'char-major-X' for others"
>>
>>    
>>
>
>feel free to submit a patch. Do not forget that misc is not the only
>char driver that is using minors.
> 
>  
>
>>BTW, could kmod just pass the name of the file from the open() call?
>>    
>>
>
>you miss the point. You just suggest different way to *statically*
>configure your mouse driver module while your original question was
>why it is not loaded automatically. It does not matter if you enter
>"psmouse" in some init script or create a link for it - you still
>have to do it manually.
>
>Please look at devfs if you still want to do it. It does exactly
>what you ask for.
>
>-andrey
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>

