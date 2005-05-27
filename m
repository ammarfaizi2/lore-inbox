Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261442AbVE0CYv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261442AbVE0CYv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 22:24:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261449AbVE0CYv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 22:24:51 -0400
Received: from postfix4-2.free.fr ([213.228.0.176]:12520 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S261442AbVE0CYg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 22:24:36 -0400
Message-ID: <4296847C.6010602@guerrier.com>
Date: Fri, 27 May 2005 04:22:52 +0200
From: Olivier Guerrier <olivier.lkml@guerrier.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: huiac@internode.on.net
CC: linux-kernel@vger.kernel.org
Subject: Re: Fake ext3 corruption on raid5 in 2.6.11.9 smp
References: <42959820.7090309@guerrier.com> <20050527012909.GA32085@oasissystems.com.au>
In-Reply-To: <20050527012909.GA32085@oasissystems.com.au>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First, I just realized the typo in my previous message's subject:
Should read 2.6.*11.*9 smp, instead of 2.6_.9. Sorry :|

jpearson wrote:
> Hi,
> 
> I saw this exact same error (EXT3-fs error (device dm-x): ext3_readdir:
> bad entry in directory #nnnnnnn: rec_len % 4 != 0 - offset=0, inode=xxxxxxxx,
> rec_len=...
> 
> from time to time in my non-SMP RAID system with 512Mb RAM, with ext3 on LVM on top of RAID5.
> 
> Never caused actual corruption - run FSCK, no errors, remount rw
> successfully until next time; error rarely in the same place, but always
> in a directory and rec_len % 4 != 0.  Looks like an 'in-kernel' thing,
> because (e.g.) running find on the volume after remounting rw produced
> no issues, so presumably the on-disk directory wasn't *really* the
> issue.

I confirm this here too: random place, always a dir, always 'rec_len % 4 
!= 0', no fs issue or data loss (so far...)

> Filesystems between about 8 and 50 Gb, and not what I'd characterise as a
> heavy load.

By heavy load, I mean a system load between 10 and 15 for 3 hours 
(before error) Processes running were several instances of mkisofs 
(reading from and writing to the faulty partition)

> This was with about 2.6.4 - 2.6.7.  I'm running 2.6.11 now and haven't
> seen it in some time; so it was either fixed by 2.6.11, or mounting ro
> by default has just reduced my exposure.

As my kernel is a 2.6.11.9, It is not fixed so far.

I will reformat when possible, this time I will use lvm over raid5, so I 
can use xfs for my usefull data, and keep a medium ext3 partition to 
make tests if needed (just need to know what to test)

Thanks
