Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129532AbRAHUjP>; Mon, 8 Jan 2001 15:39:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129752AbRAHUjG>; Mon, 8 Jan 2001 15:39:06 -0500
Received: from [24.65.192.120] ([24.65.192.120]:50926 "EHLO webber.adilger.net")
	by vger.kernel.org with ESMTP id <S129532AbRAHUix>;
	Mon, 8 Jan 2001 15:38:53 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200101082038.f08Kcds16098@webber.adilger.net>
Subject: Re: ramfs problem... (unlink of sparse file in "D" state)
In-Reply-To: <Pine.GSO.4.21.0101081504200.4061-100000@weyl.math.psu.edu>
 "from Alexander Viro at Jan 8, 2001 03:12:40 pm"
To: Alexander Viro <viro@math.psu.edu>
Date: Mon, 8 Jan 2001 13:38:39 -0700 (MST)
CC: Andreas Dilger <adilger@turbolinux.com>, Chris Mason <mason@suse.com>,
        Alan Cox <alan@redhat.com>, Stefan Traby <stefan@hello-penguin.com>,
        linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL73 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro writes:
> Andreas Dilger wrote:
> > Actually, this is wrong.  The ext2 inode limit is 2^32 512-byte sectors,
> > not 2^32 blocksize blocks.  Yes this is a wart and Ted wants to fix it, as
> 
> ??? Where? Oh, wait... ->i_blocks? I'ld rather refuse to grow past 2^32 -
> sparse files can legitimately have large offsets and very low ->i_blocks.
> But yes, we need to check for overflows. BTW, 2^32-1 is not good enough -
> indirect blocks also contribute, so limiting ->i_size by 2Tb is not
> guaranteed to keep ->i_blocks low.

Yes, I was thinking i_blocks, but you are correct - I wasn't accounting for
the indirect blocks.  This limit is still {2,4,8,16} times smaller than the
limit you were calculating for i_size.  If we do the i_blocks limit checking
at block allocation time (for large sparse files) this is even better, but
so far it wasn't done...

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
