Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129777AbQJ3Xhe>; Mon, 30 Oct 2000 18:37:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129822AbQJ3XhY>; Mon, 30 Oct 2000 18:37:24 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:37640 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129777AbQJ3XhL>; Mon, 30 Oct 2000 18:37:11 -0500
Message-ID: <39FE061D.A68170B1@transmeta.com>
Date: Mon, 30 Oct 2000 15:37:01 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10-pre3 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: / on ramfs, possible?
In-Reply-To: <Pine.LNX.4.21.0010302329140.16675-100000@imladris.demon.co.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse wrote:
> 
> On Mon, 30 Oct 2000, H. Peter Anvin wrote:
> 
> > Pardon?!  This doesn't make any sense...
> >
> > The question was: how do switch from the initrd to using the ramfs as /?
> > Using pivot_root should do it (after the pivot, you can of course nuke
> > the initrd ramdisk.)
> 
> My question is: What do you want to do that for? You can nuke the initrd
> ramdisk, but you can't drop the rd.c code, or ll_rw_blk.c code, etc. So
> why not just keep your root filesystem in the initrd where it started off?
> 

Umm... because the size of a ramdisk is fixed, but the size of a ramfs is
flexible?

I can certainly understand this problem... I might in fact do exactly
this in the next version of my SuperRescue disk.  There, the ramdisk
which is the real root is populated from a .tar.gz file; the initrd is
just there to unpack the .tar.gz file onto the "real" ramdisk; the initrd
is then jettisoned.

Why not just have the real root be the initrd, you ask?  It's too large:
since an initrd needs to exist in both compressed form and uncompressed
form in memory at the same time; it would mean SuperRescue would no
longer work on systems with 64 MB RAM.  If I went to ramfs it might
actually work on systems with 48 MB RAM, albeit you better not need to
much space in / (or conversely, it would suddenly let you put a whole lot
more stuff in /tmp if you have 512 MB.)

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
