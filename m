Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266455AbUBFEHh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 23:07:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266463AbUBFEHh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 23:07:37 -0500
Received: from relay04.roc.ny.frontiernet.net ([66.133.131.37]:5600 "EHLO
	relay04.roc.ny.frontiernet.net") by vger.kernel.org with ESMTP
	id S266455AbUBFEHf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 23:07:35 -0500
Message-ID: <4021C152.3080501@xfs.org>
Date: Wed, 04 Feb 2004 22:06:42 -0600
From: Steve Lord <lord@xfs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: ak@suse.de, linux-kernel@vger.kernel.org, kenneth.w.chen@intel.com
Subject: Re: Limit hash table size
References: <B05667366EE6204181EABE9C1B1C0EB5802441@scsmsx401.sc.intel.com.suse.lists.linux.kernel> <20040205155813.726041bd.akpm@osdl.org.suse.lists.linux.kernel> <p73isilkm4x.fsf@verdi.suse.de> <4021AC9F.4090408@xfs.org> <20040205191240.13638135.akpm@osdl.org>
In-Reply-To: <20040205191240.13638135.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Steve Lord <lord@xfs.org> wrote:
> 
>> I have seen some dire cases with the dcache, SGI had some boxes with
>> millions of files out there, and every night a cron job would come
>> along and suck them all into memory. Resources got tight at some point,
>> and as more inodes and dentries were being read in, the try to free
>> pages path was continually getting called. There was always something
>> in filesystem cache which could get freed, and the inodes and dentries
>> kept getting more and more of the memory.
> 
> 
> There are a number of variables here.  Certainly, the old
> inodes-pinned-by-highmem pagecache will cause this to happen - badly.  2.6
> is pretty aggressive at killing off those inodes.
> 
> What kernel was it?
> 
> Was it a highmem box?  If so, was the filesystem in question placing
> directory pagecache in highmem?  If so, that was really bad on older 2.4:
> the directory pagecache in highmem pins down all directory inodes.
> 

This is where my memory gets a little hazy, its been a few months.
This would have been a 2.4 kernel (probably around 2.4.21)
on an Altix, the filesystem was XFS. So no highmem, but definitely
not your standard kernel.

I never had time to dig into it too much, but I always thought that
on machines with large amounts of memory it was too easy for the
inode and dcache pools to get very large at the expense of the
regular memory zones. While there were pages available, the dcache
and inode zones could just keep on growing. If you run a big
enough find you get lots of memory into the dcache zone and
have a hard time getting it out again.

And it was try_to_free_pages I was referring to.

It does look like 2.6 does better, but I don't have quite the
amount of memory on my laptop....

Steve
