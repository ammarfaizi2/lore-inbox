Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751797AbWEFAMZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751797AbWEFAMZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 20:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751798AbWEFAMZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 20:12:25 -0400
Received: from anchor-post-33.mail.demon.net ([194.217.242.91]:27912 "EHLO
	anchor-post-33.mail.demon.net") by vger.kernel.org with ESMTP
	id S1751797AbWEFAMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 20:12:24 -0400
Date: Sat, 06 May 2006 00:30:00 +0100
From: Darren Salt <linux@youmustbejoking.demon.co.uk>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Mail-Followup-To: linux@youmustbejoking.demon.co.uk,akpm@osdl.org,linux-kernel@vger.kernel.org
Subject: Re: Log flood: "scheduling while atomic" (2.6.15.x, 2.6.16.x)
Message-ID: <4E227CE734%linux@youmustbejoking.demon.co.uk>
References: <4E1F56DC10%linux@youmustbejoking.demon.co.uk> <20060429182220.0a306fe2.akpm@osdl.org>
In-Reply-To: <20060429182220.0a306fe2.akpm@osdl.org>
User-Agent: Messenger-Pro/4.09b8 (MsgServe/3.24b1) (RISC-OS/4.02) POPstar/2.06+cvs
X-Editor: Zap 1.47 (27 Apr 2006) [TEST], ZapEmail 0.28.3 (25 Mar 2005) (32)
X-SDate: Sat, 4631 Sep 1993 00:30:00 +0100
X-Message-Flag: Outlook Express is broken. Upgrade to mail(1).
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Connect-IP: 192.168.0.2
X-SA-Exim-Mail-From: linux@youmustbejoking.demon.co.uk
X-SA-Exim-Scanned: No (on pentagram.youmustbejoking.demon.co.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I demand that Andrew Morton may or may not have written...

> Darren Salt <linux@youmustbejoking.demon.co.uk> wrote:
>> I'm seeing bouts of log flooding caused by something presumably not
>> releasing a lock. I've looked at some of the messages, but at around
>> 100/s, I'm not too keen to look through the whole lot :-)
>>    scheduling while atomic: swapper/0xafbfffff/0
>>     [show_trace+19/32]
>>     [dump_stack+30/32]
>>     [schedule+1278/1472]
>>     [cpu_idle+88/96]
[snip]
> Thanks for the report.

> The below patch (against 2.6.17-rc3) should, if it still works, tell us
> which lock didn't get unlocked.
[snip]

I got two apparent panics earlier this week (no log due to not having enabled
serial or net console). I quickly removed my rate-limit hack (just in case)
and enabled net console and did a full kernel build, install and reboot. It
has to be net console since the other machine which is up 24/7 has both
serial ports already in use. (Hmm, maybe a USB<->serial adapter...?)

Since then, I've had no problems, and I'd got this message queued for
sending. With impeccable timing, the bug is triggered...

Unfortunately, all that's been logged by the preempt debug code is this:

  kernel BUG at lib/preempt.c:32!

As in the two previous instances, the machine is responding to pings and
sysrq; reboot works fine.

Looking again at that patch, I'm getting the impression that I should have
pressed SysRq-T. Next time it bites - and, with this kernel, it surely will -
I'll do that in case it helps.

-- 
| Darren Salt    | linux or ds at              | nr. Ashington, | Toon
| RISC OS, Linux | youmustbejoking,demon,co,uk | Northumberland | Army
| + Generate power using sun, wind, water, nuclear.      FORGET COAL AND OIL.

War spares not the brave, but the cowardly.
