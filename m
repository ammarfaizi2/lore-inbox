Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265044AbUEYSzm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265044AbUEYSzm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 14:55:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265043AbUEYSzm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 14:55:42 -0400
Received: from [141.156.69.115] ([141.156.69.115]:9145 "EHLO
	mail.infosciences.com") by vger.kernel.org with ESMTP
	id S265044AbUEYSza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 14:55:30 -0400
Message-ID: <40B396A1.4090208@infosciences.com>
Date: Tue, 25 May 2004 14:55:29 -0400
From: nardelli <jnardelli@infosciences.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] [PATCH] visor: Fix Oops on disconnect
References: <40AD3A88.2000002@infosciences.com> <20040521043032.GA31113@kroah.com> <40AE5DBB.6030003@infosciences.com> <20040521204430.GA5875@kroah.com> <40AE7829.9060105@infosciences.com> <40AE7CFE.5060805@infosciences.com> <20040521223024.GA7399@kroah.com> <40B22EED.4080808@infosciences.com> <20040524200805.GD4558@kroah.com> <40B26C5E.9060001@infosciences.com> <20040525183033.GB12919@kroah.com>
In-Reply-To: <20040525183033.GB12919@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Mon, May 24, 2004 at 05:42:54PM -0400, nardelli wrote:
> 
> 
> Nah, this is good enough.  I've tweaked the patch a bit to keep from
> creating a big structure on the stack, and reduced the copy port logic
> to something a bit more readable and applied this version.  I'll send it
> off to Linus in a day or so.
> 
> Thanks a lot for your work on this.
> 
> greg k-h
> 
> +#define COPY_PORT(dest, src)						\
> +	dest->read_urb = src->read_urb;					\
> +	dest->bulk_in_endpointAddress = src->bulk_in_endpointAddress;	\
> +	dest->bulk_in_buffer = src->bulk_in_buffer;			\
> +	dest->interrupt_in_urb = src->interrupt_in_urb;			\
> +	dest->interrupt_in_endpointAddress = src->interrupt_in_endpointAddress;	\
> +	dest->interrupt_in_buffer = src->interrupt_in_buffer;
> +
> +	swap_port = kmalloc(sizeof(*swap_port), GFP_KERNEL);
> +	if (!swap_port)
> +		return -ENOMEM;
> +	COPY_PORT(swap_port, serial->port[0]);
> +	COPY_PORT(serial->port[0], serial->port[1]);
> +	COPY_PORT(serial->port[1], swap_port);
> +	kfree(swap_port);
>  
>  	return 0;
>  }
> -

That's definitely less error prone as well.

BTW - I appreciate the time that you have put into this, and especially 
the constructive comments and patience that you had regarding patches 
that I submitted.

-- 
Joe Nardelli
jnardelli@infosciences.com
