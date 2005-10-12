Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932408AbVJLMTd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932408AbVJLMTd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 08:19:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932431AbVJLMTd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 08:19:33 -0400
Received: from [195.23.16.24] ([195.23.16.24]:18560 "EHLO
	linuxbipbip.grupopie.com") by vger.kernel.org with ESMTP
	id S932408AbVJLMTd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 08:19:33 -0400
Message-ID: <434CFF51.1070709@grupopie.com>
Date: Wed, 12 Oct 2005 13:19:29 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dsaxena@plexity.net
CC: Marcel Holtmann <marcel@holtmann.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [BLUETOOTH] kmalloc + memset -> kzalloc conversion
References: <20051001065121.GC25424@plexity.net> <20051011151805.0d32c840.akpm@osdl.org> <1129071122.6487.6.camel@localhost.localdomain> <20051011230440.GA26330@plexity.net>
In-Reply-To: <20051011230440.GA26330@plexity.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Deepak Saxena wrote:
> On Oct 12 2005, at 00:52, Marcel Holtmann was caught saying:
> 
>>Hi Andrew,
>>
>>>Confused.  This patch changes lots of block code, not bluetooth.
>>
>>I know. This is what I already mailed Deepak, but he never replied.
> 
> Sorry, got lost in the mailbox. I think I was not paying attention to
> my tab completion and included the wrong patch. Proper patch follows.
> 
[...]
> --- a/drivers/bluetooth/hci_usb.c
> +++ b/drivers/bluetooth/hci_usb.c
> @@ -134,10 +134,9 @@ static struct usb_device_id blacklist_id
>  
>  static struct _urb *_urb_alloc(int isoc, unsigned int __nocast gfp)
>  {
> -	struct _urb *_urb = kmalloc(sizeof(struct _urb) +
> +	struct _urb *_urb = kzalloc(sizeof(struct _urb) +
>  				sizeof(struct usb_iso_packet_descriptor) * isoc, gfp);
>  	if (_urb) {
> -		memset(_urb, 0, sizeof(*_urb));
>  		usb_init_urb(&_urb->urb);
>  	}
>  	return _urb;

This one doesn't keep the exact same behavior as before, as it is 
zeroing more memory than it did.

If this is not a performance critical path, then I guess it's ok (code 
size reduction, and all).

I just wanted to call some attention on this so that someone more 
knowledgeable than me in the bluetooth ways can make sure it's ok.

-- 
Paulo Marques - www.grupopie.com

The rule is perfect: in all matters of opinion our
adversaries are insane.
Mark Twain
