Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282384AbRKXHHB>; Sat, 24 Nov 2001 02:07:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282385AbRKXHGv>; Sat, 24 Nov 2001 02:06:51 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:37352 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S282384AbRKXHGg>;
	Sat, 24 Nov 2001 02:06:36 -0500
Date: Sat, 24 Nov 2001 02:06:32 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Andrea Arcangeli <andrea@suse.de>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: 2.4.15-pre9 breakage (inode.c)
In-Reply-To: <20011124080113.A1316@athlon.random>
Message-ID: <Pine.GSO.4.21.0111240203520.4000-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 24 Nov 2001, Andrea Arcangeli wrote:

> this one looks even better (and it doesn't need to propagate the fix to
> the lowlevel):
> 
> --- 2.4.15aa1/fs/super.c.~1~	Fri Nov 23 08:21:01 2001
> +++ 2.4.15aa1/fs/super.c	Sat Nov 24 07:58:37 2001
> @@ -470,6 +470,7 @@
>  	return s;
>  
>  out_fail:
> +	invalidate_inodes(s);

Sigh...
	a) grep, please.
	b) you are triggering method calls for a superblock after failed
->read_super().  Blindly.  Care to audit all filesystems and check that
it is legitimate?

