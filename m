Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262041AbVGKSlK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262041AbVGKSlK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 14:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262025AbVGKSjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 14:39:10 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:8921 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S261638AbVGKSgb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 14:36:31 -0400
Date: Mon, 11 Jul 2005 14:36:28 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Michel Bouissou <michel@bouissou.net>
cc: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       <linux-kernel@vger.kernel.org>, <mingo@redhat.com>
Subject: Re: Kernel 2.6.12 + IO-APIC + uhci_hcd = Trouble
In-Reply-To: <200507111106.22951@totor.bouissou.net>
Message-ID: <Pine.LNX.4.44L0.0507111432530.5164-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Jul 2005, Michel Bouissou wrote:

> Hi Nathalie,
> 
> Thanks for your answer and pointer. Unfortunately it doesn't help.
> 
> The patch you mention won't apply on my kernel alone, I need first to apply 
> the patch from 
> http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=c434b7a6aedfe428ad17cd61b21b125a7b7a29ce , 
> then your patch applies OK.
> 
> Unfortunately, it doesn't solve my issue. Booting this kernel still results in 
> an interrupt issue with uhci_hcd.
> 
> After boot, "cat /proc/interrupts" shows:
>            CPU0
>   0:     188066    IO-APIC-edge  timer
>   1:        308    IO-APIC-edge  i8042
>   2:          0          XT-PIC  cascade
>   4:        413    IO-APIC-edge  serial
>   7:          3    IO-APIC-edge  parport0
>  14:       1177    IO-APIC-edge  ide4
>  15:       1186    IO-APIC-edge  ide5
>  18:       1028   IO-APIC-level  eth0, eth1
>  19:       8513   IO-APIC-level  ide0, ide1, ide2, ide3, ehci_hcd:usb4
>  21:     100000   IO-APIC-level  uhci_hcd:usb1, uhci_hcd:usb2, uhci_hcd:usb3
>  22:          0   IO-APIC-level  VIA8233
> NMI:          0
> LOC:     187967
> ERR:          0
> MIS:          0
> 
> (The problem is with IRQ 21 for uhci_hcd)
> 
> (It is to note that without those patches, I didn't see any IRQ managed by 
> "XT-PIC", all were managed by the IO-APIC...)

It's possible that the errors you're getting are caused by some other
device erroneously generating interrupt requests on IRQ 21.  Then when
uhci-hcd enables that IRQ, there's no driver available to handle the 
interrupts...

It's also possible that the UHCI controllers are generating the unwanted 
interrupt requests.  You should make sure that Legacy USB Support is 
turned off in your BIOS settings.  You can also try adding the 
"usb-handoff" kernel parameter to your boot command line.

Alan Stern

