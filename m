Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261576AbVB1HAM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261576AbVB1HAM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 02:00:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261573AbVB1G7Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 01:59:25 -0500
Received: from mail.kroah.org ([69.55.234.183]:19100 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261566AbVB1G6K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 01:58:10 -0500
Date: Sun, 27 Feb 2005 22:37:57 -0800
From: Greg KH <greg@kroah.com>
To: Wen Xiong <wendyx@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [ patch 2/7] drivers/serial/jsm: new serial device driver
Message-ID: <20050228063757.GA23595@kroah.com>
References: <42225A04.7080505@us.ltcfwd.linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42225A04.7080505@us.ltcfwd.linux.ibm.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 27, 2005 at 06:38:44PM -0500, Wen Xiong wrote:

> diff -Nuar linux-2.6.9.orig/drivers/serial/jsm/jsm_tty.c linux-2.6.9.new/drivers/serial/jsm/jsm_tty.c
> --- linux-2.6.9.orig/drivers/serial/jsm/jsm_tty.c	1969-12-31 18:00:00.000000000 -0600
> +++ linux-2.6.9.new/drivers/serial/jsm/jsm_tty.c	2005-02-27 17:09:43.456960832 -0600
> @@ -0,0 +1,1273 @@
> +/*
> + * Copyright 2003 Digi International (www.digi.com)
> + *	Scott H Kilau <Scott_Kilau at digi dot com>

But didn't you do a lot of work on this code too?  Shouldn't you be
adding your copyright?

> + *	NOTE TO LINUX KERNEL HACKERS:  DO NOT REFORMAT THIS CODE! 
> + *
> + *	This is shared code between Digi's CVS archive and the
> + *	Linux Kernel sources.
> + *	Changing the source just for reformatting needlessly breaks
> + *	our CVS diff history.
> + *
> + *	Send any bug fixes/changes to:  Eng.Linux at digi dot com. 
> + *	Thank you. 

Is this still true?  The formatting looks sane, so you can probably take
this all out.  And put a real email address in there please...


> + * $Id: jsm_tty.c,v 1.79 2004/09/25 07:01:46 scottk Exp $

Take these out, not needed.

> +#include <linux/device.h>	/* For udelay */

Comment is incorrect.  What do you need device.h for?

> +	DPR_IOCTL(("jsm_getmstat start\n"));

You have odd macros with two "((", what's up with that?  Please use the
standard macros dev_dbg() and friends.  It's a way to get a standard
message out of the kernel.

> +static void jsm_tty_set_mctrl(struct uart_port *port, unsigned int mctrl)
> +{
> +	DPR_IOCTL(("jsm_set_modem_info() start\n"));

Oh, and why not just use __FUNCTION__?

> +static void jsm_tty_stop_rx(struct uart_port *port)
> +{
> +
> +	JSM_CHANNEL->ch_bd->bd_ops->disable_receiver(JSM_CHANNEL);
> +
> +}

I think you can drop the extra lines here...

And what's with the all uppercase JSM_CHANNEL?  Why not just use the
structure pointer.

thanks,

greg k-h
