Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265649AbSKOHpi>; Fri, 15 Nov 2002 02:45:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265667AbSKOHpi>; Fri, 15 Nov 2002 02:45:38 -0500
Received: from mail1.csc.albany.edu ([169.226.1.133]:48872 "EHLO
	smtp.albany.edu") by vger.kernel.org with ESMTP id <S265649AbSKOHph> convert rfc822-to-8bit;
	Fri, 15 Nov 2002 02:45:37 -0500
Content-Type: text/plain; charset=US-ASCII
From: Justin A <ja6447@albany.edu>
To: Andrew Morton <akpm@digeo.com>
Subject: Re: 2.5.47-ac4 panic on boot.
Date: Fri, 15 Nov 2002 02:54:25 -0500
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <200211150059.51743.ja6447@albany.edu> <3DD49520.7927434C@digeo.com>
In-Reply-To: <3DD49520.7927434C@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211150254.25306.ja6447@albany.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I did that...
Disabling PM made it boot:

< CONFIG_PM=y
< CONFIG_APM=m
< # CONFIG_APM_IGNORE_USER_SUSPEND is not set
< CONFIG_APM_DO_ENABLE=y
< CONFIG_APM_CPU_IDLE=y
< CONFIG_APM_DISPLAY_BLANK=y
< # CONFIG_APM_RTC_IS_GMT is not set
< # CONFIG_APM_ALLOW_INTS is not set
< # CONFIG_APM_REAL_MODE_POWER_OFF is not set
---
> # CONFIG_PM is not set


I think I still had swsusp on before I disabled PM...I will have to test more 
tomorrow to make sure thats it...
Perhaps its the CONFIG_APM_CPU_IDLE that did it?

I had tried linux init=/bin/sh, which got to the shell, then 2 seconds later 
paniced, so I have a feeling its the idle thingy:)

On another note, pcibios_read_config_dword seems to be missing, and 
pcmcia-core wants it.  I'll have to see whats up with that tomorrow...but at 
least I got it booting now:)

-- 
-Justin


On Friday 15 November 2002 01:33 am, Andrew Morton wrote:
> Justin A wrote:
> > My thinkpad 760e starts to boot but panics while running depmod -a:
> > (unfortunately the top is cut off...it doesn't fit:))
> >
> > ...
> > CPU:    0
> > EIP:    0060:[<c012b914>]       Not tainted
> > EFLAGS: 00010006
> > EIP is at reap_timer_fnc+0x104/0x40c
> > eax: 00000002   ebx: c47ffab4   ecx: c47fe8a0   edx: 00000003
> > esi: 00000002   edi: c4742414   ebp: c47ffa98   esp: c031df8c
> > ds: 0068   es: 0068   ss: 0068
> > Process swapper (pid: 0, threadinfo=c031c000 task=c02da3e0)
> > Stack: same as call trace...
> >
> > Call trace:
> >  [<c012b810>] reap_timer_fnc+0x0/0x40c
> >  [<c011ae47>] run_timer_tasklet+0xb7/0xe8
> >  [<c0117f39>] tasklet_hi_action+0x3d/0x60
> >  [<c0117d5a>] do_softirq+0x5a/0xac
> >  [<c010a268>] do_IRQ+0xc8/0xd4
> >  [<c0105000>] stext+0x0/0x1c
> >  [<c0108b03>] common_interrupt+0x43/x060
> >
> > Code: 0f 0b fb 07 a8 fe 21 c0 8d 74 26 00 8b 41 04 8b 11 89 42 04
> >
> > I tried it a few times...the last few change, but its always in
> > reap_timer_fnc.
>
> This is probably a dodgy device driver doing something bad with
> kmalloced memory.
>
> If you have time, please go through and disable various drivers
> in config, see if you can isolate it to a particular one.
>
> Thanks.

