Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932406AbWAXTGf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932406AbWAXTGf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 14:06:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932481AbWAXTGf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 14:06:35 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:50595 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932406AbWAXTGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 14:06:34 -0500
Date: Tue, 24 Jan 2006 19:06:32 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>, Al Viro <viro@ftp.linux.org.uk>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       linu-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/6] vfs: extend loopback (bind) mounts by mnt_flags
Message-ID: <20060124190632.GB14201@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	Al Viro <viro@ftp.linux.org.uk>,
	Linux Kernel ML <linux-kernel@vger.kernel.org>,
	linu-fsdevel@vger.kernel.org
References: <20060121083843.GA10044@MAIL.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060121083843.GA10044@MAIL.13thfloor.at>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 21, 2006 at 09:38:43AM +0100, Herbert Poetzl wrote:
> 
> The following set of patches extends the per device 
> 'noatime', 'nodiratime' and last but not least the 
> 'ro' (read only) mount option to the vfs --bind mounts, 
> allowing them to behave like any other mount, by 
> honoring those mount flags (which are silently ignored 
> by the current implementation in 2.4.x and 2.6.x)   	
> 
> the patch makes the following syscall variations behave 
> as expected:
> 
>  - open (read/write/trunc), create
>  - link, symlink, unlink
>  - mknod (reg/block/char/fifo)
>  - mkfifo, mkdir, rmdir, rename
>  - (f,l)chown, (f)chmod, utime
>  - access, truncate, mmap
>  - ioctl (gen/ext2/ext3/reiser)
>  - (f,l)setxattr, (f,l)removexattr
> 
> an older version of this patch was included in 
> 2.6.0-test6-mm2, and v2.6.4-wolk2.0, the patches are
> in use by several people, without any issues ...
> 
> please consider inclusion (in -mm ?) and/or let me know
> what needs to be changed to get this functionality into
> mainline ...

Please see the original mail from Al on this subject.  We need to
split the "am I allowed to write to the fs" part out of permission().
Once we're at it we can pair it with the "don't need to write to fs anymore"
even and get saner unmount/remount semantics.

To get there we will still need the vfsmount propagatios, so these should
come first in the series.  Then the get/release write access helpers and
last the actual per-mount ro bit.  Your mnt_flags propagation fix is fine
on it's own and should go in asap.

And please send the patches to -fsdevel and in the proper patch format.
I have planned to look at this again in February, tell me if you want to
finish it before or at the same time, then I won't spend time on it.
