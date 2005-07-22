Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261329AbVGVRP3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261329AbVGVRP3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 13:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262119AbVGVRP3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 13:15:29 -0400
Received: from pne-smtpout1-sn2.hy.skanova.net ([81.228.8.83]:51417 "EHLO
	pne-smtpout1-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S261329AbVGVRP1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 13:15:27 -0400
Date: Fri, 22 Jul 2005 19:15:10 +0200
From: Voluspa <voluspa@telia.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: jesper.juhl@gmail.com, lista1@telia.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3 Battery times at 100/250/1000 Hz = Zero difference
Message-Id: <20050722191510.5e120515.voluspa@telia.com>
In-Reply-To: <20050722144855.GA2036@elf.ucw.cz>
References: <20050721200448.5c4a2ea0.lista1@telia.com>
	<9a8748490507211114227720b0@mail.gmail.com>
	<20050722144855.GA2036@elf.ucw.cz>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jul 2005 16:48:55 +0200 Pavel Machek wrote:
[...]
.......Jesper Juhl wrote
> > Ok, so with an idle machine, different HZ makes no noticeable
> > difference, but I'd suspect things would be different if the machine
> > was actually doing some work.
> > Would be more interresting to see how long it lasts with a light
> > load and with a heavy load.
> 
> No, I do not think so. Biggest difference should be on completely idle
> machine where ACPI can utilize low power states.
> 
> Can you check that C3 is utilized? Unloading usb modules may be
> neccessary...

I've been reading/checking up on this the last four hours since I
had a nagging suspicion that the CPU indeed didn't enter a sleep
state. With all the abbreviations in the ACPI field (S1, C1, P1 etc)
it killed a fair amount of brain cells, but I'd still call faul on this:

from /var/log/kernel
[powernow-k8 module loads processor module which says]
ACPI: CPU0 (power states: C1[C1])

and catting /proc/acpi/processor/CPU0/power gives
active state: C1
max_cstate: C8
bus master activity: 00000000
states:
   *C1: type[C1] promotion[--] demotion[--] latency[000] usage[02998796]

/sys/module/processor/parameters/max_cstate says 8
/sys/module/processor/parameters/bm_history says 4294967295

So I'm a bit baffled that no C2/C3 turns up. I've done a test-compile
with all of ACPI in kernel instead of as modules, but there was no
difference.

I'll unload the whole USB-module part and boot without loading them, but
will it matter? Please provide more details about how to debug this
(very confusing) field.

Mvh
Mats Johannesson
--
