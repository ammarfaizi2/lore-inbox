Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261698AbUKOUyW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261698AbUKOUyW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 15:54:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261697AbUKOUwm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 15:52:42 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:63368 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261698AbUKOUvv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 15:51:51 -0500
Date: Mon, 15 Nov 2004 14:51:39 -0600
From: Robin Holt <holt@sgi.com>
To: Norbert van Nobelen <Norbert@edusupport.nl>
Cc: Robin Holt <holt@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: 21 million inodes is causing severe pauses.
Message-ID: <20041115205138.GA12106@lnx-holt.americas.sgi.com>
References: <20041115195551.GA15380@lnx-holt.americas.sgi.com> <200411152135.35121.Norbert@edusupport.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411152135.35121.Norbert@edusupport.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2004 at 09:35:35PM +0100, Norbert van Nobelen wrote:
> It would help a lot if you provided logins to everybody on this list to this 
> desktop system of you (-:

That would not be possible.  The setup is not that uniq. It is basically
a SLES9 system with 4 300GB filesystem locally mounted and a large number
of autofs mounted home directories etc.  I can provide diagnostic counters
if they will be helpful.

> 
> Anyway: There is temporary solution, which will help a little in this case: 
> Increase the blocksize so that your total number of inodes decreases. Since 
> XFS is your own filesystem, you could calculate the results of this pretty 
> quick.

The problem is not isolated to XFS.  Even with smaller blocksizes, we
still have a large number of files being referenced which will result
in many inodes.  We saw the same behavior with ext2/3 and NFS.  I don't
think it has anything to do with XFS.

> 
> Using another filesystem could help too, but I don't have any comparison bases 
> for this since the largest system we have here at this moment only has 1 TB 
> of diskspace.

You should have enough disk space.  You will need a lot of memory as
well.  You will also need a workload which puts some memory pressure on
periodically, but not that much pressure and not that often.  This appears
to make the vm favor buffer cache to slab cache and allow the inode
cache to grow really large.

Thanks,
Robin Holt
