Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131759AbQK2SWk>; Wed, 29 Nov 2000 13:22:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131774AbQK2SWa>; Wed, 29 Nov 2000 13:22:30 -0500
Received: from hera.cwi.nl ([192.16.191.1]:22159 "EHLO hera.cwi.nl")
        by vger.kernel.org with ESMTP id <S131759AbQK2SWL>;
        Wed, 29 Nov 2000 13:22:11 -0500
Date: Wed, 29 Nov 2000 18:51:40 +0100
From: Andries Brouwer <aeb@veritas.com>
To: Santiago Garcia Mantinan <manty@i.am>
Cc: linux-kernel@vger.kernel.org
Subject: Re: why volatile on vgacon.c?
Message-ID: <20001129185140.A12589@veritas.com>
In-Reply-To: <20001129172415.A2171@mantianito.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20001129172415.A2171@mantianito.dyndns.org>; from manty@i.am on Wed, Nov 29, 2000 at 05:24:15PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2000 at 05:24:15PM +0100, Santiago Garcia Mantinan wrote:

> I used to be able to run my 12 ethernet ports pentium based bridge without
> vga card, but with tty1, tty2, ... still working, as the kernel used to
> recognice a kind of a cga card on my machine even though there was none. But
> the kernel could write to the memory were the card was supposed to be, and
> so it worked.
> 
> That was on 2.2 series, but since I moved it to 2.4 series I don't have that
> cga card found anymore. I have looked on the kernel code and followed it to
> the __init function in vgacon.c, more concretely this piece of code...
> 
>         scr_writew(0xAA55, p);
>         scr_writew(0x55AA, p + 1);
>         if (scr_readw(p) != 0xAA55 || scr_readw(p + 1) != 0x55AA) {
> 
> Well, the thing is that this code and the code in this function is almost
> the same in 2.4 as in 2.2, however reading returns the written values on 2.2
> and different ones (0xffff) on 2.4

Probably without the volatile the compiler optimizes the entire
if statement away because it very well knows that it just wrote
these values there.  With the volatile it has to check, and finds
that there is nothing there.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
