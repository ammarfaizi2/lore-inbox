Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129791AbQKGXHH>; Tue, 7 Nov 2000 18:07:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129871AbQKGXG6>; Tue, 7 Nov 2000 18:06:58 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:64756 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129791AbQKGXGl>;
	Tue, 7 Nov 2000 18:06:41 -0500
Date: Tue, 7 Nov 2000 18:06:32 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: swapout vs. filemap_sync_pte...?
In-Reply-To: <3A074633.12ED8137@mandrakesoft.com>
Message-ID: <Pine.GSO.4.21.0011071757500.5033-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 6 Nov 2000, Jeff Garzik wrote:

> The address_space::writepage callback is called from try_to_swap_out()
> path, and also from the filemap_sync_pte() path.  There appears to be no
> way to tell the difference between the two callers.  This is not good
> because the semantics are very different:  "sync this page" versus "page
> is going away".

For the filemap VMAs (i.e. ones that are based on address_space with
backstore) it is the same thing. For something like tmpfs you have
different VMA-level semantics. Ergo, different VMA methods. They can
be shared with filemap ones, but you definitely don't want ->vm_ops->sync().
End of the problem...

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
