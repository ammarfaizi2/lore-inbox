Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265006AbUF1PPP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265006AbUF1PPP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 11:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265008AbUF1PPO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 11:15:14 -0400
Received: from digitalimplant.org ([64.62.235.95]:22177 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S265006AbUF1PPJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 11:15:09 -0400
Date: Mon, 28 Jun 2004 08:14:48 -0700 (PDT)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: Pavel Machek <pavel@ucw.cz>
cc: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Next step of smp support & fix device suspending
In-Reply-To: <20040625115529.GA764@elf.ucw.cz>
Message-ID: <Pine.LNX.4.50.0406280809540.20762-100000@monsoon.he.net>
References: <20040625115529.GA764@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This introduces functions for stopping all-but-boot-cpus, which will
> be needed for smp suspend, and fixes level for calling driver model:
> there's no D4 power level, only D3 (means device off), and tg3 driver
> actually cares. Ugh and one useless mdelay killed, and
> freeze_processes() now BUGS() if its not compiled in. [We can probably
> just remove it for non-CONFIG_PM case in future]. It is bad idea to
> pretend success, and nobody should ever call it in !CONFIG_PM case
> anyway. Please apply,

Nice, just a couple of questions...

> -	device_power_down(4);
> +	device_power_down(3);

There are defined values in include/linux/device.h. You should be using
those, instead of the magic constants (even if the magic constants
actually make sense as the power states :).

>  	PRINTK( "Waiting for DMAs to settle down...\n");
>  	mdelay(1000);	/* We do not want some readahead with DMA to corrupt our memory, right?
>  			   Do it with disabled interrupts for best effect. That way, if some

On a related note, can we kill this piece of code? It's not clear that
it's necessary. If it is, it begs for a more systematic way of achieving
the goal.


	Pat
