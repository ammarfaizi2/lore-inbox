Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750729AbWE1LiY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbWE1LiY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 07:38:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750738AbWE1LiY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 07:38:24 -0400
Received: from smtp2.poczta.interia.pl ([213.25.80.232]:29197 "EHLO
	smtp.poczta.interia.pl") by vger.kernel.org with ESMTP
	id S1750729AbWE1LiY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 07:38:24 -0400
Message-ID: <44798B99.9070608@interia.pl>
Date: Sun, 28 May 2006 13:38:01 +0200
From: =?windows-1252?Q?Rafa=3F_Bilski?= <rafalbilski@interia.pl>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Dave Jones <davej@codemonkey.org.uk>
Subject: Re: [ PATCH ] Longhaul - call suspend(PMSG_FREEZE) before and	resume()
 after
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-EMID: a4ddcacc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is an horrible hack that breaks so many defined semantics that it's
> not even funny.

> If you want something like that, then you need to freeze/resume _all_
> devices with the proper ordering defined by the bus linkage. It has a
> number of side effects though, can't be done that easily. Maybe cpufreq
> should have the necessary infrastructure for that ?

> That's the wrong approach. If you need to stop
> DMA's during the frequency change, you either need to fix all drivers to
> register cpufreq notifiers that do so (ick !) or if you want to reuse
> the PM callbacks, you need to respect their semantics, notably vs. call
> ordering, or very bad things will happen.

> If we want to go that way, we probably need to add a bit of
> infrastructure to cpufreq to cooperate with the PM code to trigger a
> "light" machine suspend/resume, though expect delays and artifacts, it's
> not something that code be done lightly.

> Ben.

I'm toys salesman. I don't think that I'm capable.
There is already necessary infrastructure (PM). I can do freeze for all 
devices with just one function call. Problem is that only block devices 
implement freeze. Most devices do suspend insteed of freeze. Some 
devices (Speedtouch) don't implement suspend/resume. After USB power 
down You have to unplug modem.
Block devices are at top level? If I remove PCI suspend/resume 
(network card compatible) will this be OK? Other subsystems 
are visible. Can block subsystem be visible too?


> But you should really add that preempt_disable and not try this on smp
> system...
	
> Pavel

Datasheet for my C3 Nehemiah says that this processor don't have local 
APIC and is not SMP capable. I have assumed (based on original longhaul.c) 
that all VIA C3 are not SMP capable.

Would You consider appling part of this patch if I add all my assumptions
to Kconfig?

depends on EXPERIMENTAL && (HZ_100 || HZ_250) && (PREEMPT_NONE || PREEMPT_VOLUNTARY)

Rafal


----------------------------------------------------------------------
Potrzebujesz gotowki? Halogotowka to nawet 50 000 bez wizyty w banku.
Rata od 35 zl, bez poreczycieli. Wypelnij formularz. Oddzwonimy.
>>> http://link.interia.pl/f1942

