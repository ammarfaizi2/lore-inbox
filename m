Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262075AbUBWX2H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 18:28:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262076AbUBWX2H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 18:28:07 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61878 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262075AbUBWX2E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 18:28:04 -0500
Date: Mon, 23 Feb 2004 23:28:04 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Nathan Scott <nathans@sgi.com>
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blkdev_open/bd_claim vs BLKBSZSET
Message-ID: <20040223232803.GD31035@parcelfarce.linux.theplanet.co.uk>
References: <20040223231705.GB773@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040223231705.GB773@frodo>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 24, 2004 at 10:17:05AM +1100, Nathan Scott wrote:
> Hi there,
> 
> I was modifying mkfs.xfs to use O_EXCL for 2.6, and hit a snag.
> It seems that once I've opened a block dev with O_EXCL I can no
> longer issue the BLKBSZSET ioctl to it.  (Is that the expected
> behavior?  If so, ignore...)
 
> And mkfs gets EBUSY back from the ioctl.  Using the patch
> below, the ioctl succeeds cos the original filp bdev owner
> from open now matches with the owner in the ioctl call.  I
> suspect that would be the correct behavior, but perhaps I'm
> overlooking some good reason for it being this way?

<shrug> it can be done that way, but I really wonder why the hell does
mkfs.xfs bother with BLKBSZSET in the first place?

FWIW, that ioctl is practically never the right thing to do these days.
I'm not saying that we shouldn't apply the patch - it looks sane - but
it looks like mkfs.xfs is doing something bogus.
