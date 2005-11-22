Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965053AbVKVWOW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965053AbVKVWOW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 17:14:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965065AbVKVWOW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 17:14:22 -0500
Received: from mail.kroah.org ([69.55.234.183]:43668 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965053AbVKVWOV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 17:14:21 -0500
Date: Tue, 22 Nov 2005 14:13:53 -0800
From: Greg KH <gregkh@suse.de>
To: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       akpm@osdl.org, ehabkost@mandriva.com
Subject: Re: [PATCH 2/2] - usbserial: race-condition fix.
Message-ID: <20051122221353.GA10311@suse.de>
References: <20051122195926.18c3221c.lcapitulino@mandriva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051122195926.18c3221c.lcapitulino@mandriva.com.br>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2005 at 07:59:26PM -0200, Luiz Fernando Capitulino wrote:
> @@ -60,6 +61,7 @@ struct usb_serial_port {
>  	struct usb_serial *	serial;
>  	struct tty_struct *	tty;
>  	spinlock_t		lock;
> +	struct semaphore        sem;

You forgot to document what this semaphore is used for.

Hm, can we just use the spinlock already present in the port structure
for this?  Well, drop the spinlock and use the semaphore?  Yeah, that
means grabbing a semaphore for ever write for some devices, but USB data
rates are slow enough it wouldn't matter :)

thanks,

greg k-h
