Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136698AbRAHLqC>; Mon, 8 Jan 2001 06:46:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136914AbRAHLpx>; Mon, 8 Jan 2001 06:45:53 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:21523 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S136698AbRAHLpm>; Mon, 8 Jan 2001 06:45:42 -0500
Subject: Re: ramfs problem... (unlink of sparse file in "D" state)
To: viro@math.psu.edu (Alexander Viro)
Date: Mon, 8 Jan 2001 11:46:53 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        stefan@hello-penguin.com (Stefan Traby), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0101080244560.2221-100000@weyl.math.psu.edu> from "Alexander Viro" at Jan 08, 2001 02:50:26 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14FalM-0004MY-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Alan, it doesn't work that way. Maximal size depends on the type of object,
> for one thing. Moreover, it's not always a multiple of page size, so you

Its a multiple of page size for all fs's we have but I did it in terms of
bytes anyway

> still need foo_get_block() to be aware of the problem (it should return
> -EFBIG). Besides, we need to take care of the situations when some of
> get_block() calls fail in prepare_write() - that can happen due to other
> problems. I've fixed all that stuff for ext2 (check the patches posted on
> l-k after 12-pre6). We need to propagate it into other filesystems, but

I put it into generic_file_write. That covers most fs's it seems. The jffs 
guys are going to switch to generic_file_write soon and the other fs's 
that dont are wacko ones I dont care about ;)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
