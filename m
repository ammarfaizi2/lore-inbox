Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277347AbRKHSF1>; Thu, 8 Nov 2001 13:05:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276914AbRKHSD7>; Thu, 8 Nov 2001 13:03:59 -0500
Received: from ns.xdr.com ([209.48.37.1]:65182 "EHLO xdr.com")
	by vger.kernel.org with ESMTP id <S277431AbRKHSDX>;
	Thu, 8 Nov 2001 13:03:23 -0500
Date: Thu, 8 Nov 2001 10:03:21 -0800 (PST)
From: "Dave Ashley (linux mailing list)" <linux@xdr.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mmap + wrapping around to 0
In-Reply-To: <E161tTi-00009l-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0111080959230.24874-100000@xdr.xdr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PAGE_ALIGN results in a multiple of PAGE_SIZE always.
If you subtract one inside, the end result will
be the same.

As an example:
map 0x1000 bytes at 0xfffff000
PAGE_ALIGN(0x1000) = 0x1000
PAGE_ALIGN(0x0fff) = 0x1000
PAGE_ALIGN(0x1000)-1 = 0x0fff
The difference is adding 0x1000 or 0xfff to
0xfffff000, and the result wrapping around
to 0, or going to 0xffffffff (the later
result is what we want and the comparison works).

-Dave

On Thu, 8 Nov 2001, Alan Cox wrote:

> > in the inline function do_mmap(), change
> >         if ((offset + PAGE_ALIGN(len)) < offset)
> > to
> >         if ((offset + PAGE_ALIGN(len)-1) < offset)
>
> Shouldnt that be
>
> 	PAGE_ALIGN(len-1)
>
> so you compute the page of the last byte ?
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

