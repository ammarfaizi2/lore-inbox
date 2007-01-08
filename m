Return-Path: <linux-kernel-owner+w=401wt.eu-S1751492AbXAHMMz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751492AbXAHMMz (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 07:12:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751491AbXAHMMz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 07:12:55 -0500
Received: from pne-smtpout4-sn2.hy.skanova.net ([81.228.8.154]:55351 "EHLO
	pne-smtpout4-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751492AbXAHMMy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 07:12:54 -0500
X-Greylist: delayed 4167 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Jan 2007 07:12:54 EST
Date: Mon, 8 Jan 2007 13:03:23 +0200
From: Sami Farin <safari-xfs@safari.iki.fi>
To: linux-kernel Mailing List <linux-kernel@vger.kernel.org>, xfs@oss.sgi.com
Subject: Re: xfs_file_ioctl / xfs_freeze: BUG: warning at kernel/mutex-debug.c:80/debug_mutex_unlock()
Message-ID: <20070108110323.GA3803@m.safari.iki.fi>
Mail-Followup-To: linux-kernel Mailing List <linux-kernel@vger.kernel.org>,
	xfs@oss.sgi.com
References: <20070104001420.GA32440@m.safari.iki.fi> <20070107213734.GS44411608@melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070107213734.GS44411608@melbourne.sgi.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2007 at 08:37:34 +1100, David Chinner wrote:
...
> > fstab was there just fine after -u.
> 
> Oh, that still hasn't been fixed?

Looked like it =)

> Generic bug, not XFS - the global
> semaphore->mutex cleanup converted the bd_mount_sem to a mutex, and
> mutexes complain loudly when a the process unlocking the mutex is
> not the process that locked it.
> 
> Basically, the generic code is broken - the bd_mount_mutex needs to
> be reverted back to a semaphore because it is locked and unlocked
> by different processes. The following patch does this....
> 
> BTW, Sami, can you cc xfs@oss.sgi.com on XFS bug reports in future;
> you'll get more XFS savvy eyes there.....

Forgot to.

Thanks for patch.  It fixed the issue, no more warnings.

BTW. the fix is not in 2.6.git, either.

-- 
Do what you love because life is too short for anything else.

