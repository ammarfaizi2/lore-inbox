Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261863AbSJVCEO>; Mon, 21 Oct 2002 22:04:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261867AbSJVCEN>; Mon, 21 Oct 2002 22:04:13 -0400
Received: from serenity.mcc.ac.uk ([130.88.200.93]:11014 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S261863AbSJVCEJ>; Mon, 21 Oct 2002 22:04:09 -0400
Date: Tue, 22 Oct 2002 03:10:05 +0100
From: John Levon <levon@movementarian.org>
To: linux-kernel@vger.kernel.org
Cc: cminyard@mvista.com
Subject: Re: [PATCH] NMI request/release
Message-ID: <20021022021005.GA39792@compsoc.man.ac.uk>
References: <3DB4AABF.9020400@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DB4AABF.9020400@mvista.com>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2002 at 08:32:47PM -0500, Corey Minyard wrote:

> The attached patch implements a way to request to receive an NMI if it 
> comes from an otherwise unknown source.  I needed this for handling NMIs 
> with the IPMI watchdog.  This function was discussed a little a while 

Then NMI watchdog and oprofile should be changed to use this too. We
also need priority and/or equivalent of NOTIFY_STOP_MASK so we can break
out of calling all the handlers. Actually, why do you continue if one
of the handlers returns 1 anyway ?

> +	atomic_inc(&calling_nmi_handlers);

Isn't this going to cause cacheline ping pong ?

> +	curr = nmi_handler_list;
> +	while (curr) {
> +		handled |= curr->handler(curr->dev_id, regs);

dev_name is never used at all. What is it for ? Also, would be nice
to do an smp_processor_id() just once and pass that in to prevent
multiple calls to get_current().

Couldn't you modify the notifier code to do the xchg()s (though that's
not available on all CPU types ...)

> +#define HAVE_NMI_HANDLER	1

What uses this ?

> +	volatile struct nmi_handler *next;

Hmm ...

Is it not possible to use linux/rcupdate.h for this stuff ?

regards
john
-- 
"Lots of companies would love to be in our hole."
	- Scott McNealy
