Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129933AbQLBLv0>; Sat, 2 Dec 2000 06:51:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130272AbQLBLvQ>; Sat, 2 Dec 2000 06:51:16 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:3366 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S130216AbQLBLvF>; Sat, 2 Dec 2000 06:51:05 -0500
Date: Sat, 2 Dec 2000 05:20:29 -0600 (CST)
From: Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>
To: Andries Brouwer <aeb@veritas.com>
cc: Santiago Garcia Mantinan <manty@i.am>, linux-kernel@vger.kernel.org
Subject: Re: why volatile on vgacon.c?
In-Reply-To: <20001129185140.A12589@veritas.com>
Message-ID: <Pine.LNX.3.96.1001202051946.27887H-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2000, Andries Brouwer wrote:
> On Wed, Nov 29, 2000 at 05:24:15PM +0100, Santiago Garcia Mantinan wrote:
> > That was on 2.2 series, but since I moved it to 2.4 series I don't have that
> > cga card found anymore. I have looked on the kernel code and followed it to
> > the __init function in vgacon.c, more concretely this piece of code...

> >         scr_writew(0xAA55, p);
> >         scr_writew(0x55AA, p + 1);
> >         if (scr_readw(p) != 0xAA55 || scr_readw(p + 1) != 0x55AA) {

> > Well, the thing is that this code and the code in this function is almost
> > the same in 2.4 as in 2.2, however reading returns the written values on 2.2
> > and different ones (0xffff) on 2.4

> Probably without the volatile the compiler optimizes the entire
> if statement away because it very well knows that it just wrote
> these values there.  With the volatile it has to check, and finds
> that there is nothing there.

hmmm.  That's why barriers exist, right?

	Jeff



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
