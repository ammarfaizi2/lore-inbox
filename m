Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265776AbUF2PH3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265776AbUF2PH3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 11:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265777AbUF2PH3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 11:07:29 -0400
Received: from [66.199.228.3] ([66.199.228.3]:26629 "EHLO xdr.com")
	by vger.kernel.org with ESMTP id S265776AbUF2PHY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 11:07:24 -0400
Date: Tue, 29 Jun 2004 08:07:23 -0700
From: David Ashley <dash@xdr.com>
Message-Id: <200406291507.i5TF7NIJ027740@xdr.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Cached memory never gets released
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

More developments:

I've removed the ramdisk + nfs elements for testing. Now the system
has the root filesystem on /dev/hda1 (normal ide hard drive). This makes
no difference, the cache memory still builds up.

I got the SysRq stuff working, here are 3 successive snapshots with
progressively more memory lost to the cache:


SysRq : Show Memory
Mem-info:
Free pages:       73804kB (     0kB HighMem)
Zone:DMA freepages: 14008kB
Zone:Normal freepages: 59796kB
Zone:HighMem freepages:     0kB
( Active: 3146, inactive: 5217, free: 18451 )
6*4kB 6*8kB 5*16kB 5*32kB 4*64kB 9*128kB 6*256kB 3*512kB 3*1024kB 3*2048kB = 14008kB)
1231*4kB 881*8kB 565*16kB 262*32kB 103*64kB 28*128kB 5*256kB 1*512kB 0*1024kB 9*2048kB = 59796kB)
= 0kB)
Swap cache: add 0, delete 0, find 0/0, race 0+0
Free swap:            0kB
28672 pages of RAM
0 pages of HIGHMEM
901 reserved pages
4863 pages shared
0 pages swap cached
18 pages in page table cache
Buffer memory:       80kB
Cache memory:    11680kB


SysRq : Show Memory
Mem-info:
Free pages:       67912kB (     0kB HighMem)
Zone:DMA freepages: 13768kB
Zone:Normal freepages: 54144kB
Zone:HighMem freepages:     0kB
( Active: 4005, inactive: 5837, free: 16978 )
34*4kB 30*8kB 25*16kB 28*32kB 27*64kB 23*128kB 11*256kB 7*512kB 1*1024kB 0*2048kB = 13768kB)
422*4kB 807*8kB 315*16kB 272*32kB 190*64kB 73*128kB 20*256kB 7*512kB 2*1024kB 0*2048kB = 54144kB)
= 0kB)
Swap cache: add 0, delete 0, find 0/0, race 0+0
Free swap:            0kB
28672 pages of RAM
0 pages of HIGHMEM
901 reserved pages
1324 pages shared
0 pages swap cached
34 pages in page table cache
Buffer memory:       76kB
Cache memory:    17440kB



SysRq : Show Memory
Mem-info:
Free pages:       67700kB (     0kB HighMem)
Zone:DMA freepages: 14012kB
Zone:Normal freepages: 53688kB
Zone:HighMem freepages:     0kB
( Active: 9181, inactive: 874, free: 16925 )
5*4kB 5*8kB 4*16kB 4*32kB 3*64kB 8*128kB 5*256kB 2*512kB 2*1024kB 4*2048kB = 14012kB)
584*4kB 819*8kB 644*16kB 334*32kB 182*64kB 45*128kB 15*256kB 5*512kB 0*1024kB 0*2048kB = 53688kB)
= 0kB)
Swap cache: add 0, delete 0, find 0/0, race 0+0
Free swap:            0kB
28672 pages of RAM
0 pages of HIGHMEM
901 reserved pages
256 pages shared
0 pages swap cached
48 pages in page table cache
Buffer memory:       44kB
Cache memory:    38396kB



This problem is almost certainly within the linux kernel. It is very
difficult to reproduce since you've got to have
1) XFree86
2) Mozilla browser
3) Macromedia flash plugin
4) A certain flash page, not just any will do

Constantly reloading the flash page results in the cache buildup.
This represents a great denial of service opportunity if someone could
reduce this to the essence of how to make the problem happen.

Recently there was the announcement of the problem where if you get a
floating point exception within a signal handler repeatedly you could cause
the kernel to break. Perhaps this is a similiar situation, maybe if you
free a page within a signal handler, or unmap it, or something? I'm really
grasping here.

Note this is 2.4.x series kernel. I've tried 2.4.23 and 2.4.26. We've got a
modified kernel but going back to stock 2.4.26 with no custom modules has
the same problem. Usually the root filesystem is a 2M ramdisk with symlinks
to a readonly NFS mountpoint, but as stated above I tried replacing this with
a typical /dev/hda1 root filesystem with no change in behaviour.

Someone throw me a bone. I think I've been following up on everyone's
suggestions pretty well. I need ideas.

Thanks--
Dave
