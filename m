Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313115AbSDOIsZ>; Mon, 15 Apr 2002 04:48:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313116AbSDOIsZ>; Mon, 15 Apr 2002 04:48:25 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:50948 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S313115AbSDOIsX>;
	Mon, 15 Apr 2002 04:48:23 -0400
Message-ID: <3CBA93AB.A20F0FF7@zip.com.au>
Date: Mon, 15 Apr 2002 01:47:39 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [prepatch] address_space-based writeback
In-Reply-To: <3CB4203D.C3BE7298@zip.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

An update to these patches is at

	http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.8/

All work at this time is on

dallocbase-10-page_alloc_fail.patch
dallocbase-35-pageprivate_fixes.patch
dallocbase-55-ext2_dir.patch
dallocbase-60-page_accounting.patch
ratcache-pf_memalloc.patch
mempool-node.patch
dallocbase-70-writeback.patch
ttd		(my current 2.5 things-to-do-list, just for fun)

none of the patches beyond these have even been tested in a week..

The new buffer<->page relationship rules seem to be working
out OK.  In a six-hour stress test on a quad Xeon with
1k blocksize ext3 in ordered-data mode there was one failure:
a block in a file which came up with wrong data.  There appears
to be a race in ext3 or the patch or 2.5 or something somewhere.
Still hunting this one.

It is all relatively stable now.  ramdisk, loop, reiserfs, ext2,
ext3-ordered, ext3-journalled, JFS and vfat have been tested.

minixfs and sysvfs are broken with these patches.  They rely
on preservation of directory data outside i_size.   Will fix.

-
