Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263279AbSJJHIJ>; Thu, 10 Oct 2002 03:08:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263280AbSJJHIJ>; Thu, 10 Oct 2002 03:08:09 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:45984 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S263279AbSJJHIH>;
	Thu, 10 Oct 2002 03:08:07 -0400
Date: Thu, 10 Oct 2002 09:13:42 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       Vojtech Pavlik <vojtech@suse.cz>, Greg Kroah-Hartman <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] hid-input: fix find_next_zero_bit usage
Message-ID: <20021010091342.A7637@ucw.cz>
References: <20021010045002.GI12775@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021010045002.GI12775@conectiva.com.br>; from acme@conectiva.com.br on Thu, Oct 10, 2002 at 01:50:02AM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2002 at 01:50:02AM -0300, Arnaldo Carvalho de Melo wrote:

> Hi Vojtech,
> 
> 	Please apply this changeset, comments below, and this has to be
> applied to both 2.4 and 2.5.
> 
> - Arnaldo

Ok, added it to my repository. Greg, will you please take care of 2.4?

> 
> You can import this changeset into BK by piping this whole message to:
> '| bk receive [path to repository]' or apply the patch as usual.
> 
> ===================================================================
> 
> 
> ChangeSet@1.747, 2002-10-10 01:22:17-03:00, acme@dhcp197.conectiva
>   o hid-input: fix find_next_zero_bit usage
>   
>   It was swapping the parameters, using the bitfield size for the
>   offset and the offset for the bitfield size. With this the mouse
>   buttons in my wireless USB keyboard finally works 8) 2.4 has the
>   same problem.
> 
> 
>  hid-input.c |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> 
> 
> diff -Nru a/drivers/usb/input/hid-input.c b/drivers/usb/input/hid-input.c
> --- a/drivers/usb/input/hid-input.c	Thu Oct 10 01:26:11 2002
> +++ b/drivers/usb/input/hid-input.c	Thu Oct 10 01:26:11 2002
> @@ -348,7 +348,7 @@
>  	set_bit(usage->type, input->evbit);
>  
>  	while (usage->code <= max && test_and_set_bit(usage->code, bit)) {
> -		usage->code = find_next_zero_bit(bit, max + 1, usage->code);
> +		usage->code = find_next_zero_bit(bit, usage->code, max + 1);
>  	}
>  
>  	if (usage->code > max) return;
> 
> ===================================================================

-- 
Vojtech Pavlik
SuSE Labs
