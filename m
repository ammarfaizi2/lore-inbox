Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932147AbWETF2e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147AbWETF2e (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 01:28:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932138AbWETF2e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 01:28:34 -0400
Received: from rwcrmhc14.comcast.net ([216.148.227.154]:21427 "EHLO
	rwcrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S932147AbWETF2e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 01:28:34 -0400
Message-ID: <446EA7EA.2070804@comcast.net>
Date: Sat, 20 May 2006 01:23:54 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Thunderbird 1.5.0.2 (X11/20060518)
MIME-Version: 1.0
To: John Richard Moser <nigelenki@comcast.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.16.16 Parameter-controlled mmap/stack randomization
References: <446E6A3B.8060100@comcast.net>
In-Reply-To: <446E6A3B.8060100@comcast.net>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



John Richard Moser wrote:
[...]

> 
> There's a few other things I want to get done, but I'll worry about
> those later.  They are:
> 
>  - Take care of the FIXME in that __init code in fs/exec.c to use
> architecture-specific #defines for the maximum values of these
> parameters, probably in asm-* somewhere.
[...]

Working on this right now.  I've fixed the 4096 hard-coded page sizes
and made them work with PAGE_SIZE; the stack was fun, I had to use a
long_log2() and calculate how many page_random_bits were possible and
cut that out to see if any vma_random_bits were left and how many.  :)

I'm also looking at using STACK_RANDOM_BITS_MAX_X86 or something because
of IA-32 emulation on x86-64.  I definitely need to figure out how to
make that work cleanly; on x86-64 we may have more stack/heap entropy
than sane, and I'd rather limit that (at first; later comes--
confusion-- stack_random_bits32= mmap_random_bits32=).

While I'm at it, does anyone see anything else glaring I should fix?  (I
am actually trying to get this merged, yes...)
- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

    Creative brains are a valuable, limited resource. They shouldn't be
    wasted on re-inventing the wheel when there are so many fascinating
    new problems waiting out there.
                                                 -- Eric Steven Raymond

    We will enslave their women, eat their children and rape their
    cattle!
                  -- Bosc, Evil alien overlord from the fifth dimension
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQIVAwUBRG6n4As1xW0HCTEFAQJryRAAgGr+XuOwG2hIVx+1RNmqcyVUC0sYew3D
9OFkV4PcyIUwGBmJcUWXzkV46av3Fz3Gk5Dm7X7KMpbroUz0big4MiZTeLRPsoCN
s99pDqciPe+YGjqj3KcIdwFT+ryUSpIAI4K8pMu2unqejf53T0QQR/7w7bkUqoOe
tj/L5GwubpJH2SNvWuBwHHNtOisuSBkXYIj90swfijbmiccAWki7i50I7Svd14db
uYWS8RvxMTUYEKbhW363OdlkVp0cvrbaIh2UYcEH4P2g7tcdzgG/aP9dUzQPDk0W
r5ltVMlGbVp1K1IPXuEn8S8gSmufPCq8AahQlVhiMiIqk4K1cw87tzY6H4UjE0dH
AyQ+NLQKy8RsOYDnfb4eM/x3JDJjF8RHHxPqVuRTRtA+tA+N2GKFwbOMsVvGj+PV
GYzaH/XAKzvccWWBlhFu2YQG9ZQqy+dpfCotvrbYQPfiuYj7+1yRdE7BaFUAMO6P
MVXf+tY1wzIZ9vEjIhYZtbq4VHNzwp43Jm0sHLdkUm9BPJzLoZbExC86BY5L6U2X
QG0SV3EyzT7wUga+28jbcG77aFEVR6ZhNLa3MFVqO6hF7ApTiJRooU5k4m7XUzx7
qlhhFFcB4HFTFV6o9Usp7YkGQnwmVKmtFOz/nY0COuJiQCRU4jby30NgPhCH+li2
VJz/1v+bBCs=
=yTDy
-----END PGP SIGNATURE-----
