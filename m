Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263640AbUHSHs5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263640AbUHSHs5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 03:48:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263117AbUHSHs4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 03:48:56 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:25797 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S263664AbUHSHsn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 03:48:43 -0400
Date: Thu, 19 Aug 2004 18:44:10 +1000
From: Nathan Scott <nathans@sgi.com>
To: David Martinez Moreno <ender@debian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Crashes and lockups in XFS filesystem (2.6.8-rc4).
Message-ID: <20040819084410.GA14750@frodo>
References: <200408181816.57940.ender@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <200408181816.57940.ender@debian.org>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2004 at 06:16:57PM +0200, David Martinez Moreno wrote:
> 	Hello, I am getting persistent lockups that could be IMHO XFS-related. I 
> created a fresh XFS filesystem in a SCSI disk, with xfsprogs version 2.6.18.
> 
> 	Mounted /dev/sda1 under /mnt, after that, I have been copying lots of files 
> from /dev/md0, then run a find blabla -exec rm \{\{ \; over /mnt and then 
> voilà! the lockup:

Did /mnt run out of space while doing that?  Or nearly?  There's
a known issue with that area of the XFS code, in conjunction with
4K stacks at the moment - was that enabled in your .config?

Looks like something stamped on parts of the xfs_mount structure
for the filesystem mounted at /mnt, a stack overrun would explain
that and your subsequent oopsen.

cheers.

-- 
Nathan
