Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261633AbVFOW6E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261633AbVFOW6E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 18:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261626AbVFOWyo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 18:54:44 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:8655 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261619AbVFOWxN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 18:53:13 -0400
Date: Thu, 16 Jun 2005 08:46:47 +1000
From: Nathan Scott <nathans@sgi.com>
To: Sebastian =?iso-8859-1?Q?Cla=DFen?= 
	<Sebastian.Classen@freenet-ag.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: FIGETBSZ and FIBMAP for directorys
Message-ID: <20050615224647.GB772@frodo>
References: <1118822287.28239.10.camel@basti79.freenet-ag.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118822287.28239.10.camel@basti79.freenet-ag.de>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2005 at 09:58:07AM +0200, Sebastian Cla?en wrote:
> Hi list...
> 
> I'm using this little program to find out which blocks are use by a
> particular file:
> ...
>                 if (ioctl(fd, FIBMAP, &block)) {
> ...
> 
> This works fine for regular files, but not for directorys. Both ioctl's,
> FIGETBSZ and FIBMAP, are implemented for regular files only. 
> 
> Is there a patch to make this FIGETBSZ and FIBMAP work on directorys
> too?

I doubt it, these ioctls are generally frowned on and noone touches
them these days - eg. from fs.h...
#define BMAP_IOCTL 1            /* obsolete - kept for compatibility */
#define FIBMAP     _IO(0x00,1)  /* bmap access */
#define FIGETBSZ   _IO(0x00,2)  /* get the block size used for bmap */

> Or alternativly, is there a way to find out which blocks are used by a
> directory?

There's an XFS-specific way if youre using XFS, and other filesystems
may have their own custom way of providing that information, I'm not
sure.  For XFS, the xfs_bmap(8) command uses XFS_IOC_GETBMAP to get
an inode's extent layout, and that works for all file types.

cheers.

-- 
Nathan
