Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262575AbVDGTrd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262575AbVDGTrd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 15:47:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262576AbVDGTrd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 15:47:33 -0400
Received: from alog0049.analogic.com ([208.224.220.64]:50913 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262575AbVDGTrI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 15:47:08 -0400
Date: Thu, 7 Apr 2005 15:46:20 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux-2.6.11 can't disable CAD
In-Reply-To: <20050407115904.1d1ee28f.rddunlap@osdl.org>
Message-ID: <Pine.LNX.4.61.0504071538120.7168@chaos.analogic.com>
References: <Pine.LNX.4.61.0504071102590.4871@chaos.analogic.com>
 <20050407115904.1d1ee28f.rddunlap@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Apr 2005, Randy.Dunlap wrote:

> On Thu, 7 Apr 2005 11:16:14 -0400 (EDT) Richard B. Johnson wrote:
>
> |
> | In the not-too distant past, one could disable Ctl-Alt-DEL.
> | Can't do it anymore.
>
> What should disabling C_A_D do?
>
> | Script started on Thu 07 Apr 2005 10:58:11 AM EDT
> | [SNIPPED leading stuff...]
> |
> | mprotect(0xb7fe4000, 28672, PROT_READ|PROT_EXEC) = 0
> | brk(0)                                  = 0x804a000
> | brk(0x8053000)                          = 0x8053000
> | reboot(LINUX_REBOOT_MAGIC1, LINUX_REBOOT_MAGIC2, LINUX_REBOOT_CMD_CAD_OFF)
> = 0
> | pause( <unfinished ...>
> | _exit(0)                                = ?
> | # exit
> | Script done on Thu 07 Apr 2005 10:58:21 AM EDT
>

It's a program that executes the __NR_reboot syscall (88) after
putting the documented values into the appropriate registers.

> What program is that?  I'm just echoing 0 | 1 into
> /proc/sys/kernel/ctrl-alt-del , is that equivalent?
> or have you tried that?
>

Doesn't matter. Many embedded systems don't have /proc because
they don't have any file-systems.

> | Observe that reboot() returns 0 and `strace` understands what
> | parameters were passed. The result is that, if I hit Ctl-Alt-Del,
> | `init` will still execute the shutdown-order (INIT 0).
>
> echo 0 > /proc/sys/kernel/ctrl-alt-del
>  is same as CAD_OFF
> echo 1
>  is same as CAD_ON
>
> I tested 2.4.28, 2.6.3, 2.6.9, 2.6.11, and all of them behaved
> the same way for me.  If it's an issue with using a syscall
> to change the setting, I'll be glad to look into that too.
>
> observed behaviors:
> CAD enabled + C_A_D keys => call machine_reboot()
>  to reboot quickly, no normal shutdown sequence;
> CAD disabled + C_A_D keys => kill init, go thru normal
>  clean shutdown sequence;
> are these the expected behaviors?

The expected behavior of the reported operation is for
Ctl-Alt-Del to no longer do anything. If the system-call
has been depreciated, then the call should return -1 and
errno should be ENOSYS. In such a case, I would have
to trap the key-sequence in some other way, not that
I know how without modifying the kernel.

>
> | A side note, while researching this problem, I think I found
> | that LINUX_REBOOT_MAGIC2 is Linus' birthday (in hex). Maybe
> | the problem is that he no longer observes his birthday?
>
> ---
> ~Randy
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
