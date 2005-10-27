Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932661AbVJ0WDy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932661AbVJ0WDy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 18:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932660AbVJ0WDy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 18:03:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:49843 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932658AbVJ0WDy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 18:03:54 -0400
Date: Thu, 27 Oct 2005 15:03:55 -0700
From: Andrew Morton <akpm@osdl.org>
To: Damir Perisa <damir.perisa@solnet.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc5-mm1 - ide-cs broken!
Message-Id: <20051027150355.035dbbe5.akpm@osdl.org>
In-Reply-To: <200510272331.58445.damir.perisa@solnet.ch>
References: <20051024014838.0dd491bb.akpm@osdl.org>
	<200510260149.21376.damir.perisa@solnet.ch>
	<200510272331.58445.damir.perisa@solnet.ch>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Damir Perisa <damir.perisa@solnet.ch> wrote:
>
> isn't anybody else using ide-cs? i feel lonely!
>

That's called "stunned silence".


> booting the fresh kernel26mm, i ran into a problem with ide-cs:
> 
> info while booting / start of hotplug:
> Oct 26 01:02:28 localhost kernel: [17179579.008000] Yenta: CardBus bridge found at 0000:02:00.1 [1014:0185]
> Oct 26 01:02:28 localhost kernel: [17179579.160000] Yenta: ISA IRQ mask 0x04b8, PCI irq 11
> Oct 26 01:02:28 localhost kernel: [17179579.184000] Socket status: 30000006
> Oct 26 01:02:28 localhost kernel: [17179579.208000] pcmcia: parent PCI bridge I/O window: 0x4000 - 0x8fff
> Oct 26 01:02:28 localhost kernel: [17179579.232000] cs: IO port probe 0x4000-0x8fff: clean.
> Oct 26 01:02:28 localhost kernel: [17179579.256000] pcmcia: parent PCI bridge Memory window: 0xd0200000 - 0xdfffffff
> Oct 26 01:02:28 localhost kernel: [17179579.280000] pcmcia: parent PCI bridge Memory window: 0xf0000000 - 0xf80fffff
> 
> when i plug in the pcmcia-compact-flash adapter into the laptop:
> Oct 26 01:05:10 localhost kernel: [17179767.840000] cs: memory probe 0xf0000000-0xf80fffff: excluding 0xf0000000-0xf87fffff
> Oct 26 01:05:11 localhost kernel: [17179767.924000] ide_cs: Unknown symbol cs_error
> Oct 26 01:05:11 localhost kernel: [17179767.928000] ide_cs: Unknown symbol pcmcia_deregister_client
> Oct 26 01:05:11 localhost kernel: [17179767.928000] ide_cs: Unknown symbol pcmcia_get_first_tuple
> Oct 26 01:05:11 localhost kernel: [17179767.928000] ide_cs: Unknown symbol pcmcia_unregister_driver
> Oct 26 01:05:11 localhost kernel: [17179767.928000] ide_cs: Unknown symbol pcmcia_get_tuple_data
> Oct 26 01:05:11 localhost kernel: [17179767.928000] ide_cs: Unknown symbol pcmcia_get_next_tuple
> Oct 26 01:05:11 localhost kernel: [17179767.928000] ide_cs: Unknown symbol pcmcia_register_client
> Oct 26 01:05:11 localhost kernel: [17179767.928000] ide_cs: Unknown symbol pcmcia_get_configuration_info
> Oct 26 01:05:11 localhost kernel: [17179767.928000] ide_cs: Unknown symbol pcmcia_request_io
> Oct 26 01:05:11 localhost kernel: [17179767.928000] ide_cs: Unknown symbol pcmcia_request_configuration
> Oct 26 01:05:11 localhost kernel: [17179767.928000] ide_cs: Unknown symbol pcmcia_release_configuration
> 

I'd have thought this was basically impossible.  It's saying that
drivers/pcmcia/ds.c isn't present.  What's the setting of CONFIG_PCMCIA in
your .config?

Perhaps the modprobe dependencies are screwed up.  Try modprobing pcmcia.o
by hand before inserting the card?
