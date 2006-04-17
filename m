Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750796AbWDQNKd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbWDQNKd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 09:10:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750815AbWDQNKc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 09:10:32 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:17359 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750796AbWDQNKc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 09:10:32 -0400
Subject: Re: irqbalance mandatory on SMP kernels?
From: Arjan van de Ven <arjan@infradead.org>
To: "Robert M. Stockmann" <stock@stokkie.net>
Cc: linux-kernel@vger.kernel.org, Randy Dunlap <rddunlap@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Andre Hedrick <andre@linux-ide.org>,
       Manfred Spraul <manfreds@colorfullife.com>, Alan Cox <alan@redhat.com>,
       Kamal Deen <kamal@kdeen.net>
In-Reply-To: <Pine.LNX.4.44.0604171438490.14894-100000@hubble.stokkie.net>
References: <Pine.LNX.4.44.0604171438490.14894-100000@hubble.stokkie.net>
Content-Type: text/plain
Date: Mon, 17 Apr 2006 15:10:22 +0200
Message-Id: <1145279422.2847.44.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> [jackson:stock]:(/usr/src/linux)$ cat /proc/interrupts 
>            CPU0       CPU1       
>   0:    3139568          0    IO-APIC-edge  timer
>   1:       8923          0    IO-APIC-edge  i8042
>   3:         10          0    IO-APIC-edge  serial
>   4:         37          0    IO-APIC-edge  serial
>   8:          0          0    IO-APIC-edge  rtc
>   9:        240          0   IO-APIC-level  acpi
>  12:      75316          0    IO-APIC-edge  i8042
>  14:      64291          0    IO-APIC-edge  ide0
>  15:      64291          0    IO-APIC-edge  ide1
>  16:     235408          0   IO-APIC-level  HiSax, nvidia
>  17:      15823          0   IO-APIC-level  libata, AMD AMD8111
>  19:        241          0   IO-APIC-level  ohci_hcd, ohci_hcd, ohci1394
>  24:      50761          0   IO-APIC-level  eth0
> NMI:         89         28 
> LOC:    3139042    3139125 
> ERR:          0
> MIS:          0
> [jackson:stock]:(/usr/src/linux)$ 

this may or may not be a problem depending on how long a time you used
to collect this. Based on your timer tick count it really looks like
your irq rates are so low that it really doesn't matter much

> 
> Only when firing up the irqbalance util at boot time will activate
> true SMP, distributing IRQ's across CPU's. Is this on purpose?
> Because afaik a Linux SMP kernel, 2.4.xx or 2.6.xx should always
> result in distributed IRQ loads across CPU's.

that is a chipset feature if it happens; not all chipsets do this (and
most that do, do it badly). 

I'm not sure what your actual problem is btw, the irqbalance tool is
supposed to automatically start at boot, did it not do that ?
(and no the kernel doesn't need to do everything, something like this
can perfectly well be done in userspace as irqbalance shows)

