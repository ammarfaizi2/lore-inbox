Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272335AbTHEBAb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 21:00:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272373AbTHEBAa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 21:00:30 -0400
Received: from fw.osdl.org ([65.172.181.6]:17121 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272335AbTHEA7p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 20:59:45 -0400
Date: Mon, 4 Aug 2003 18:04:37 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Pavel Machek <pavel@ucw.cz>
cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PM] Make yenta work
In-Reply-To: <20030726225915.GA537@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44.0308041804020.23977-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This makes yenta work, and its really trivial...
> 								Pavel
> 
> Index: linux/drivers/pcmcia/yenta_socket.c
> ===================================================================
> --- linux.orig/drivers/pcmcia/yenta_socket.c	2003-07-22 13:39:42.000000000 +0200
> +++ linux/drivers/pcmcia/yenta_socket.c	2003-07-17 22:22:58.000000000 +0200
> @@ -899,7 +899,10 @@
>  
>  static int yenta_dev_suspend (struct pci_dev *dev, u32 state)
>  {
> -	return pcmcia_socket_dev_suspend(&dev->dev, state, 0);
> +	/* FIXME: We should really let devices to act on *all* levels :-(.
> +	   If you put something else than SUSPEND_SAVE_STATE,
> +	   pcmcia_socket_dev_suspend() will simply do nothing due to its check. */
> +	return pcmcia_socket_dev_suspend(&dev->dev, state, SUSPEND_SAVE_STATE);
>  }

I believe I saw a patch from Russell get in over the weekend that did 
this, right? 


	-pat

