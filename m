Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131940AbRAPVME>; Tue, 16 Jan 2001 16:12:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132679AbRAPVLy>; Tue, 16 Jan 2001 16:11:54 -0500
Received: from [24.65.192.120] ([24.65.192.120]:20472 "EHLO webber.adilger.net")
	by vger.kernel.org with ESMTP id <S132873AbRAPVLp>;
	Tue, 16 Jan 2001 16:11:45 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200101162111.f0GLBNb14141@webber.adilger.net>
Subject: Re: Linux not adhering to BIOS Drive boot order?
In-Reply-To: <12057.979667891@redhat.com> "from David Woodhouse at Jan 16, 2001
 05:58:11 pm"
To: David Woodhouse <dwmw2@infradead.org>
Date: Tue, 16 Jan 2001 14:11:21 -0700 (MST)
CC: Venkatesh Ramamurthy <Venkateshr@ami.com>,
        "'Bryan Henderson'" <hbryan@us.ibm.com>, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL73 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse writes:
> There are patches available for the 2.2 kernel which provide the facility 
> to mount by UUID or volume label. It seems that nobody is actively 
> maintaining those at the moment. If you want to update those to the current 
> 2.2 and 2.4 kernels, well volunteered.

I'm quite interested in this patch, and have taken a good look at it.
Some changes are in order (IMHO) to make it more usable.  It should take
parameters that are the same as in /etc/fstab (i.e. LABEL= and UUID=
instead of L: and UUID:).  In the end I re-wrote most of the patch, so
that we resolve ROOT_DEV before calling mount_root(), just to be a bit
more consistent.  I will release a new patch for 2.2.18 and 2.4.0 after
David Balazic has a look at it.

I know a bit about LILO, so I should be able to get the "root=LABEL=" to
work there as well.

I also need to do some work like this in e2fsprogs, so it may make sense
to create a little library that can be updated to handle other kinds of
filesystem/partition LABELs and UUIDs as the need arises.  They were
talking about putting a LABEL/UUID into reiserfs recently.  This saves
us from having to fix ext2-specific in dozens of utilities (e.g. LILO,
mount, fsck, dump, etc).

One reason why this may NOT ever make it into the kernel is that I know
"kernel poking at devices" is really frowned upon.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
