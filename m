Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263148AbUCMSBs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 13:01:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263149AbUCMSBr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 13:01:47 -0500
Received: from linux-bt.org ([217.160.111.169]:63380 "EHLO mail.holtmann.net")
	by vger.kernel.org with ESMTP id S263148AbUCMSAT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 13:00:19 -0500
Subject: Re: [OOPS] Removing USB Bluetooth dongle Oopses 2.6.4
From: Marcel Holtmann <marcel@holtmann.org>
To: Silla Rizzoli <silla@netvalley.it>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200403131351.44682.silla@netvalley.it>
References: <200403131351.44682.silla@netvalley.it>
Content-Type: text/plain
Message-Id: <1079200805.2142.4.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 13 Mar 2004 19:00:05 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Silla,

> Here comes the oops:
> 
> PREEMPT
> CPU:	0
> EIP:	0060:[<e1921149>]	Not tainted
> EIP is at urb_unlink+0x31/0x8e [usbcore]
> eax: c17c069c	ebx: 00000000	ecx: 00000000	edx: dec74000
> esi: 00000246	edi: c17c0694	ebp: de5aa1f0	esp: dec75e14
> ds: 007b   es: 007b   ss: 0068
> Process hotplug (pid: 6150, threadinfo=dec74000 task=dfa6a100)
> Stack: c17c0694 de5aa000 dec75edc c17c0694 dec75edc de5aa000 e19218af c17c0694
>        c17c0694 dec74000 c17c0694 e19f5db4 de5aa000 c17c0694 dec75edc dec75edc
>        de5aa1d0 de5aa1d0 de5aa000 dec75edc e19f5f72 de5aa000 dec75edc 00701300
> Call trace:
>  [<e19218af>] usb_hcd_giveback_urb+0x1b/0x39 [usbcore]
>  [<e19f5db4>] uhci_finish_completion+0x61/0x9c [uhci_hcd]
>  [<e19f5f72>] uhci_irq+0x103/0x165 [uhci_hcd]
>  [<e1921903>] usb_hcd_irq+0x36/0x67 [usbcore]
>  [<c010ae8a>] handle_IRQ_event+0x3a/0x64
>  [<c010b1f7>] do_IRQ+0x94/0x136
>  [<c0116eea>] do_page_fault+0x0/0x50c
>  [<c0109750>] common_interrupt+0x18/0x20
>  [<c0116eea>] do_page_fault+0x0/0x50c
>  [<c0116f11>] do_page_fault+0x27/0x50c
>  [<c0141c0b>] unmap_vmas+0xdc/0x212
>  [<c01451b7>] unmap_vma+0x40/0x7d
>  [<c0145210>] unmap_vma_list+0x1c/0x28
>  [<c0145625>] do_munmap+0x146/0x183
>  [<c0116eea>] do_page_fault+0x0/0x50c
>  [<c010980d>] error_code+0x2d/0x38
> 
> Code: 89 59 04 89 0b 89 40 04 89 47 08 8b 5f 14 56 9d 8b 42 08 83
>  <0>Kernel panic: Fatal exception in interrupt
> In interrupt handler - not syncing

this looks like another unlink-during-submit bug in the uhci-hcd host
driver. With the latest 2.6.4-bk2 the ohci-hcd is now free from it and
an unplug works again without any oops or freezes. Post your oops to the
USB developer mailing list.

Regards

Marcel


