Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263654AbTDXNTa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 09:19:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263655AbTDXNTa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 09:19:30 -0400
Received: from ns.suse.de ([213.95.15.193]:13836 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263654AbTDXNT3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 09:19:29 -0400
To: rwhron@earthlink.net
Cc: linux-kernel@vger.kernel.org, lord@sgi.com
Subject: Re: [benchmarks] various filesystems on 2.5.68
References: <20030424124728.GA1477@rushmore.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 24 Apr 2003 15:31:22 +0200
In-Reply-To: <20030424124728.GA1477@rushmore.suse.lists.linux.kernel>
Message-ID: <p73vfx4vx79.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rwhron@earthlink.net writes:

> mount options
> mount -t ext2 -o defaults,noatime /dev/sdc1 /fs1
> mount -t ext3 -o defaults,noatime,data=writeback /dev/sdc1 /fs1
> mount -t reiserfs -o defaults,noatime /dev/sdc1 /fs1
> mount -t jfs -o defaults,noatime /dev/sdc1 /fs1
> mount -t xfs -o logbufs=8,logbsize=32768,noatime /dev/sdc1 /fs1
> 
> mkfs command
> mke2fs -q /dev/sdc1
> mke2fs -q -j -J size=400 /dev/sdc1
> yes  "y" | mkreiserfs /dev/sdc1 >/tmp/mkr.out 2>&1
> jfs_mkfs -q /dev/sdc1
> mkfs.xfs -l size=32768b -f /dev/sdc1
> 
> Very recent version of xfsprogs/jfsutils/reiserfsprogs/e2fsprogs.
> 
> XFS mount/mkfs options came from the XFS FAQ and are very desireable
> for these tests based on an earlier run without them.  If anyone

It's my experience too that XFS often performs badly with the default
mkfs/mount options, especially for metadata intensive workloads. The
drawback is that it eats memory. I've been thinking about making it
set the bigger mount option by default based on the available physical
memory; this would probably help a lot of users.

iirc one drawback is that it eats from the vmalloc area which is only 64MB 
by default on 32bit.  But still should not be that big an issue. On 64bit
it's not an issue at all of course.

Of course the log size cannot be changed this way, but perhaps the default
in mkfs is just too small for today's disk sizes?

-Andi
