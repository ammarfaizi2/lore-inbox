Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932655AbWBTToJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932655AbWBTToJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 14:44:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932659AbWBTToI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 14:44:08 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:24207
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S932655AbWBTToH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 14:44:07 -0500
Subject: Re: RT and pci_lock while reading or writing pci bus configuration.
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Serge Noiraud <serge.noiraud@bull.net>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <200602201542.19857.Serge.Noiraud@bull.net>
References: <200602201542.19857.Serge.Noiraud@bull.net>
Content-Type: text/plain
Date: Mon, 20 Feb 2006 20:45:06 +0100
Message-Id: <1140464706.2480.762.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.5 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-02-20 at 15:42 +0100, Serge Noiraud wrote:
> Hi,
> I have one question :
> In drivers/pci/access.c we have a global lock for pci configuration access.
> In pci_bus_read_config_* or pci_bus_write_config_* functions, we acquire a lock.
> When we call spin_lock_irqsave, we obtain the following message :
> BUG: scheduling while atomic: IRQ 137/0x00000001/6431
> caller is schedule+0x43/0x120
>  [<c01050ec>] dump_stack+0x1c/0x20 (20)
>  [<c03e7144>] __schedule+0xf44/0x1240 (236)
>  [<c03e7483>] schedule+0x43/0x120 (12)
>  [<c03e855b>] __down_mutex+0x2bb/0x5f0 (112)
>  [<c03ea08c>] _spin_lock_irqsave+0x1c/0x40 (24)
>  [<c023670d>] pci_bus_read_config_word+0x2d/0x70 (24)
>  
> Do I miss something or is it a BUG ?

Yeah, you missed to paste the full backtrace :)

Preempt count is 1, so you are calling pci_bus_read_config_word() from a
non preemptible context.

	tglx


