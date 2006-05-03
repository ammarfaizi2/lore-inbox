Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965181AbWECMl5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965181AbWECMl5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 08:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965182AbWECMl5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 08:41:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:31644 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965181AbWECMl4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 08:41:56 -0400
Date: Wed, 3 May 2006 05:41:49 -0700
From: Andrew Morton <akpm@osdl.org>
To: cel@citi.umich.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc3 PCI init hang
Message-Id: <20060503054149.aae472dd.akpm@osdl.org>
In-Reply-To: <44565BB9.8020504@citi.umich.edu>
References: <44565BB9.8020504@citi.umich.edu>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 01 May 2006 15:04:25 -0400
Chuck Lever <cel@citi.umich.edu> wrote:

> I have a dual Pentium III I use for testing.  Since late last week 
> (around about 2.6.17-rc3) it hangs during boot just after "Setting up 
> standard PCI resources".  2.6.17-rc2 works fine.

Bummer

> A push in the right direction would be appreciated.  Please reply off 
> list as I'm not subscribed.
> 

Is there any chance you can do a git-bisect to find the bad patch?

> ...
> 
> PCI: PCI BIOS revision 2.10 entry at 0xfdbc1, last bus=1
> Setting up standard PCI resources
> 
>  >>> 2.6.17-rc3 stops here and hangs.
>  >>> 2.6.17-rc2 continues with:
> 
> PCI: Probing PCI hardware
> PCI: Discovered peer bus 01
> PCI: Using IRQ router ServerWorks [1166/0200] at 0000:00:0f.0
> PCI->APIC IRQ transform: 0000:00:03.0[A] -> IRQ 31
> PCI->APIC IRQ transform: 0000:01:03.0[A] -> IRQ 23
> PCI: Cannot allocate resource region 0 of device 0000:00:0f.2
> ...
> 
> lspci -v:
> 
> 00:00.0 Host bridge: Broadcom CNB20LE Host Bridge (rev 06)
>          Flags: bus master, medium devsel, latency 32
> 
> 00:00.1 Host bridge: Broadcom CNB20LE Host Bridge (rev 06)
>          Flags: bus master, medium devsel, latency 16
> 
> 00:01.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27) 
> (prog-if 00 [VGA])
>          Subsystem: ATI Technologies Inc Rage XL
>          Flags: bus master, stepping, medium devsel, latency 64
>          Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
>          I/O ports at d800 [size=256]
>          Memory at feaff000 (32-bit, non-prefetchable) [size=4K]
>          Expansion ROM at feac0000 [disabled] [size=128K]
>          Capabilities: <available only to root>
> 
> 00:03.0 RAID bus controller: Promise Technology, Inc. PDC20267 
> (FastTrak100/Ultra100) (rev 02)
>          Subsystem: Promise Technology, Inc.: Unknown device 4d32
>          Flags: bus master, medium devsel, latency 64, IRQ 31
>          I/O ports at dfe0 [size=8]
>          I/O ports at dfac [size=4]
>          I/O ports at dfa0 [size=8]
>          I/O ports at dfa8 [size=4]
>          I/O ports at df00 [size=64]
>          Memory at feaa0000 (32-bit, non-prefetchable) [size=128K]
>          Expansion ROM at feae0000 [size=64K]
>          Capabilities: <available only to root>
> 
> 00:0f.0 ISA bridge: Broadcom OSB4 South Bridge (rev 50)
>          Subsystem: Broadcom OSB4 South Bridge
>          Flags: bus master, medium devsel, latency 0
> 
> 00:0f.1 IDE interface: Broadcom OSB4 IDE Controller (prog-if 8a [Master 
> SecP PriP])
>          Flags: bus master, medium devsel, latency 64
>          I/O ports at ffa0 [size=16]
> 
> 00:0f.2 USB Controller: Broadcom OSB4/CSB5 OHCI USB Controller (rev 04) 
> (prog-if 10 [OHCI])
>          Subsystem: Broadcom OSB4/CSB5 OHCI USB Controller
>          Flags: medium devsel
>          Memory at 30000000 (32-bit, non-prefetchable) [size=4K]
> 
> 01:03.0 Ethernet controller: Netgear GA630 Gigabit Ethernet (rev 01)
>          Subsystem: Netgear GA630 Gigabit Ethernet
>          Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 23
>          Memory at febfc000 (32-bit, non-prefetchable) [size=16K]
> 
> -- 
> corporate:	<cel at netapp dot com>
> personal:	<chucklever at bigfoot dot com>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
