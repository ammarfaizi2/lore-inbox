Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315170AbSEFUzg>; Mon, 6 May 2002 16:55:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315171AbSEFUzf>; Mon, 6 May 2002 16:55:35 -0400
Received: from ausxc10.us.dell.com ([143.166.98.229]:43532 "EHLO
	ausxc10.us.dell.com") by vger.kernel.org with ESMTP
	id <S315170AbSEFUzd>; Mon, 6 May 2002 16:55:33 -0400
Message-ID: <9A2D9C0E5A442340BABEBE55D81BEBDB0E0CE5@AUSXMPS313.aus.amer.dell.com>
From: Matt_Domsch@Dell.com
To: stano@meduna.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: CRC32 - computed or table-driven?
Date: Mon, 6 May 2002 15:55:23 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Stanislav Meduna" <stano@meduna.org> wrote:
> I need to compute a crc32 in my small not-ready-for-the-prime-time
> patch against 2.4.19-pre. I do not (yet) follow the 2.5 development.
> 
> There is <linux/crc32.h> that does what I want, but not quite
> effectively and with comments that it is unsuitable for bulk data
> and that it will migrate to net/core/crc.c.

Right.  In 2.5, there's a bulk data version, but that code hasn't been
backported to 2.4.x, and that was so far intentional.   (the comment about
net/core/crc.c is wrong, it should eventually go in lib/crc32.c).

> Any plans to do it "the right way" in 2.4?

Yes.  The stage 1 crc32 cleanups I did just removed ~60 duplicate copies of
the crc32 code in the ethernet drivers, but we (Jeff Garzik and Marcello)
didn't want more widespread changes.  That all happened in 2.4.19-pre{early}
IIRC.  Once they were convinced that the crc library code in 2.5.x wouldn't
break the drivers, it was believed that the code could easily be backported
- but no one has volunteered to do so yet.  Stage 2 is to add lib/crc32.c as
a module that adds the bulk crc32() function, but doesn't touch
ether_crc_le() or ether_crc(), so that can't break net drivers.

> I can post a patch, but I cannot test whether it breaks jffs2
> and as this adds 1 kB to the kernel that might not be needed
> I would like to ask first. Who is hacking these parts?

If you wanted to backport from 2.5 the lib/crc32.c code that generates the
table and exports a crc32 function, be my guest!

Thanks,
Matt
