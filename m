Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262796AbVCPVKM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262796AbVCPVKM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 16:10:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262798AbVCPVKM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 16:10:12 -0500
Received: from fire.osdl.org ([65.172.181.4]:62379 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262796AbVCPVKG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 16:10:06 -0500
Date: Wed, 16 Mar 2005 13:09:48 -0800
From: Andrew Morton <akpm@osdl.org>
To: Matthew Wilcox <matthew@wil.cx>
Cc: matthew@wil.cx, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CON_BOOT
Message-Id: <20050316130948.678ca2f2.akpm@osdl.org>
In-Reply-To: <20050316130759.GL21986@parcelfarce.linux.theplanet.co.uk>
References: <20050315222706.GI21986@parcelfarce.linux.theplanet.co.uk>
	<20050315143711.4ae21d88.akpm@osdl.org>
	<20050316130759.GL21986@parcelfarce.linux.theplanet.co.uk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox <matthew@wil.cx> wrote:
>
>  I think it's doable
>  if we do something like:
> 
>   - Add an int (*takeover)(struct console *); to struct console
>   - Replace the hunk above with:
> 
>  	for (existing = console_drivers; existing; existing = existing->next) {
>  		if (existing->takeover && existing->takeover(console)) {
>  			unregister_console(existing);
>  			console->flags &= ~CON_PRINTBUFFER;
>  		}
>  	}
> 
>  That puts the onus on the early console to be able to figure out
>  whether a registering console is its replacement or not; for the x86_64
>  early_printk, that'd be as simple as comparing the ->name against "ttyS"
>  or "tty".  It'll be a bit more tricky for PA-RISC, but would solve some
>  messiness that we could potentially have.  I think that's doable; want
>  me to try it?

It doesn't sound terribly important - I was just curious, thanks.  We can
let this one be demand-driven.

I'm surprised that more systems don't encounter this - there's potentially
quite a gap between console_init() and the bringup of the first real
console driver.  What happens if we crash in mem_init()?  Am I misreading
the code, or do we just get no info?
