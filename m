Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261160AbVFTHL3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261160AbVFTHL3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 03:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261166AbVFTHL3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 03:11:29 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:19685 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261160AbVFTHL0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 03:11:26 -0400
Date: Mon, 20 Jun 2005 17:04:59 +1000
From: Nathan Scott <nathans@sgi.com>
To: Jan De Luyck <lkml@kcore.org>
Cc: linux-xfs@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6.12] XFS: Undeletable directory
Message-ID: <20050620070459.GB1549@frodo>
References: <200506191904.49639.lkml@kcore.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506191904.49639.lkml@kcore.org>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 19, 2005 at 07:04:49PM +0200, Jan De Luyck wrote:
> Hello lists,
> 
> I've had some XFS troubles today, and after cleaning up with xfs_repair and so 
> I'm stuck with one undeletable directory in /lost+found:
> 
> precious:/lost+found# ls -l
> total 8
> drwxrwxrwx  2 root root 8192 Jun 19  2005 4207214
> precious:/lost+found# rm -r 4207214
> rm: cannot remove directory `4207214': Directory not empty
> precious:/lost+found# ls -l 4207214/
> total 0
> precious:/lost+found# 
> 
> So there's one dir 4207214 there, and i can rename it and whatever, just not 
> remove it.
> 
> xfs_repair didn't solve the problem.
> 
> Any ideas?

What does:  xfs_db -r -c 'inode 4207214' -c print /dev/XXX
report?

I have seen a similar thing once before, awhile back, where the
directory inode was "empty" (only . and ..) and hence should've
been in shortform, but other fields indicated the inode was in
extent form still.  Never got to the bottom of it... I'd guess
there's somehow a case where the kernel XFS code can miss this
transformation - not sure where/how though.

If it comes to it, you can always zero out individual inode fields
for that inode in xfs_db (with -x option to enable write mode) and
then xfs_repair should be able to get past it.

cheers.

-- 
Nathan
