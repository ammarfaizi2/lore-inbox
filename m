Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161375AbWHDTZH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161375AbWHDTZH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 15:25:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161378AbWHDTZH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 15:25:07 -0400
Received: from smtp.osdl.org ([65.172.181.4]:1958 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161375AbWHDTZG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 15:25:06 -0400
Date: Fri, 4 Aug 2006 12:24:57 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
cc: Dave Jones <davej@codemonkey.org.uk>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18-rc3-g3b445eea BUG: warning at
 /usr/src/linux-git/kernel/cpu.c:51/unlock_cpu_hotplug()
In-Reply-To: <6bffcb0e0608041204u4dad7cd6rab0abc3eca6747c0@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0608041222400.5167@g5.osdl.org>
References: <6bffcb0e0608041204u4dad7cd6rab0abc3eca6747c0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 4 Aug 2006, Michal Piotrowski wrote:
> 
> This was reported
> http://www.ussg.iu.edu/hypermail/linux/kernel/0607.3/1867.html
> http://www.ussg.iu.edu/hypermail/linux/kernel/0608.0/0675.html
> 
> It's time to use git-bisect.
> 
> BUG: warning at /usr/src/linux-git/kernel/cpu.c:51/unlock_cpu_hotplug()

Ok, that really is a pretty scary thing. The warning happens if the lock 
is released by somebody else than the person who took it. I don't _think_ 
that's supposed to happen, but with cpu hotplug locking being as 
"creative" as it is, maybe it's valid. 

I was planning on shutting the cpu hotplug warnings up for v2.6.18 - at 
least the "lukewarm IQ" one for _taking_ the lock recursively. But I had 
planned on leaving the unlock_cpu_hotplug() in place, since up until now 
it hadn't triggered, and it really smells like a bug if it does.

> [<c0132a04>] unlock_cpu_hotplug+0x2c/0x54
> [<c013a2ec>] stop_machine_run+0x2e/0x34
> [<c0135686>] sys_init_module+0x15a0/0x178a
> [<c015b7b7>] do_sync_read+0xb6/0xf1
> [<c0102d51>] sysenter_past_esp+0x56/0x79


DaveJ, any ideas?

		Linus
