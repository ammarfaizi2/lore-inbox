Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129258AbRBTOte>; Tue, 20 Feb 2001 09:49:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129699AbRBTOtY>; Tue, 20 Feb 2001 09:49:24 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:24080 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S129258AbRBTOtS>; Tue, 20 Feb 2001 09:49:18 -0500
Date: Tue, 20 Feb 2001 08:49:12 -0600 (CST)
From: Jeff Garzik <jgarzik@mandrakesoft.com>
To: Norbert Roos <n.roos@berlin.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Probs with PCI bus master DMA to user space
In-Reply-To: <3A927AE9.CE3B88F9@berlin.de>
Message-ID: <Pine.LNX.3.96.1010220084656.23246Q-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Feb 2001, Norbert Roos wrote:

> Jeff Garzik wrote:
> 
> > > But the buffers are usually allocated with malloc() by any application
> > > which wants to use my driver.. otherwise my driver would have to offer a
> > > malloc-like function, but I can hardly force the application to use my
> > > own malloc function.
> > 
> > If you are writing the driver, sure you can.
> 
> ??
> 
> The application is doing something like
> 
>   fd = open("/dev/mydriver");
>   buf = malloc();
>   fill_buffer_with_data(buf);
>  write(fd,buf);
> 
> And now i should tell the programmer not to use malloc() but my special
> driver-malloc?
> Or do you mean something different?

fd = open(...);
buf = mmap(fd, ...);
fill_buffer_with_data(buf);
ioctl(fd, ...); /* tell kernel data is there */

There are variations depending on the application, but you get the
picture.  A buffer copy is eliminated when mmap is used, too, making
your application faster.

	Jeff



