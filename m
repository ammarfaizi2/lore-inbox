Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135386AbRAHLum>; Mon, 8 Jan 2001 06:50:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137115AbRAHLuc>; Mon, 8 Jan 2001 06:50:32 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:31149 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S135386AbRAHLuX>;
	Mon, 8 Jan 2001 06:50:23 -0500
Date: Mon, 8 Jan 2001 06:50:20 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Stefan Traby <stefan@hello-penguin.com>, linux-kernel@vger.kernel.org
Subject: Re: ramfs problem... (unlink of sparse file in "D" state)
In-Reply-To: <E14FalM-0004MY-00@the-village.bc.nu>
Message-ID: <Pine.GSO.4.21.0101080647090.4061-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 8 Jan 2001, Alan Cox wrote:

> > Alan, it doesn't work that way. Maximal size depends on the type of object,
> > for one thing. Moreover, it's not always a multiple of page size, so you
> 
> Its a multiple of page size for all fs's we have but I did it in terms of
> bytes anyway

1Kb-block ext2 on Alpha. Count yourself and you'll see...

> > still need foo_get_block() to be aware of the problem (it should return
> > -EFBIG). Besides, we need to take care of the situations when some of
> > get_block() calls fail in prepare_write() - that can happen due to other
> > problems. I've fixed all that stuff for ext2 (check the patches posted on
> > l-k after 12-pre6). We need to propagate it into other filesystems, but
> 
> I put it into generic_file_write. That covers most fs's it seems. The jffs 
> guys are going to switch to generic_file_write soon and the other fs's 
> that dont are wacko ones I dont care about ;)

Alan, we have to deal with get_block() failures anyway. -ENOSPC, -EDQUOT,
not to mention plain and simple -EIO. -EFBIG handling is not different.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
