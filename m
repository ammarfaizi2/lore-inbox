Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266480AbSKUJvH>; Thu, 21 Nov 2002 04:51:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266489AbSKUJvH>; Thu, 21 Nov 2002 04:51:07 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:45243 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S266480AbSKUJvG>;
	Thu, 21 Nov 2002 04:51:06 -0500
Date: Thu, 21 Nov 2002 10:54:20 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: bunk@fs.tum.de, greg@kroah.com
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix compile error in usb-serial.c
In-Reply-To: <200211201804.gAKI4u029388@hera.kernel.org>
Message-ID: <Pine.GSO.4.21.0211211053020.18129-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Nov 2002, Linux Kernel Mailing List wrote:
> ChangeSet 1.872.3.6, 2002/11/18 18:34:46-08:00, bunk@fs.tum.de
> 
> 	[PATCH] fix compile error in usb-serial.c
> 	
> 	drivers/usb/serial/usb-serial.c in 2.5.48 fails to compile with the
> 	following error:
> 	
> 	drivers/usb/serial/usb-serial.c:842: dereferencing pointer to incompletetype
> 	
> 	Is the following patch correct?
> 
> 
> # This patch includes the following deltas:
> #	           ChangeSet	1.872.3.5 -> 1.872.3.6
> #	drivers/usb/serial/usb-serial.c	1.52    -> 1.53   
> #
> 
>  usb-serial.c |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> 
> 
> diff -Nru a/drivers/usb/serial/usb-serial.c b/drivers/usb/serial/usb-serial.c
> --- a/drivers/usb/serial/usb-serial.c	Wed Nov 20 10:04:59 2002
> +++ b/drivers/usb/serial/usb-serial.c	Wed Nov 20 10:04:59 2002
> @@ -839,7 +839,7 @@
>  
>  		length += sprintf (page+length, "%d:", i);
>  		if (serial->type->owner)
> -			length += sprintf (page+length, " module:%s", serial->type->owner->name);
> +			length += sprintf (page+length, " module:%s", module_name(serial->type->owner));
>  		length += sprintf (page+length, " name:\"%s\"", serial->type->name);
>  		length += sprintf (page+length, " vendor:%04x product:%04x", serial->vendor, serial->product);
>  		length += sprintf (page+length, " num_ports:%d", serial->num_ports);
> -

How can this be correct?

serial->type->owner is of type struct module *, not char *!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

