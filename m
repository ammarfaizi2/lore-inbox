Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262312AbSJ2RgE>; Tue, 29 Oct 2002 12:36:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262324AbSJ2RgE>; Tue, 29 Oct 2002 12:36:04 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:48881 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262312AbSJ2RgD>;
	Tue, 29 Oct 2002 12:36:03 -0500
Date: Tue, 29 Oct 2002 12:42:24 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Joe Thornber <joe@fib011235813.fsnet.co.uk>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dm update 3/3
In-Reply-To: <20021029172016.GC1779@fib011235813.fsnet.co.uk>
Message-ID: <Pine.GSO.4.21.0210291240380.9171-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 29 Oct 2002, Joe Thornber wrote:

> Keep track of allocated minors in a bitset rather than abusing
> get_gendisk.
 
> +	spin_lock(&_minor_lock);
> +	for (i = 0; i < MAX_DEVICES; i++) {
> +		if (!test_bit(i, _minor_bits)) {
> +			r = i;
> +			set_bit(i, _minor_bits);
>  			DMWARN("allocating minor = %d", i);
> -			return i;
> +			break;
>  		}
> +	}
> +	spin_unlock(&_minor_lock);

Ugh.  See find_first_zero_bit() - no need to reinvent that wheel...

