Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261530AbULTPVb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261530AbULTPVb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 10:21:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261542AbULTPTW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 10:19:22 -0500
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:59861 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S261530AbULTPL0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 10:11:26 -0500
Date: Mon, 20 Dec 2004 16:10:45 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: James Pearson <james-p@moving-picture.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Reducing inode cache usage on 2.4?
Message-ID: <20041220151045.GL4424@dualathlon.random>
References: <41C316BC.1020909@moving-picture.com> <20041217151228.GA17650@logos.cnet> <41C37AB6.10906@moving-picture.com> <20041217172104.00da3517.akpm@osdl.org> <20041218110247.GB31040@logos.cnet> <41C6D802.7070901@moving-picture.com> <20041220124604.GB2529@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041220124604.GB2529@logos.cnet>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2004 at 10:46:04AM -0200, Marcelo Tosatti wrote:
> On Mon, Dec 20, 2004 at 01:47:46PM +0000, James Pearson wrote:
> > I've tested the patch on my test setup - running a 'find $disk -type f' 
> > and a cat of large files to /dev/null at the same time does indeed 
> > reduce the size of the inode and dentry caches considerably - the first 
> > column numbers for fs_inode, linvfs_icache and dentry_cache in 
> > /proc/slabinfo hover at about 400-600 (over 900000 previously).
> > 
> > However, is this going a bit to far the other way? When I boot the 
> > machine with 4Gb RAM, the inode and dentry caches are squeezed to the 
> > same amounts, but it may be the case that it would be more beneficial to 
> > have more in the inode and dentry caches? i.e. I guess some sort of 
> > tunable factor that limits the minimum size of the inode and dentry 
> > caches in this case?
> 
> One can increase vm_vfs_scan_ratio if required, but hopefully this change
> will benefit all workloads.
> 
> Andrew, Andrea, do you think of any workloads which might be hurt by this change?

I wouldn't touch the defaults, but the sysctl is there so if you've a
strange workload you can tune for it.

There's nothing wrong with dcache/icache growing a lot. A cat of a large
file is polluting the cache, so that's not a workload that should shrink
the dcache/icache. I'd prefer a feedback based on a real useful workload
before even considering touching the defaults at this time.
