Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264578AbTKNUaw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 15:30:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264580AbTKNUaw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 15:30:52 -0500
Received: from gaia.cela.pl ([213.134.162.11]:16140 "EHLO gaia.cela.pl")
	by vger.kernel.org with ESMTP id S264578AbTKNUau (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 15:30:50 -0500
Date: Fri, 14 Nov 2003 21:30:28 +0100 (CET)
From: Maciej Zenczykowski <maze@cela.pl>
To: Gene Heskett <gene.heskett@verizon.net>
cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       Patrick Beard <patrick@scotcomms.co.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test9 VFAT problem
In-Reply-To: <200311141458.47052.gene.heskett@verizon.net>
Message-ID: <Pine.LNX.4.44.0311142124460.14447-100000@gaia.cela.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> No, but here it is, on both sda and sda1:
> 
> [root@coyote root]# dosfsck /dev/sda
> dosfsck 2.8, 28 Feb 2001, FAT32, LFN
> Logical sector size is zero.

We've already determined that /dev/sda is the partition table and should 
thus fail.

> [root@coyote root]# dosfsck /dev/sda1
> dosfsck 2.8, 28 Feb 2001, FAT32, LFN
> /dev/sda1: 2 files, 2/3997 clusters

Hmm so it passes.
Could you try passing -v (for verbose) to the fsck...
Also perhaps just do
  cat /dev/sda1 > /tmp/file
  dosfsck -v /tmp/file
  mount -o loop /tmp/file /mnt/somewhere
and see if that fails, if so the bug is pure vfat
then try bzipping the /tmp/file and posting it somewhere and pass the link 
and I'll take a look...

> That first one doesn't look kosher to me!
> Q: Is FAT32 the same as VFAT?

FAT32 is one possibility of VFAT - VFAT is any FAT(12,16,32) with long 
filenames.

Cheers,
MaZe.

