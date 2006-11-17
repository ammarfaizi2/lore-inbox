Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755706AbWKQPSh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755706AbWKQPSh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 10:18:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755707AbWKQPSh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 10:18:37 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:46316 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1755704AbWKQPSg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 10:18:36 -0500
Date: Fri, 17 Nov 2006 16:18:21 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH -mm] freeze/thaw fs when BLOCK=n
Message-ID: <20061117151820.GA8867@elf.ucw.cz>
References: <20061116213600.9983f4f9.randy.dunlap@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061116213600.9983f4f9.randy.dunlap@oracle.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> From: Randy Dunlap <randy.dunlap@oracle.com>
> 
> Fix freeze/thaw filesystems with CONFIG_BLOCK disabled:
> kernel/power/process.c:124: warning: implicit declaration of function 'freeze_fil
> esystems'
> kernel/power/process.c:189: warning: implicit declaration of function 'thaw_files
> ystems'
> 
> Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>

I believe we'll simply want to remove {thaw,freeze}_filesystems. XFS
problem is solved with freezeable workqueues, and
{thaw,freeze}_filesystems has problems if someone is creating dm
snapshots in the meantime.
								Pavel

> ---
>  include/linux/buffer_head.h |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> --- linux-2619-rc5mm2.orig/include/linux/buffer_head.h
> +++ linux-2619-rc5mm2/include/linux/buffer_head.h
> @@ -314,7 +314,8 @@ static inline void invalidate_inode_buff
>  static inline int remove_inode_buffers(struct inode *inode) { return 1; }
>  static inline int sync_mapping_buffers(struct address_space *mapping) { return 0; }
>  static inline void invalidate_bdev(struct block_device *bdev, int destroy_dirty_buffers) {}
> -
> +static inline void freeze_filesystems(void) {}
> +static inline void thaw_filesystems(void) {}
>  
>  #endif /* CONFIG_BLOCK */
>  #endif /* _LINUX_BUFFER_HEAD_H */
> 
> 
> ---

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
