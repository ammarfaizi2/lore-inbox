Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261925AbVCLObV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261925AbVCLObV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 09:31:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261920AbVCLObU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 09:31:20 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:37136 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261925AbVCLO2x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 09:28:53 -0500
To: Junfeng Yang <yjf@stanford.edu>
Cc: Andrew Morton <akpm@osdl.org>, chaffee@bmrc.berkeley.edu,
       <mc@cs.Stanford.EDU>, <linux-kernel@vger.kernel.org>
Subject: Re: [CHECKER] crash + fsck cause file systems to contain loops
 (msdos and vfat, 2.6.11)
References: <Pine.GSO.4.44.0503120313140.11724-100000@elaine24.Stanford.EDU>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sat, 12 Mar 2005 23:28:34 +0900
In-Reply-To: <Pine.GSO.4.44.0503120313140.11724-100000@elaine24.Stanford.EDU> (Junfeng
 Yang's message of "Sat, 12 Mar 2005 03:21:19 -0800 (PST)")
Message-ID: <87fyz1ey5p.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Junfeng Yang <yjf@stanford.edu> writes:

>> Linus's current tree includes support for `mount -o sync' on the msdos and
>> vfat filesystems.
>
> Thanks Andrew.  I can just do a bk clone from
> http://linux.bkbits.net/linux-2.6 to get Linus's current tree, right?
>
> The warning reported here doesn't need mount -o sync to trigger though.
> A simple crash on a default mounted FS can usually cause the FS loop.
>
> (Also, I realized I made many typos in my report --- this implies I'm
> tired and should probably get some sleep :)

Interesting.

$ /devel/linux/works/fatfs/fatfstools/dosfstools-2.10/dosfsck/dosfsck -a bug10/crash.img
dosfsck 2.10, 22 Sep 2003, FAT32, LFN
/0006
  Directory does not have any cluster  ("." and "..").
  Dropping it.
Reclaimed 3 unused clusters (6144 bytes) in 3 chains.
Performing changes.
crash.img: 8 files, 3/8167 clusters

My fixed dosfsck found the above corruption in bug10/crash.img (bug7
has same corruption). And probably you can see root directory via 0006
directory, I guess your testing tree didn't have my patches yet (seems
old behavior).

BTW, what mount options did you use?

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
