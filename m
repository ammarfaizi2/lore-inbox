Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750710AbWIBDvJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750710AbWIBDvJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 23:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750776AbWIBDvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 23:51:08 -0400
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:50336 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1750710AbWIBDvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 23:51:06 -0400
From: Grant Coady <gcoady.lk@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com
Subject: Re: 2.6.18-rc5-mm1
Date: Sat, 02 Sep 2006 13:51:04 +1000
Organization: http://bugsplatter.mine.nu/
Reply-To: Grant Coady <gcoady.lk@gmail.com>
Message-ID: <muuhf21hgb5a5vdpdb7i9nds6t5cokqihf@4ax.com>
References: <20060901015818.42767813.akpm@osdl.org> <3tkhf2p4f1n1s7ancfmclrlijvne8nhoit@4ax.com> <20060901183927.eba8179d.akpm@osdl.org>
In-Reply-To: <20060901183927.eba8179d.akpm@osdl.org>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Sep 2006 18:39:27 -0700, Andrew Morton <akpm@osdl.org> wrote:

>On Sat, 02 Sep 2006 11:06:15 +1000
>Grant Coady <gcoady.lk@gmail.com> wrote:
>
>> On Fri, 1 Sep 2006 01:58:18 -0700, Andrew Morton <akpm@osdl.org> wrote:
>> 
>> >
>> >ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc5/2.6.18-rc5-mm1/
>> ...
>> >- See the `hot-fixes' directory for any important updates to this patchset.
>> >
>> Okay, I applied hotfixes and it crashed on boot,
>
>There's another hotfix there now:  
>
>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc5/2.6.18-rc5-mm1/hot-fixes/revert-acpi-mwait-c-state-fixes.patch
>
>If that doesn't prevent the crash, please try to get a trace out of it
>somehow?
>
>> keyboard LEDs flashing: Repeating message, hand copied:
>> atkbd.c: Spurious ACK in isa0060/serio0. Some program might be trying access 
>
>Yes, one of my machine does that when it crashes too.  It makes the crash
>information scroll off the screen in about half a second, which isn't very
>kernel-developer-friendly.

Dmitry's patch stopped the LEDs but gave VFS no root device error, make no 
sense to me so I start over...

Apply 2.6.18-rc5-mm1, then:
File: drivers-md-kconfig-fix-block-dependency.patch
File: provide-kernel_execve-on-all-architectures-fix-2.patch
File: provide-kernel_execve-on-all-architectures-fix-3.patch
File: revert-acpi-mwait-c-state-fixes.patch
File: revert-ide-hpa-resume-fix.patch

Falls over, looping, after a VFS no root message :(

Apply Dmitry's patch...

Okay, we're not doing the silly looping:

Error is same as previously reported.

A couple blank menu screens in other areas, make oldconfig doesn't :(

WTF happened to SATA support?  Where's it hiding now?  Found it...

Okay, boots --> Needs Dmitry's non-looping patch so errors don't scroll off 
screen.  Problem was SATA moved to new window and `make oldconfig` didn't ;)

Grant.

-- 
VGER BF report: H 6.04481e-06
