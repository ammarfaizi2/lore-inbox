Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750868AbVKWOv1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750868AbVKWOv1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 09:51:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750874AbVKWOv1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 09:51:27 -0500
Received: from ns2.suse.de ([195.135.220.15]:32734 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750862AbVKWOv0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 09:51:26 -0500
To: Gerd Knorr <kraxel@suse.de>
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
References: <200511100032.jAA0WgUq027712@zach-dev.vmware.com>
	<20051111103605.GC27805@elf.ucw.cz> <4374F2D5.7010106@vmware.com>
	<Pine.LNX.4.64.0511111147390.4627@g5.osdl.org>
	<4374FB89.6000304@vmware.com>
	<Pine.LNX.4.64.0511111218110.4627@g5.osdl.org>
	<20051113074241.GA29796@redhat.com>
	<Pine.LNX.4.64.0511131118020.3263@g5.osdl.org>
	<Pine.LNX.4.64.0511131210570.3263@g5.osdl.org>
	<4378A7F3.9070704@suse.de>
	<Pine.LNX.4.64.0511141118000.3263@g5.osdl.org>
	<4379ECC1.20005@suse.de> <437A0649.7010702@suse.de>
	<437B5A83.8090808@suse.de> <438359D7.7090308@suse.de>
From: Andi Kleen <ak@suse.de>
Date: 23 Nov 2005 12:17:58 -0700
In-Reply-To: <438359D7.7090308@suse.de>
Message-ID: <p7364qjjhqx.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gerd Knorr <kraxel@suse.de> writes:

> Now, some days hacking & debugging and kernel crashing later I have
> something more than just proof-of-concept ;)
> 
> Modules are supported now, fully modularized distro kernel works fine
> with it.  If you have a kernel with HOTPLUG_CPU compiled you can
> shutdown the second CPU of your dual-processor system via sysfs (echo
> 0 > /sys/devices/system/cpu/cpu1/online) and watch the kernel switch
> over to UP code without lock-prefixed instructions and simplified
> spinlocks, then power up the second CPU again (echo 1 > /sys/...) and
> watch it patching back in the SMP locking.

This looks like total overkill to me. Who needs to optimize
CPU hotplug this way? If you really need this just do it 
at boot time with the existing mechanisms. This would keep
it much simpler and simplicity is very important with 
such code because otherwise the testing of all the corner 
cases will kill you.

BTW the existing mechanism already works fine for modules too.

> +	/* Paranoia */
> +	asm volatile ("jmp 1f\n1:");
> +	mb();

That would be totally obsolete 386 era paranoia. If anything then use 
a CLFLUSH (but not available on all x86s) 

-Andi

