Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269580AbRHHWGr>; Wed, 8 Aug 2001 18:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269583AbRHHWGi>; Wed, 8 Aug 2001 18:06:38 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:37528 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S269580AbRHHWGT>; Wed, 8 Aug 2001 18:06:19 -0400
Date: Thu, 9 Aug 2001 01:06:01 +0300
From: Ville Herva <vherva@mail.niksula.cs.hut.fi>
To: =?iso-8859-1?Q?Samuli_K=E4rkk=E4inen?= <skarkkai@woods.iki.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Wrong free inodes count in kernels 2.0 and 2.2
Message-ID: <20010809010601.A63773@niksula.cs.hut.fi>
In-Reply-To: <20010502194621.D22433@woods.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010502194621.D22433@woods.iki.fi>; from skarkkai@woods.iki.fi on Wed, May 02, 2001 at 07:46:21PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 02, 2001 at 07:46:21PM +0300, [Samuli Kärkkäinen] claimed:
> I get repeatably both in 2.0 and 2.2 serieses of kernels the following kind
> of errors:
> 
> 2.2 kernels (several, including 2.2.18):
>   EXT2-fs error (device ide1(22,6)): ext2_check_inodes_bitmap: Wrong free inodes count in group 768, stored = 984, counted = 717
>   EXT2-fs error (device ide1(22,6)): ext2_check_inodes_bitmap: Wrong free inodes count in group 769, stored = 1005, counted = 717
>   EXT2-fs error (device ide1(22,6)): ext2_check_inodes_bitmap: Wrong free inodes count in group 777, stored = 998, counted = 901
>   [ many similar lines deleted ]
> 
> and sometimes with 2.2 kernel, soon after the errors above:
>   EXT2-fs error (device ide1(22,1)): ext2_new_inode: Free inodes count corrupted in group 414 
>   last message repeated 795 times

I get these messages as well on 2.2.18pre19:

EXT2-fs error (device md(9,0)): ext2_new_inode: Free inodes count
corrupted in group 501                                                                  
EXT2-fs error (device md(9,0)): ext2_new_inode: Free inodes count
corrupted in group 501                                                                  

I've applied ide, raid and ext2compr patches. While they sound like strong
suspects for they cause of the problem (the fs in question is on ide,
softraid 1 and is ext2compr'ed), I understand Samuli sees these messages on
a stock kernel (ide and scsi), which makes me suspect this is a core kernel
issue.

I've been running fairly heavy rsync backups onto the fs in question for
more than a year, and only now I have begun to get these errors.

> problem always comes back. The backup script is essentially like this:
> 
> following night second differential:
>   cp -al /backup/backup2 /backup/backup3
>   rsync --archive --hard-links --whole-file --sparse --one-file-system --delete --force / /backup/backup3

My backup script is a tad different, but the principle is the same: do an
initial snapshot, then cp -al it as the next day's snapshot and rsync the new
snapshot up to date. This of course introduces huge number of dir entries
and lots of inodes with big hard link counts.

BTW: What happens if the hard link count for an inode overflows? 


-- v --

v@iki.fi
