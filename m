Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319277AbSIEXB6>; Thu, 5 Sep 2002 19:01:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319295AbSIEXB5>; Thu, 5 Sep 2002 19:01:57 -0400
Received: from dsl-213-023-039-222.arcor-ip.net ([213.23.39.222]:7851 "EHLO
	starship") by vger.kernel.org with ESMTP id <S319277AbSIEXBZ>;
	Thu, 5 Sep 2002 19:01:25 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: ptb@it.uc3m.es, Helge Hafting <helgehaf@aitel.hist.no>
Subject: Re: (fwd) Re: [RFC] mount flag "direct"
Date: Fri, 6 Sep 2002 01:08:38 +0200
X-Mailer: KMail [version 1.3.2]
Cc: ptb@it.uc3m.es, linux-kernel@vger.kernel.org
References: <200209051424.g85EOx105274@oboe.it.uc3m.es>
In-Reply-To: <200209051424.g85EOx105274@oboe.it.uc3m.es>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17n5jq-0006CR-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 September 2002 16:24, Peter T. Breuer wrote:
> Fine, but where is the log/phys translation done?

It's done here:

   http://lxr.linux.no/source/mm/filemap.c#L438

> I presume that the
> actual inode contains sufficient info to do the translation,

The inode, plus an arbitrary amount of associated, on-disk metadata.

> because
> the inode has a physical location on disk, and it is also associated
> with a file, and what we do is generally start from the inode and trace
> down to where the inode says the logical block shoul dbe, and then look
> it up. During this time the inode location on disk must be locked
> (with a read lock). I can do that. If you let me have "tag 
> requests" in the block layers and let me generate them in the VFS
> layers. Yes, I agree, I have to know where the inode is on disk
> in order to generate the block request, but the FS will know,
> and I just want it to tell VFS .. well, too much detail.

Actually, while much of this seems simple when thought of in abstract
terms, in practice it's quite involved.  You'll need to allocate at
least a few months to code study just to know what the issues are, and
that is with the help of the various excellent resources that are
available.

I'd suggest starting here, and figuring out how the ->get_block
interface works:

   http://lxr.linux.no/source/fs/buffer.c#L1692

-- 
Daniel
