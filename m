Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760271AbWLFGvg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760271AbWLFGvg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 01:51:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760272AbWLFGvg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 01:51:36 -0500
Received: from smtp.osdl.org ([65.172.181.25]:35801 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760271AbWLFGvg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 01:51:36 -0500
Date: Tue, 5 Dec 2006 22:51:26 -0800
From: Andrew Morton <akpm@osdl.org>
To: Oleg Mikheev <mihel@hotbox.ru>
Cc: linux-kernel@vger.kernel.org, "Brown, Len" <len.brown@intel.com>
Subject: Re: kernel 2.6.19 and RealTek RTL8139 interrupt
Message-Id: <20061205225126.d4118036.akpm@osdl.org>
In-Reply-To: <4575BC35.7050008@hotbox.ru>
References: <4575BC35.7050008@hotbox.ru>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Dec 2006 21:36:37 +0300
Oleg Mikheev <mihel@hotbox.ru> wrote:

> Hi guys,
> 
> I'm using FC5 with vanilla kernels.
> Everything worked great until 2.6.19 was released.
> Not each time I'm trying to up my eth0 kernel produces this:
> 
> 
> eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
> irq 18: nobody cared (try booting with the "irqpoll" option)
>   [<c01391aa>] __report_bad_irq+0x36/0x7d
>   [<c0139379>] note_interrupt+0x188/0x1c3
>   [<c0138a19>] handle_IRQ_event+0x1a/0x3f
>   [<c01396ca>] handle_fasteoi_irq+0x61/0x73
>   [<c0104e34>] do_IRQ+0x6b/0x83
>   [<c0120c76>] sys_rt_sigprocmask+0x80/0x93
>   [<c01034a2>] common_interrupt+0x1a/0x20
>   =======================
> handlers:
> [<c0257416>] (rtl8139_interrupt+0x0/0x3aa)
> Disabling IRQ #18
> 
> 
> I'm posting it here b/c I don't think it's a normal behavior.
> Here is the diff of dmesg output between 2.6.18.3 and 2.6.19:
> 
> 
> 140,142c141,143
> < 8139too Fast Ethernet driver 0.9.27
> < ACPI: PCI Interrupt 0000:01:06.0[A] -> GSI 20 (level, low) -> IRQ 20
> < eth0: RealTek RTL8139 at 0xf8806c00, 00:40:45:28:2c:ae, IRQ 20
> ---
>  > 8139too Fast Ethernet driver 0.9.28
>  > ACPI: PCI Interrupt 0000:01:06.0[A] -> GSI 20 (level, low) -> IRQ 18
>  > eth0: RealTek RTL8139 at 0xf8806c00, 00:40:45:28:2c:ae, IRQ 18
> 147c148
> < ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
> ---
>  > ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 19

This looks like http://bugzilla.kernel.org/show_bug.cgi?id=7601

Please see http://bugzilla.kernel.org/show_bug.cgi?id=7601#c10 for a
possible fix.

That fix is in mainline now, so testing Linus's current tree would suit
too, thanks.

