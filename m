Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750950AbWFBBuV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750950AbWFBBuV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 21:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751088AbWFBBuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 21:50:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:1951 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750950AbWFBBuU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 21:50:20 -0400
Date: Thu, 1 Jun 2006 18:54:35 -0700
From: Andrew Morton <akpm@osdl.org>
To: Marc Koschewski <marc@osknowledge.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BUG: soft lockup detected on CPU#0!
Message-Id: <20060601185435.b329b6d1.akpm@osdl.org>
In-Reply-To: <20060602010223.GA9460@stiffy.osknowledge.org>
References: <20060602010223.GA9460@stiffy.osknowledge.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Jun 2006 03:02:24 +0200
Marc Koschewski <marc@osknowledge.org> wrote:

> here what I got when I connected my mobile phone via gnome-phone-manager and a
> bluetooth PCMCIA adapter. The machine freezes when I connect and attached is
> what dmesg says after I ejected the card. The card had /dev/ttyS3 assigned and I
> used it as my setting in gnome-phone-manager.
> 
> [4296372.670000] BUG: soft lockup detected on CPU#0!
> [4296372.670000]  [<b0138e29>] softlockup_tick+0x7e/0xbb
> [4296372.670000]  [<b0120cdc>] update_process_times+0x2a/0x60
> [4296372.670000]  [<b01063ec>] timer_interrupt+0x3a/0xce
> [4296372.670000]  [<b0138efd>] handle_IRQ_event+0x2e/0x5a
> [4296372.670000]  [<b0138fb2>] __do_IRQ+0x89/0x127
> [4296372.670000]  [<b0105099>] do_IRQ+0x6f/0x8b
> [4296372.670000]  [<b0103816>] common_interrupt+0x1a/0x20
> [4296372.670000]  [<f8e74986>] yenta_interrupt+0x11/0xb7 [yenta_socket]
> [4296372.670000]  [<b0138efd>] handle_IRQ_event+0x2e/0x5a
> [4296372.670000]  [<b0138fb2>] __do_IRQ+0x89/0x127
> [4296372.670000]  [<b010507d>] do_IRQ+0x53/0x8b
> [4296372.670000]  =======================
> [4296372.670000]  [<f9434c29>] rm_isr_bh+0x61/0x68 [nvidia]
> [4296372.670000]  [<b0103816>] common_interrupt+0x1a/0x20
> [4296372.670000]  [<b011cfa3>] __do_softirq+0x37/0x92
> [4296372.670000]  [<b0105104>] do_softirq+0x4f/0x5b
> [4296372.670000]  =======================
> [4296372.670000]  [<b011d0e2>] irq_exit+0x38/0x3a
> [4296372.670000]  [<b0105084>] do_IRQ+0x5a/0x8b
> [4296372.670000]  [<b0103816>] common_interrupt+0x1a/0x20
> [4296372.670000]  [<b023ac57>] serial_out+0x29/0x5f
> [4296372.670000]  [<b023cd08>] serial8250_startup+0x18e/0x4e8
> [4296372.670000]  [<b0238b9e>] uart_startup+0x3c/0x177
> [4296372.670000]  [<b0238dad>] uart_open+0xd4/0x4af
> [4296372.670000]  [<b0225b42>] check_tty_count+0x45/0xbb
> [4296372.670000]  [<b02c28a2>] __mutex_unlock_slowpath+0xd0/0x218
> [4296372.670000]  [<b022865d>] tty_open+0x163/0x328

It might be a hang in rm_isr_bh().  Does the same happen if the nvidia
driver is not, and has never been loaded?

