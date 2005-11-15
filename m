Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964838AbVKOQZt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964838AbVKOQZt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 11:25:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964830AbVKOQZt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 11:25:49 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:29968 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S964833AbVKOQZs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 11:25:48 -0500
Message-ID: <437A0BC3.3060909@vmware.com>
Date: Tue, 15 Nov 2005 08:24:35 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
Cc: Gerd Knorr <kraxel@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Dave Jones <davej@redhat.com>, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 1/10] Cr4 is valid on some 486s
References: <200511100032.jAA0WgUq027712@zach-dev.vmware.com>	 <20051111103605.GC27805@elf.ucw.cz> <4374F2D5.7010106@vmware.com>	 <Pine.LNX.4.64.0511111147390.4627@g5.osdl.org>	 <4374FB89.6000304@vmware.com>	 <Pine.LNX.4.64.0511111218110.4627@g5.osdl.org>	 <20051113074241.GA29796@redhat.com>	 <Pine.LNX.4.64.0511131118020.3263@g5.osdl.org>	 <Pine.LNX.4.64.0511131210570.3263@g5.osdl.org> <4378A7F3.9070704@suse.de>	 <Pine.LNX.4.64.0511141118000.3263@g5.osdl.org> <4379ECC1.20005@suse.de>	 <437A0649.7010702@suse.de>  <437A0710.4020107@vmware.com> <1132070764.2822.27.camel@laptopd505.fenrus.org>
In-Reply-To: <1132070764.2822.27.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Nov 2005 16:24:36.0454 (UTC) FILETIME=[11CE8060:01C5EA01]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

>On Tue, 2005-11-15 at 08:04 -0800, Zachary Amsden wrote:
>  
>
>>Gerd Knorr wrote:
>>
>>    
>>
>>>>Yep, extending alternatives is probably better than duplicating the 
>>>>code.  Maybe having some alternative_smp() macro which places both 
>>>>code versions into the .altinstr_replacement table?  If that sounds 
>>>>ok I'll try to come up with a experimental patch.
>>>>        
>>>>
>>>i.e. something like this (as basic idea, patch is far away from doing 
>>>anything useful ...)?
>>>      
>>>
>>You still need to preserve the originals so that you can patch in both 
>>directions.  
>>    
>>
>
>why do you insist on both directions? That still sounds like real
>overkill to me.
>  
>

It's not overkill in the virtualization context, and there are 
(struggling, but infinite possibilities) opportunities for native here 
as well.  Run-time SMP->UP->SMP can benefit hotplug (albeit slightly).  
But once you have a basic, generic mechanism for run-time code 
modularization, there is very little cost to adding other features.  
Run-time PAE / non-PAE conversion is far more radical, but not outside 
the realm of possibility - and useful (in both directions) for memory 
hotplug.  Run-time CPU vendor migration is possible, if you, say hotplug 
an AMD chip into a previously Intel socket.

Sure, most of this is science fiction.  But the possibilities are great 
- it's another tool you can use towards modularizing functionality - 
specifically, scattered functionality like CPU instructions, spinlocks, 
and MMU operations that really do deserve to be inlined, and really can 
benefit from taking advantage of faster hardware instruction sequences.  
That the tool already exists in a limited form means that with natural 
extensions, it could easily be refined to allow bi-directional or 
multidirectional run-time choices.

Basically, it removes a lot of the barriers that force configuration 
time choices on the running kernel, and you can start to look at even 
deeply entrenched parts of the kernel as modular.

Zach
