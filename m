Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262033AbUKJT7z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262033AbUKJT7z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 14:59:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbUKJT7z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 14:59:55 -0500
Received: from fire.osdl.org ([65.172.181.4]:1931 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S262033AbUKJT7m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 14:59:42 -0500
Message-ID: <41927055.9030306@osdl.org>
Date: Wed, 10 Nov 2004 11:47:33 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stelian Pop <stelian@popies.net>
CC: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Dominik Brodowski <linux@dominikbrodowski.de>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] drivers/net/pcmcia: use module_param() instead of MODULE_PARM()
References: <20041104112736.GT3472@crusoe.alcove-fr> <418AE490.1010304@pobox.com> <20041110155903.GA8542@sd291.sivit.org> <20041110160058.GB8542@sd291.sivit.org> <41924339.1070809@osdl.org> <20041110195200.GJ2706@deep-space-9.dsnet>
In-Reply-To: <20041110195200.GJ2706@deep-space-9.dsnet>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stelian Pop wrote:
> On Wed, Nov 10, 2004 at 08:35:05AM -0800, Randy.Dunlap wrote:
> 
> 
>>Hi Stelian,
> 
> 
> Hi.
> 
>>Several of these changes expose module parameters to sysfs
>>(i.e., have permissions of non-zero value) without need for that IMO.
>>
>>This came up yesterday on the kernel-janitors mailing list.
>>When asked about it, Greg KH replied:
> 
> 
> :)
> 
> I shouldn't probably discuss Greg's advice, but...

AFAIK, you are free to disagree as long as I or we can also
disagree.  :)

>>>Can someone please clarify the "official guidelines" for
>>>module parameter permissions in sysfs?
>>
>>"When it makes sense to have it exposed to userspace"
>>
>>Yeah, it's vague, sorry, but it all depends.
>>
>>For things that can be changed on the fly, expose it.
> 
> 
> ... with a write permission. Agreed.
> 
> 
>>For things that don't really matter, and no one will ever look them up,
>>don't. 
>>I think the irq stuff is in the "don't" category, as almost no
>>one messes with them anymore.
> 
> 
> In this case why is this a module parameter at all ? If it doesn't
> matter at all then it should get removed from all places.
> 
> In fact, I do think that all module parameter should be exposed in
> /sys, and that a '0' in module_param() should really mean 0400.
> 
> It can be useful to know what parameters have been passed to a module,
> and I cannot think of a single case where we want to hide this 
> information (and no, security doesn't really apply here. If you have
> root rights than you can also look into the kernel memory and find
> out the value by yourself).
> 
> The only questions one should ask himself about a module parameter is
> whether:
> 	- it is a R/O or a R/W value (and this is determined by
> 	  the code who uses this value, if it is dynamic then let
> 	  the parameter be R/W, if it's only used to make assumptions
> 	  in the init phase then it must be R/O).
> 
> 	- it can be shown to everybody, or only root should be able
> 	  to read the value (0400 vs 0440/0444). I'm not sure this is
> 	  really useful since /etc/modprobe.conf is generaly 0644,
> 	  but it could be in some cases...

I don't have an argument with most of that, but I am concerned
about how much memory each entry requires and how useful it really
is.  IOW, if I need to know the module parameters for a module,
I can probably find that info somewhere else, like in
/etc/modprobe.conf or a script etc., so why waste memory on it?

But then there's the question of if someone else needs to know
the module parameters that were used, where do they look?
I could say:  same answer as I gave above.
Or you could say:  exposed in /sys.
If memory usage is not an issue, I'll agree.

-- 
~Randy
