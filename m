Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262546AbVDPB01@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262546AbVDPB01 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 21:26:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262548AbVDPB01
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 21:26:27 -0400
Received: from unused.mind.net ([69.9.134.98]:37261 "EHLO echo.lysdexia.org")
	by vger.kernel.org with ESMTP id S262546AbVDPB0X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 21:26:23 -0400
Date: Fri, 15 Apr 2005 18:24:55 -0700 (PDT)
From: William Weston <weston@sysex.net>
X-X-Sender: weston@echo.lysdexia.org
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org, dwalker@mvista.com,
       Steven Rostedt <rostedt@goodmis.org>
Subject: Re: BUGs in 2.6.12-rc2-RT-V0.7.45-01
In-Reply-To: <20050415080138.GA25262@elte.hu>
Message-ID: <Pine.LNX.4.58.0504151721410.18107@echo.lysdexia.org>
References: <Pine.LNX.4.58.0504121443310.3023@echo.lysdexia.org>
 <20050412230921.GA22360@elte.hu> <Pine.LNX.4.58.0504141352490.14125@echo.lysdexia.org>
 <20050415080138.GA25262@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Apr 2005, Ingo Molnar wrote:

> * William Weston <weston@sysex.net> wrote:
> 
> > On Wed, 13 Apr 2005, Ingo Molnar wrote:
> > 
> > > what are you using kprobes for? Do you get lockups even if you disable 
> > > kprobes?
> > 
> > Various processes will lockup on the P4/HT system, usually while under 
> > some load.  The processes cannot be killed.  X will lockup once or 
> > twice a day (which means my console, and thus sysrq, are toast), but I 
> > can still ssh in.  Nothing is logged by the kernel.  Are there any 
> > post-lockup forensics that can be performed before I reboot?
> 
> could you try the -44-03 patch:
> 
>  http://redhat.com/~mingo/realtime-preempt/older/realtime-preempt-2.6.12-rc2-V0.7.44-03
> 
> this doesnt have the plist changes yet. Is this one more stable?

With 2.6.12-rc2-V0.7.44-03, the P4/HT box has been stable all day.  I'm 
seeing another BUG on boot, not kprobes related this time:

Freeing unused kernel memory: 192k freed
logips2pp: Detected unknown logitech mouse model 86
input: ImExPS/2 Logitech Explorer Mouse on isa0060/serio1
BUG: kstopmachine:1054 RT task yield()-ing!
 [<c0103dba>] dump_stack+0x23/0x25 (20)
 [<c030ff1f>] yield+0x67/0x69 (20)
 [<c0142a44>] stop_machine+0xa4/0x15e (40)
 [<c0142b2d>] do_stop+0x15/0x77 (20)
 [<c0132c5b>] kthread+0xab/0xd3 (48)
 [<c0100fe9>] kernel_thread_helper+0x5/0xb (563617812)
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<c013bca6>] .... print_traces+0x1b/0x52
.....[<c0103dba>] ..   ( <= dump_stack+0x23/0x25)

ns83820.c: National Semiconductor DP83820 10/100/1000 driver.
eth0: ns83820.c: 0x22c: 49001186, subsystem: 1186:4900
eth0: ns83820 v0.20: DP83820 v1.2: 00:50:ba:37:d4:bc io=0xff8ff000 irq=18 f=sg


I'm also seeing an unlikely wakeup time:

(               X-3581 |#1): new 2533412143 us maximum-latency wakeup.


Otherwise, this on seems very stable.


Best Regards,
--William Weston


--
/* William Weston <weston@sysex.net> */
