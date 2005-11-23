Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751029AbVKWP3K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751029AbVKWP3K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 10:29:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751030AbVKWP3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 10:29:09 -0500
Received: from ns2.suse.de ([195.135.220.15]:25314 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751021AbVKWP3G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 10:29:06 -0500
Message-ID: <43848ABE.7000502@suse.de>
Date: Wed, 23 Nov 2005 16:29:02 +0100
From: Gerd Knorr <kraxel@suse.de>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Dave Jones <davej@redhat.com>,
       Zachary Amsden <zach@vmware.com>, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] SMP alternatives
References: <200511100032.jAA0WgUq027712@zach-dev.vmware.com>	<20051111103605.GC27805@elf.ucw.cz> <4374F2D5.7010106@vmware.com>	<Pine.LNX.4.64.0511111147390.4627@g5.osdl.org>	<4374FB89.6000304@vmware.com>	<Pine.LNX.4.64.0511111218110.4627@g5.osdl.org>	<20051113074241.GA29796@redhat.com>	<Pine.LNX.4.64.0511131118020.3263@g5.osdl.org>	<Pine.LNX.4.64.0511131210570.3263@g5.osdl.org>	<4378A7F3.9070704@suse.de>	<Pine.LNX.4.64.0511141118000.3263@g5.osdl.org>	<4379ECC1.20005@suse.de> <437A0649.7010702@suse.de>	<437B5A83.8090808@suse.de> <438359D7.7090308@suse.de> <p7364qjjhqx.fsf@verdi.suse.de>
In-Reply-To: <p7364qjjhqx.fsf@verdi.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> Gerd Knorr <kraxel@suse.de> writes:
> 
>> Modules are supported now, fully modularized distro kernel works fine
>> with it.  If you have a kernel with HOTPLUG_CPU compiled you can
>> shutdown the second CPU of your dual-processor system via sysfs (echo
>> 0 > /sys/devices/system/cpu/cpu1/online) and watch the kernel switch
>> over to UP code without lock-prefixed instructions and simplified
>> spinlocks, then power up the second CPU again (echo 1 > /sys/...) and
>> watch it patching back in the SMP locking.
> 
> This looks like total overkill to me. Who needs to optimize
> CPU hotplug this way? If you really need this just do it 
> at boot time with the existing mechanisms.

Sure, for real hardware doing that at boot time is be perfectly fine. 
In a virtual environment it's very useful to be able to plug in one more 
virtual CPU on demand without rebooting though.  The patch isn't very 
useful alone, it's more one step on the road of getting the xen bits 
merged mainline.

>> +	/* Paranoia */
>> +	asm volatile ("jmp 1f\n1:");
>> +	mb();
> 
> That would be totally obsolete 386 era paranoia. If anything then use 
> a CLFLUSH (but not available on all x86s) 

Ok, dropped.  I've just copyed that from the original, pretty ugly xen 
patch.

cheers,

   Gerd
