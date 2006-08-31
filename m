Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751318AbWHaISf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318AbWHaISf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 04:18:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbWHaISf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 04:18:35 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:21637 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751318AbWHaISe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 04:18:34 -0400
Date: Thu, 31 Aug 2006 18:17:26 +1000
From: David Chinner <dgc@sgi.com>
To: Yao Fei Zhu <walkinair@cn.ibm.com>
Cc: David Chinner <dgc@sgi.com>, linux-kernel@vger.kernel.org,
       haveblue@us.ibm.com, xfs@oss.sgi.com
Subject: Re: kernel BUG in __xfs_get_blocks at fs/xfs/linux-2.6/xfs_aops.c:1293!
Message-ID: <20060831081726.GV5737019@melbourne.sgi.com>
References: <44F67847.6030307@cn.ibm.com> <20060831074742.GD807830@melbourne.sgi.com> <44F6979C.4070309@cn.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44F6979C.4070309@cn.ibm.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2006 at 04:02:36PM +0800, Yao Fei Zhu wrote:
> David Chinner wrote:
> >Hmmmm. We've mapped a range that has been reserved for a delayed
> >allocate extent during a direct I/O. That should not happen as XFS
> >flushes delalloc extents before executing a direct read and holds
> >the I/O lock which will prevent any new writes from mapping new
> >delalloc extents. Something went astray, though. :(
> >
> >Can you give me some more detail on the machine you're running?
> >e.g. How many CPUs, RAM and what type of disk subsystem you are using?
> >That will make it easier for us to try to reproduce this problem.
>
> The test box is an IBM System p5 Linux partition, allocated with
> 0.8 physical POWER5+ cpu processing unit/ 2 virtual processors and 8GB 
> memory.
> The disk is exported by AIX Virtual IO Server.

Nothing too unusual there.

> BTW, I have CONFIG_PPC_64K_PAGES enabled.

But that might be a good place to start. Can you see if you can
reproduce the problem without this config option set?

Cheers,

Dave.
-- 
Dave Chinner
Principal Engineer
SGI Australian Software Group
