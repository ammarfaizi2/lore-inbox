Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288051AbSCDPdJ>; Mon, 4 Mar 2002 10:33:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288377AbSCDPcs>; Mon, 4 Mar 2002 10:32:48 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:26354
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S288051AbSCDPcc>; Mon, 4 Mar 2002 10:32:32 -0500
Date: Mon, 4 Mar 2002 07:33:12 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: James D Strandboge <jstrand1@rochester.rr.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ext3 and undeletion
Message-ID: <20020304153312.GI353@matchmail.com>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	James D Strandboge <jstrand1@rochester.rr.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020304021714.GB353@matchmail.com> <E16hu8q-00080A-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16hu8q-00080A-00@the-village.bc.nu>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2002 at 03:12:44PM +0000, Alan Cox wrote:
> > another inode after the trunc op would break unix semantics.  In order to
> > work, you'd have to use a new inode (in .undelete, of course), copy, then do
> > the actual trunc call. 
> > This would make truncation expensive, whereas before it was pretty fast.
> > Modifying unlink will probably suffice.
> 
> You would need to hook the truncate/unlink paths in the file system. If 
> you are doing it within the fs it becomes cheap (at least for ext2) - as
> you can simply reassign the data blocks to a new inode, stuff the new inode
> into the magic "stuff we deleted" directory and continue.

It may make it easier to put this part in the kernel, but is there some way
to make it filesystem generic?

Undelete on truncate isn't a high priority, but if we do have it, it would
be nice if all of the filesystems that follow unix semantics (and maybe the
others too) could use generic VFS ops for this feature.

