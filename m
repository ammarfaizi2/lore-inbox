Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266526AbUBLRMk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 12:12:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266531AbUBLRMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 12:12:40 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:18139 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S266526AbUBLRMi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 12:12:38 -0500
Subject: Re: Bad Drive or JFS bug? (2.4.25-pre8)
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Kevin Fenzi <kevin-linux-kernel@scrye.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040211164958.BEC80CB32C@voldemort.scrye.com>
References: <20040211164958.BEC80CB32C@voldemort.scrye.com>
Content-Type: text/plain
Message-Id: <1076605942.16373.20.camel@shaggy.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 12 Feb 2004 11:12:22 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-02-11 at 10:49, Kevin Fenzi wrote:
> Greetings. 
> 
> It's unclear to me if this is a jfs error, or if my drive is simply
> dying. There are no other indications of errors with the drive, but in
> the logs: 

JFS definitely ran into some corrupt metadata.  It could either be
corrupt on disk, or a memory-corruption problem.  I don't know if
hardware is the cause, but you say that nothing indicates that.  If it
is caused by a software bug, it would be hard to track down unless it is
repeatable.  The BUG() itself should probably be replaced by something
nicer, like the first two errors reported by dbFree.

At this point the superblock should be marked dirty, so fsck should
attempt to repair the damage upon reboot.  I'd like to know if you
continue to see problems.

Thanks,
Shaggy
> 
> Feb 11 04:04:59 voldemort kernel: blkno = 6d2e74726f, nblocks = 65646c
> Feb 11 04:04:59 voldemort kernel: ERROR: (device ide0(3,3)): dbFree: block to be freed is outside the map
> Feb 11 04:04:59 voldemort kernel: blkno = 3000003831, nblocks = 392e6d
> Feb 11 04:04:59 voldemort kernel: ERROR: (device ide0(3,3)): dbFree: block to be freed is outside the map
> Feb 11 04:04:59 voldemort kernel: BUG at jfs_dmap.c:2764 assert(newval == leaf[buddy])
> Feb 11 04:04:59 voldemort kernel: kernel BUG at jfs_dmap.c:2764!

-- 
David Kleikamp
IBM Linux Technology Center

