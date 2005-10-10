Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750837AbVJJO6b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750837AbVJJO6b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 10:58:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750839AbVJJO6b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 10:58:31 -0400
Received: from mail.kroah.org ([69.55.234.183]:4816 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750837AbVJJO6a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 10:58:30 -0400
Date: Mon, 10 Oct 2005 07:57:56 -0700
From: Greg KH <greg@kroah.com>
To: Jiri Slaby <xslaby@fi.muni.cz>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH2 4/6] isicom: Pci probing added
Message-ID: <20051010145756.GA5530@kroah.com>
References: <20051009193943.943E522AEB1@anxur.fi.muni.cz> <20051009194221.38D3522AEAC@anxur.fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051009194221.38D3522AEAC@anxur.fi.muni.cz>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 09, 2005 at 09:42:22PM +0200, Jiri Slaby wrote:
> @@ -191,6 +198,7 @@ struct	isi_board {
>  	u8			isa;
>  	spinlock_t		card_lock; /* Card wide lock 11/5/00 -sameer */
>  	unsigned long		flags;
> +	struct device		device;

What is this "struct device" used for?  You do not need it.

> +		printk(KERN_DEBUG "ISICOM: I/O Region 0x%x-0x%x is busy. "
> +			"Card%d will be disabled.\n", board->base,
> +			board->base + 15, index + 1);

For all of your printk() calls, please use dev_dbg() or dev_warn() or
the other dev_* calls please.

> +/*			isi_card[idx].base = io[idx];
> +			isi_card[idx].irq = irq[idx];
> +			isi_card[idx].isa = YES;
> + FIXME: which device for request_firmware use? if you know, uncomment this and
> + delete printk and return
> +			isi_card[idx].device = ???;

Register the firmware request for when you see the device that needs it,
in your probe function, not in your module init function.

Hope this helps,

greg k-h
