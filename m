Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129733AbRAHUND>; Mon, 8 Jan 2001 15:13:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129595AbRAHUMx>; Mon, 8 Jan 2001 15:12:53 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:20719 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129562AbRAHUMq>;
	Mon, 8 Jan 2001 15:12:46 -0500
Date: Mon, 8 Jan 2001 15:12:40 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Andreas Dilger <adilger@turbolinux.com>
cc: Chris Mason <mason@suse.com>, Alan Cox <alan@redhat.com>,
        Stefan Traby <stefan@hello-penguin.com>, linux-kernel@vger.kernel.org
Subject: Re: ramfs problem... (unlink of sparse file in "D" state)
In-Reply-To: <200101081907.f08J7ev15806@webber.adilger.net>
Message-ID: <Pine.GSO.4.21.0101081504200.4061-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 8 Jan 2001, Andreas Dilger wrote:

> Actually, this is wrong.  The ext2 inode limit is 2^32 512-byte sectors,
> not 2^32 blocksize blocks.  Yes this is a wart and Ted wants to fix it, as

??? Where? Oh, wait... ->i_blocks? I'ld rather refuse to grow past 2^32 -
sparse files can legitimately have large offsets and very low ->i_blocks.
But yes, we need to check for overflows. BTW, 2^32-1 is not good enough -
indirect blocks also contribute, so limiting ->i_size by 2Tb is not
guaranteed to keep ->i_blocks low.

IMO it's bogus - so far we are protected by inability to allocate that
much and once we are past that limit we should rather refuse to do
allocation than refuse to get large sparse files.

Or was it about something entirely different? I don't see other limiting
factors that would give 2Tb boundary for ->i_size, but ICBW.

Al, going down...

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
