Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261165AbVFCErz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261165AbVFCErz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 00:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261190AbVFCErz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 00:47:55 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:37579 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261165AbVFCErx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 00:47:53 -0400
Date: Fri, 3 Jun 2005 14:41:38 +1000
From: Nathan Scott <nathans@sgi.com>
To: Goran Gajic <ggajic@sbb.co.yu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: XFS and 2.6.12-rc5
Message-ID: <20050603044138.GB1653@frodo>
References: <Pine.BSF.4.62.0506011308530.86037@mail.sbb.co.yu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.BSF.4.62.0506011308530.86037@mail.sbb.co.yu>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2005 at 01:10:47PM +0200, Goran Gajic wrote:
> xfs partition is exported via nfs to FreeBSD-5.4 machine. This is what I 
> find every morning in my syslog:
> 
>  ------------[ cut here ]------------
>  kernel BUG at fs/xfs/support/debug.c:106!
> ...
>  [<c0269758>] xfs_bmap_search_extents+0x108/0x140
>  [<c026accd>] xfs_bmapi+0x28d/0x1660

There should be some diagnostic text just above this panic message,
what does it say?  At a guess, I'd say you have a corrupt inode on
disk, and your nightly cron jobs are tripping this up each time.
The panic happens cos the kernel detects an inode with an extent
map which claiming to have an extent starting at the offset of the
primary superblock.  I've seen another case of this recently which
looked like a possible compiler bug, so could you send me both the
full diagnostic message and your compiler version number?

Also, the diagnostic will contain an inode number - for bonus points
run "xfs_db -r -c 'inode XXX' -c print /dev/foo" and send me that as
well.  Thanks!

cheers.

-- 
Nathan
