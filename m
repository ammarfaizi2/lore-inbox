Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265868AbTLIOWW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 09:22:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265869AbTLIOWU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 09:22:20 -0500
Received: from jurand.ds.pg.gda.pl ([153.19.208.2]:9358 "EHLO
	jurand.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S265868AbTLIOVe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 09:21:34 -0500
Date: Tue, 9 Dec 2003 15:21:30 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Bob <recbo@nishanet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Catching NForce2 lockup with NMI watchdog
In-Reply-To: <3FD3DFEB.1010902@nishanet.com>
Message-ID: <Pine.LNX.4.55.0312091514130.20948@jurand.ds.pg.gda.pl>
References: <20031205045404.GA307@tesore.local> <16336.13962.285442.228795@alkaid.it.uu.se>
 <20031205085829.GL29119@mis-mike-wstn.matchmail.com> <3FD3DFEB.1010902@nishanet.com>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Dec 2003, Bob wrote:

> I have append="nmi_watchdog=1" ? Nothing "nmi" or "NMI" is logged.
> 
>  cat /proc/interrupts
>            CPU0      
>   0:  241105839          XT-PIC  timer
>   1:      27337    IO-APIC-edge  i8042
>   2:          0          XT-PIC  cascade
>   8:          1    IO-APIC-edge  rtc
>   9:          0   IO-APIC-level  acpi
>  12:     217952    IO-APIC-edge  i8042
>  14:         22    IO-APIC-edge  ide0
>  15:         24    IO-APIC-edge  ide1
>  16:    4245875   IO-APIC-level  3ware Storage Controller, yenta, yenta
>  17:    5428737   IO-APIC-level  eth0
>  21:          0   IO-APIC-level  NVidia nForce2
> NMI:          0
> LOC:  241091187
> ERR:          0
> MIS:          6

 You don't have the NMI watchdog working, because the timer interrupt is
configured as an 8259A interrupt ("XT-PIC" for IRQ 0 in the output above).  
This usually means the wiring of a particular system doesn't provide any
other alternative or configuration data provided by the BIOS is broken.
The timer interrupt has to be configured as an I/O APIC interrupt for the
watchdog to work, or you can select "nmi_watchdog=2" for an alternative 
watchdog internal to processors if they support it.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
