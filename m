Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270870AbTHKDsw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 23:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270882AbTHKDsv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 23:48:51 -0400
Received: from fw.osdl.org ([65.172.181.6]:7817 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270870AbTHKDsu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 23:48:50 -0400
Message-ID: <34161.4.4.25.4.1060573727.squirrel@www.osdl.org>
Date: Sun, 10 Aug 2003 20:48:47 -0700 (PDT)
Subject: Re: /proc/stat's intr field looks odd, although /proc/interrupts seems correct
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: <cmrivera@ufl.edu>
In-Reply-To: <1060572792.1113.10.camel@boobies.awol.org>
References: <1060572792.1113.10.camel@boobies.awol.org>
X-Priority: 3
Importance: Normal
Cc: <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.11)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi,
>
> I am running 2.6.0-test2-mm4 on an SMP machine with dual Athlon MP 2000+s.
>
> /proc/stat displays:
>
> cpu  13261 0 2603 887671 4399
> cpu0 6936 0 1571 443183 2285
> cpu1 6325 0 1031 444488 2113
> intr 5021986 4539589 5476 0 0 0 0 0 0 0 0 0 0 73888 0 16345 11 379144 0 7533
> 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
> 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
> 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
> 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
> 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
> 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
> ctxt 1677244
> btime 1060567182
> processes 1286
> procs_running 1
> procs_blocked 0
>
> /proc/interrupts:
>
>            CPU0       CPU1
>   0:      26530    4875571    IO-APIC-edge  timer
>   1:       6035          0    IO-APIC-edge  i8042
>   2:          0          0          XT-PIC  cascade
>  12:      77657       3869    IO-APIC-edge  i8042
>  14:      16560          1    IO-APIC-edge  ide0
>  15:         11          0    IO-APIC-edge  ide1
>  16:     409959          1   IO-APIC-level  radeon@PCI:1:5:0
>  17:          0          0   IO-APIC-level  EMU10K1
>  18:       7942          0   IO-APIC-level  eth0
> NMI:          0          0
> LOC:    4902124    4902123
> ERR:          0
> MIS:          0
>
> I am not sure why the intr line contains all those zeros.  Is this normal
> behavior?

Yes, for most architectures, it prints interrupts from 0 thru NR_IRQS:
	for (i = 0 ; i < NR_IRQS ; i++)
		len += sprintf(page + len, " %u", kstat_irqs(i));
and NR_IRQS varies depending on the kernel build options, but (for x86)
is usually either 16 or 224.

~Randy



