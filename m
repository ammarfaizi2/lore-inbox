Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbTKCIts (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 03:49:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261506AbTKCIts
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 03:49:48 -0500
Received: from fw.osdl.org ([65.172.181.6]:62081 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261411AbTKCItr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 03:49:47 -0500
Date: Mon, 3 Nov 2003 00:52:18 -0800
From: Andrew Morton <akpm@osdl.org>
To: Gary Wolfe <gpwolfe@cableone.net>
Cc: linux-kernel@vger.kernel.org, Manfred Spraul <manfred@colorfullife.com>
Subject: Re: [crash/panic] Linux-2.6.0-test9
Message-Id: <20031103005218.6dc72800.akpm@osdl.org>
In-Reply-To: <3FA5FFF7.2020006@cableone.net>
References: <3FA5FFF7.2020006@cableone.net>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gary Wolfe <gpwolfe@cableone.net> wrote:
>
> Greetings,
> 
> I have:
> 
> Asus P4C800 Deluxe w/2.4GHz P4 (no HT and not 800Mhz bus)
> 
> Tried test8 and, now, test9 and both exhibit same problem.
> 
> The issue seems to be related to the PnPBIOS support under the Plug and 
> Play Kconfig category.  When enabled I get a crash of the form:
> 
> Linux Plug and Play Support v0.97 (c) Adam Belay
> PnPBIOS: Scanning system for PnP BIOS support...
> PnPBIOS: Found PnP BIOS installation structure at 0xc00f5350
> PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x5f3a, dseg 0xf0000
> general protection fault: 0000 [#1]
> CPU: 0
> EIP: 0098:[<00002b60>] Not tainted
> EFLAGS: 00010083
> EIP is at 0x2b60
> eax: 000023d6  ebx: 0000007a  ecx: 00010000  edx: 00000001
> esi: dfed244e  edi: 0000006d  ebp: dfed0000  esp: dfed9eda

Your stack pointer became misaligned.  I thought Manfred fixed that?
You don't have nmi_watchdog enabled on the kernel boot command line
do you?

> ds: 00b0  es: 00b0  ss: 0068
> Process Swapper (pid:1 threadinfo=dfed8000 task=c151b900)
> Stack: 000003d6 23d629d2 00000000 815d006d 0000d3ff 00010001 9f2c80fc 
> 006dd408
> 9f2c0000 d3ff9f08 00060001 61f990c0c 010c010c 007b6054 0000007b 00a08000
> 601000b0 00a85fd6 00000082 000b0000 00010090 00a80000 00b00000 00a00001
> Call Trace:
> 
> Code: Bad EIP value.
> <0>Kernel panic: Attempted to kill init!
> 
> ....blinking  cursor and nothing else.
> 
> If I remove the PNPBIOS option I get past this point.  I would be happy 
> to email my full .config should anyone wish to look at it.  I'd also be 
> happy to test any patches anyone may have for this issue.
> 

