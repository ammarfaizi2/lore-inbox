Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750738AbWHINDU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbWHINDU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 09:03:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750747AbWHINDU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 09:03:20 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:18392 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S1750738AbWHINDU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 09:03:20 -0400
Date: Wed, 9 Aug 2006 15:03:18 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Pavel Machek <pavel@suse.cz>, LKML <linux-kernel@vger.kernel.org>,
       Suspend2-devel@lists.suspend2.net, linux-pm@osdl.org,
       ncunningham@linuxmail.org
Subject: Re: swsusp and suspend2 like to overheat my laptop
Message-ID: <20060809130318.GA22729@rhlx01.fht-esslingen.de>
References: <Pine.LNX.4.58.0608081612380.17442@gandalf.stny.rr.com> <20060808235352.GA4751@elf.ucw.cz> <Pine.LNX.4.58.0608082215090.20396@gandalf.stny.rr.com> <20060809073958.GK4886@elf.ucw.cz> <Pine.LNX.4.58.0608090732100.2500@gandalf.stny.rr.com> <20060809120734.GA30544@rhlx01.fht-esslingen.de> <Pine.LNX.4.58.0608090837120.3177@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0608090837120.3177@gandalf.stny.rr.com>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Aug 09, 2006 at 08:38:27AM -0400, Steven Rostedt wrote:
> This is after a suspend:
> 
> $ cat /proc/acpi/processor/CPU*/*
> processor id:            0
> acpi id:                 0
> bus mastering control:   yes
> power management:        no
> throttling control:      yes
> limit interface:         yes
> active limit:            P0:T0
> user limit:              P0:T0
> thermal limit:           P0:T0
> active state:            C1
> max_cstate:              C8
> bus master activity:     00000000
> states:
>    *C1:                  type[C1] promotion[--] demotion[--] latency[000]
> usage[00000000] duration[00000000000000000000]
> state count:             4
> active state:            T0
> states:
>    *T0:                  00%
>     T1:                  25%
>     T2:                  50%
>     T3:                  75%

This is almost *exactly* the same as on my very cheap'n stupid HP/Compaq
desktop P4 HT which doesn't support ACPI C2/C3 at all despite proper support
by other P4 HT desktop machines (missing _CST ACPI object in the DSDT,
as confirmed after messing with Intel's DSDT decompiler):

# cat /proc/acpi/processor/CPU?/*
processor id:            0
acpi id:                 1
bus mastering control:   no
power management:        no
throttling control:      yes
limit interface:         yes
active limit:            P0:T0
user limit:              P0:T0
thermal limit:           P0:T0
active state:            C1
max_cstate:              C8
bus master activity:     00000000
states:
   *C1:                  type[C1] promotion[--] demotion[--] latency[000] usage[00000000] duration[00000000000000000000]
state count:             8
active state:            T0
states:
   *T0:                  00%
    T1:                  12%
    T2:                  25%
    T3:                  37%
    T4:                  50%
    T5:                  62%
    T6:                  75%
    T7:                  87%


Note that

max_cstate:              C8

can be considered a bug (this is a C state init value from an ACPI define
mistakenly left unchanged in case of missing _CST) since I thus only have C1
and it should thus be set to C1.

What would be interesting is this output *before* any suspend, not after ;)


Oh, and your temperature after boot goes backwards since booting is a very
active period, obviously.

Andreas
