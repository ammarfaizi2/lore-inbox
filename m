Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310405AbSCGQvz>; Thu, 7 Mar 2002 11:51:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310403AbSCGQvl>; Thu, 7 Mar 2002 11:51:41 -0500
Received: from exchange.macrolink.com ([64.173.88.99]:23310 "EHLO
	exchange.macrolink.com") by vger.kernel.org with ESMTP
	id <S310401AbSCGQvd>; Thu, 7 Mar 2002 11:51:33 -0500
Message-ID: <11E89240C407D311958800A0C9ACF7D13A76DD@EXCHANGE>
From: Ed Vance <EdV@macrolink.com>
To: "'Roman Kurakin'" <rik@cronyx.ru>, Russell King <rmk@arm.linux.org.uk>
Cc: "'linux-serial'" <linux-serial@vger.kernel.org>,
        "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: RE: Serial.c BUG 2.4.x-2.5x
Date: Thu, 7 Mar 2002 08:51:32 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Russell and Roman for your helpful input. I'll look at it today and
resubmit for further discussion.

Ed Vance

Roman Kurakin wrote:

> Russell King wrote:
> 
> >The patch does fine for the most part, but I have two worries:
> >
> >1. the possibilities of pushing through changes in the IO or memory space
> >   by changing the other space at the same time. (ie, port = 1, iomem =
> >   0xfe007c00 and you already have a line at port = 0, iomem =
0xfe007c00).
> >   I delt with this properly using the resource management subsystem.
> >
> I think such code could solve this problem ...
> 
> - 			    (rs_table[i].port == new_port) &&
> + 			    ((rs_table[i].port && rs_table[i].port ==
new_port) ||
> +			    ((rs_table[i].iomem_base &&
rs_table[i].iomem_base == new_mem)) &&
>  
> 
> >2. there seems to be a lack of security considerations for changing the
> >   iomem address.  (ie, changing the iomem address without CAP_SYS_ADMIN.
> >   I added this as an extra check for change_port)
> >
> And this one could be fixed with something like this (this is no a 
> patch, just an idea)
> 
>         change_port = (new_port != ((int) state->port)) ||
>                 (new_serial.hub6 != state->hub6);
> +        change_mem = (new_mem != state->iomem_base)
> 
>         if (!capable(CAP_SYS_ADMIN)) {
> -                if (change_irq || change_port ||
> +                if (change_irq || change_port || change_mem
> 

---------------------------------------------------------------- 
Ed Vance              serial24@macrolink.com
Macrolink, Inc.       1500 N. Kellogg Dr  Anaheim, CA  92807
----------------------------------------------------------------
