Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130225AbRAEN0L>; Fri, 5 Jan 2001 08:26:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129757AbRAENZw>; Fri, 5 Jan 2001 08:25:52 -0500
Received: from zeus.kernel.org ([209.10.41.242]:2308 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129387AbRAENZq>;
	Fri, 5 Jan 2001 08:25:46 -0500
Date: Fri, 5 Jan 2001 13:22:28 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andreas Dilger <adilger@turbolinux.com>,
        Daniel Phillips <phillips@innominate.de>,
        "Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Journaling: Surviving or allowing unclean shutdown?
Message-ID: <20010105132228.Y1290@redhat.com>
In-Reply-To: <200101050800.f0580He12396@webber.adilger.net> <E14EWGE-0007bW-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <E14EWGE-0007bW-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Jan 05, 2001 at 12:46:19PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jan 05, 2001 at 12:46:19PM +0000, Alan Cox wrote:
> > recovery.  Because the ext3 journal is just a series of data blocks to
> > be copied into the filesystem (rather than "actions" to be done), it
> > doesn't matter how many times it is done.  The recovery flags are not
> > reset until after the journal replay is completed.
> 
> Which means an ext3 volume cannot be recovered on a hard disk error. 

Depends on the error.  If the disk has gone hard-readonly, then we
need to recover in core, and that's something which is not yet
implemented but is a known todo item.  Otherwise, it's not worse than
an error on ext2: you don't have a guaranteed safe state to return to
so you fall back to recovering what you can from the journal and then
running an e2fsck pass.  e2fsck groks the journal already.

And yes, a badly faulty drive can mess this up, but it can mess it for
ext2 just as badly.

Cheers,
 Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
