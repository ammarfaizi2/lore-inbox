Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129413AbRAXIUJ>; Wed, 24 Jan 2001 03:20:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129776AbRAXIT7>; Wed, 24 Jan 2001 03:19:59 -0500
Received: from h24-65-192-120.cg.shawcable.net ([24.65.192.120]:65006 "EHLO
	webber.adilger.net") by vger.kernel.org with ESMTP
	id <S129413AbRAXITq>; Wed, 24 Jan 2001 03:19:46 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200101240818.f0O8IxK11946@webber.adilger.net>
Subject: Re: Partition IDs in the New World TM
In-Reply-To: <3A6DDAD4.4889AC42@alacritech.com> "from Matt D. Robinson at Jan
 23, 2001 11:26:12 am"
To: "Matt D. Robinson" <yakker@alacritech.com>
Date: Wed, 24 Jan 2001 01:18:59 -0700 (MST)
CC: Andreas Dilger <adilger@turbolinux.com>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL73 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Robinson writes:
> Andreas Dilger wrote:
> > What would be wrong with changing the kernel to skip the first page of
> > swap, and allowing us to put a signature there?  This would be really
> > useful for systems that mount ext2 filesystems by LABEL or UUID.  With
> > the exception of swap, you currently don't need to care about what disk
> > a filesystem is on.  Of course, LVM also fixes this, but not everyone
> > runs LVM.
> 
> LKCD starts writing a crash dump after the first page of the swap
> partition (if that is used as the dump partition), so I'd hate to see
> this implemented.

I don't see how this applies...  Now that I've been educated about how
swap is set up, I see swap already uses the first page for config info
and a signature.  Adding some sort of label or ID to the swap info
wouldn't affect swapping or LKCD in any way because it still wouldn't
go past the first page.

It would already be possible to auto-enable any devices with the swap
signature by doing the same sort of search mount(8) is doing for LABEL
and UUID.  The only drawback would be that you can't specify priority
and usage order, and you can't auto-detect swap files.  Swap files are
not an issue because you can use the file name to locate them.

Cheers, Andreas 
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
