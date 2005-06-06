Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261174AbVFFEib@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261174AbVFFEib (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 00:38:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261176AbVFFEib
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 00:38:31 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:39396 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261174AbVFFEi0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 00:38:26 -0400
Date: Mon, 6 Jun 2005 14:32:07 +1000
From: Nathan Scott <nathans@sgi.com>
To: Goran Gajic <ggajic@sbb.co.yu>, arunr@sgi.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: XFS and 2.6.12-rc5
Message-ID: <20050606043207.GC1688@frodo>
References: <Pine.BSF.4.62.0506011308530.86037@mail.sbb.co.yu> <20050603044138.GB1653@frodo> <Pine.BSF.4.62.0506031052260.57771@mail.sbb.co.yu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.BSF.4.62.0506031052260.57771@mail.sbb.co.yu>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2005 at 10:56:24AM +0200, Goran Gajic wrote:
> >Also, the diagnostic will contain an inode number - for bonus points
> >run "xfs_db -r -c 'inode XXX' -c print /dev/foo" and send me that as
> >well.  Thanks!
> 
> You are right about message here it is:
> 
> xfs_db -r -c 'inode 448631586' -c print /dev/sdb1
> ...
> u.bmx[0-3] = [startoff,startblock,blockcount,extentflag] 
> 0:[177,2557931,341,0] 1:[18014398509481983,4498651825045504,0,1] 
> 2:[15184073051865088,0,0,0] 3:[0,1422,1245184,0]
  ^^^^^^^^^^^^^^^^^^^^^^^^^^^

This is the guy - startblock being zero is fatal.  You'll need to
run xfs_repair to clear that up.  If you know how it got in that
state, I'd be keen to hear it, or if it persists after repair.

[Arun, those superblock checks you added awhile back should be
shutting down the filesystem, not panicing the system, I think?
It looks like theres a signedness issue in the diagnostics too.]

> Turning off cron.daily stops this message so I guess you are right.

Repairing that inode should make it go away entirely.

cheers.

-- 
Nathan
