Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964896AbWAZVIz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964896AbWAZVIz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 16:08:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964897AbWAZVIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 16:08:55 -0500
Received: from MAIL.13thfloor.at ([212.16.62.50]:46474 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S964896AbWAZVIy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 16:08:54 -0500
Date: Thu, 26 Jan 2006 22:08:53 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Christoph Hellwig <hch@infradead.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Al Viro <viro@ftp.linux.org.uk>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       linu-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/6] vfs: extend loopback (bind) mounts by mnt_flags
Message-ID: <20060126210853.GB22020@MAIL.13thfloor.at>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	Al Viro <viro@ftp.linux.org.uk>,
	Linux Kernel ML <linux-kernel@vger.kernel.org>,
	linu-fsdevel@vger.kernel.org
References: <20060121083843.GA10044@MAIL.13thfloor.at> <20060124190632.GB14201@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060124190632.GB14201@infradead.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2006 at 07:06:32PM +0000, Christoph Hellwig wrote:
> On Sat, Jan 21, 2006 at 09:38:43AM +0100, Herbert Poetzl wrote:
> > 
> > The following set of patches extends the per device 
> > 'noatime', 'nodiratime' and last but not least the 
> > 'ro' (read only) mount option to the vfs --bind mounts, 
> > allowing them to behave like any other mount, by 
> > honoring those mount flags (which are silently ignored 
> > by the current implementation in 2.4.x and 2.6.x)   	
> > 
> > the patch makes the following syscall variations behave 
> > as expected:
> > 
> >  - open (read/write/trunc), create
> >  - link, symlink, unlink
> >  - mknod (reg/block/char/fifo)
> >  - mkfifo, mkdir, rmdir, rename
> >  - (f,l)chown, (f)chmod, utime
> >  - access, truncate, mmap
> >  - ioctl (gen/ext2/ext3/reiser)
> >  - (f,l)setxattr, (f,l)removexattr
> > 
> > an older version of this patch was included in 
> > 2.6.0-test6-mm2, and v2.6.4-wolk2.0, the patches are
> > in use by several people, without any issues ...
> > 
> > please consider inclusion (in -mm ?) and/or let me know
> > what needs to be changed to get this functionality into
> > mainline ...
> 
> Please see the original mail from Al on this subject. We need to
> split the "am I allowed to write to the fs" part out of permission().
> Once we're at it we can pair it with the "don't need to write to fs
> anymore" even and get saner unmount/remount semantics.

could you point me to this thread/email, so that I can
(re)read it?

> To get there we will still need the vfsmount propagatios, so these
> should come first in the series. Then the get/release write access
> helpers and last the actual per-mount ro bit. Your mnt_flags
> propagation fix is fine on it's own and should go in asap.
>
> And please send the patches to -fsdevel and in the proper patch

will do so, once I figure out what was improper ...
(as I tried to follow Andrew's tpp document in the first palce)

> format. I have planned to look at this again in February, tell me if
> you want to finish it before or at the same time, then I won't spend
> time on it.

once I figured out what is desired/wanted/acceptable, I'm
willing to do it ...

best,
Herbert

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
