Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262225AbUKDOHx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262225AbUKDOHx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 09:07:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262226AbUKDOHx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 09:07:53 -0500
Received: from out006pub.verizon.net ([206.46.170.106]:31482 "EHLO
	out006.verizon.net") by vger.kernel.org with ESMTP id S262225AbUKDOHY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 09:07:24 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: is killing zombies possible w/o a reboot?
Date: Thu, 4 Nov 2004 09:07:22 -0500
User-Agent: KMail/1.7
Cc: Ian Campbell <icampbell@arcom.com>, Jan Knutar <jk-lkml@sci.fi>,
       Tom Felker <tfelker2@uiuc.edu>
References: <200411030751.39578.gene.heskett@verizon.net> <200411040739.01699.gene.heskett@verizon.net> <1099573266.2856.40.camel@icampbell-debian>
In-Reply-To: <1099573266.2856.40.camel@icampbell-debian>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411040907.22684.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out006.verizon.net from [151.205.11.139] at Thu, 4 Nov 2004 08:07:23 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 04 November 2004 08:01, Ian Campbell wrote:
>On Thu, 2004-11-04 at 07:39 -0500, Gene Heskett wrote:
>> On Thursday 04 November 2004 07:12, Jan Knutar wrote:
>> >On Thursday 04 November 2004 13:57, Gene Heskett wrote:
>> >> I'e had that turned on since forever Jan, but usually, when its
>> >> hung someplace, its well and truely hung, and hardware reset
>> >> button time.
>> >
>> >Are you saying that these zombies (or tasks stuck in state D)
>> > also make sysrq-T hang, and not list all tasks?
>>
>> I thought I'd test it right now while the system is runnng
>> normally, but I got only a beep from the console, so I went to
>> Documentation/sysrq.txt to make sure I was doing it right, and it
>> is _not_ working right now.  But it is compiled in according to a
>> make xconfig, or a grep of the .config.
>
>It can also be enabled/disabled at runtime, Documentation/sysrq.txt
> says that the default now is on (but that it used to default to
> off). Perhaps it is getting turned off somewhere in your boot
> scripts etc.
>
>You can check with
>
>$ cat /proc/sys/kernel/sysrq
>1
>
>> The keyboard is a cheap ($24) M$ with a few extra buttons that
>> don't do anything along the top.  And getting a bit creaky in its
>> old age, a lot like me, but I'm about 68 years older than the
>> keyboard :)
>
>Documentation/sysrq.txt also says:
>
>*  How do I use the magic SysRq key?
>~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>On x86   - You press the key combo 'ALT-SysRq-<command key>'. Note -
> Some keyboards may not have a key labeled 'SysRq'. The 'SysRq' key
> is also known as the 'Print Screen' key. Also some keyboards cannot
> handle so many keys being pressed at the same time, so you might
> have better luck with "press Alt", "press SysRq", "release Alt",
> "press <command key>", release everything.
>
>Perhaps your keyboard is one of those that can't cope with all those
>keys?
>
>Ian.

Possibly, but OTOH,
[root@coyote root]#  cat /proc/sys/kernel/sysrq
0

And no, I'm not turning it off anyplace in the boot proceedure.  An
'echo 1 >/proc/sys/kernel/sysrq', and repeating the keypresses now
gets a boatload of stuff in the logs, but nothing on the console.

The logs look something like this:

Nov  4 08:59:29 coyote kernel: kdeinit       S C0453F08     0 18964   3327         18965 18963 (NOTLB)
Nov  4 08:59:29 coyote kernel: c657ae8c 00200082 c6820120 c0453f08 0000202c 00000000 b4d18366 0000202c
Nov  4 08:59:29 coyote kernel:        00002ecd b4d1e78f 0000202c c6820600 c682075c 0217d045 c657aea0 fffffff5
Nov  4 08:59:29 coyote kernel:        c657aedc c033bca3 c657aea0 0217d045 c657aec4 dfa88ea0 ee3aeea0 0217d045
Nov  4 08:59:29 coyote kernel: Call Trace:
Nov  4 08:59:29 coyote kernel:  [<c033bca3>] schedule_timeout+0x63/0xc0
Nov  4 08:59:29 coyote kernel:  [<c0120150>] process_timeout+0x0/0x10
Nov  4 08:59:29 coyote kernel:  [<c012c12f>] futex_wait+0x12f/0x1a0
Nov  4 08:59:29 coyote kernel:  [<c0114160>] default_wake_function+0x0/0x20
Nov  4 08:59:29 coyote kernel:  [<c0114160>] default_wake_function+0x0/0x20
Nov  4 08:59:29 coyote kernel:  [<c012c418>] do_futex+0x48/0xa0
Nov  4 08:59:29 coyote kernel:  [<c012c55e>] sys_futex+0xee/0x100
Nov  4 08:59:29 coyote kernel:  [<c01040a9>] sysenter_past_esp+0x52/0x71
Nov  4 08:59:29 coyote kernel: kdeinit       S C0453A60     0 18965   3327         18966 18964 (NOTLB)
Nov  4 08:59:29 coyote kernel: dfa88e8c 00200082 c6820120 c0453a60 dfa88eac 00000000 ed99e990 00000000
Nov  4 08:59:29 coyote kernel:        00006be7 b816258b 0000202c c6820120 c682027c 0217d07c dfa88ea0 fffffff5
Nov  4 08:59:29 coyote kernel:        dfa88edc c033bca3 dfa88ea0 0217d07c dfa88ec4 c0459928 c657aea0 0217d07c
Nov  4 08:59:29 coyote kernel: Call Trace:
Nov  4 08:59:29 coyote kernel:  [<c033bca3>] schedule_timeout+0x63/0xc0
Nov  4 08:59:29 coyote kernel:  [<c0120150>] process_timeout+0x0/0x10
Nov  4 08:59:29 coyote kernel:  [<c012c12f>] futex_wait+0x12f/0x1a0
Nov  4 08:59:29 coyote kernel:  [<c0114160>] default_wake_function+0x0/0x20
Nov  4 08:59:29 coyote kernel:  [<c0114160>] default_wake_function+0x0/0x20
Nov  4 08:59:29 coyote kernel:  [<c012c418>] do_futex+0x48/0xa0
Nov  4 08:59:29 coyote kernel:  [<c012c55e>] sys_futex+0xee/0x100
Nov  4 08:59:29 coyote kernel:  [<c01040a9>] sysenter_past_esp+0x52/0x71
Nov  4 08:59:29 coyote kernel: kdeinit       S C0453A60     0 18966   3327               18965 (NOTLB)
Nov  4 08:59:29 coyote kernel: ee3aee8c 00200082 e770fb00 c0453a60 ee3aeeac 00000000 ed99e990 00000000
Nov  4 08:59:29 coyote kernel:        00001e29 b4b250fe 0000202c e770fb00 e770fc5c 0217d043 ee3aeea0 fffffff5
Nov  4 08:59:29 coyote kernel:        ee3aeedc c033bca3 ee3aeea0 0217d043 666c6573 c657aea0 c039be78 0217d043
Nov  4 08:59:29 coyote kernel: Call Trace:
Nov  4 08:59:29 coyote kernel:  [<c033bca3>] schedule_timeout+0x63/0xc0
Nov  4 08:59:29 coyote kernel:  [<c0120150>] process_timeout+0x0/0x10
Nov  4 08:59:29 coyote kernel:  [<c012c12f>] futex_wait+0x12f/0x1a0
Nov  4 08:59:29 coyote kernel:  [<c0114160>] default_wake_function+0x0/0x20
Nov  4 08:59:29 coyote kernel:  [<c0114160>] default_wake_function+0x0/0x20
Nov  4 08:59:29 coyote kernel:  [<c012c418>] do_futex+0x48/0xa0
Nov  4 08:59:29 coyote kernel:  [<c012c55e>] sys_futex+0xee/0x100
Nov  4 08:59:29 coyote kernel:  [<c01040a9>] sysenter_past_esp+0x52/0x71

There is a lot more of that of that above that snip, several pages.
And of course the system seems to be running fine ATM. :-)
But I'm learning, and that echo will go into my rc.local as soon as
I'm done here.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.28% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
