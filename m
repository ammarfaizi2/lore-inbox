Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290157AbSBFHBq>; Wed, 6 Feb 2002 02:01:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290184AbSBFHBj>; Wed, 6 Feb 2002 02:01:39 -0500
Received: from [63.231.122.81] ([63.231.122.81]:38990 "EHLO lynx.adilger.int")
	by vger.kernel.org with ESMTP id <S290157AbSBFHB0>;
	Wed, 6 Feb 2002 02:01:26 -0500
Date: Wed, 6 Feb 2002 00:01:13 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Jim Lu <jiml789@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux Ext2 Inode question
Message-ID: <20020206000113.K2928@lynx.turbolabs.com>
Mail-Followup-To: Jim Lu <jiml789@hotmail.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <F42jlQ0txV6JpoA7p590000e5a6@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <F42jlQ0txV6JpoA7p590000e5a6@hotmail.com>; from jiml789@hotmail.com on Tue, Feb 05, 2002 at 08:02:29PM -0800
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 05, 2002  20:02 -0800, Jim Lu wrote:
> I have a question regarding the inode number on the EXT2 filesystem. If I 
> get a Inode number, is there a way I can calculate the block address (with 
> respect to the filesystem) on this inode base on the inode number?

Yes.  This is done in several places in the ext2 kernel sources, like
ext2_read_inode().  Note that it is not a simple calculation, because
the position of the inode table can (although generally does not) vary
on a per-group basis.  On a cold cache, you would need to do 2 reads
to calculate the inode block location (superblock + group descriptor).

> Also, I remember reading somewhere that not all the EXT2 block groups have 
> superblock information. So would the beginning of those block group look 
> like this " group descriptor | block bitmap | inode bitmap | inode table | 
> data " ? And, could someone please tell me which block groups have 
> superblock info.

On a "sparse superblock" filesystem, superblock and group descriptor
backups are kept in groups 0 and those numbered 3^n, 5^n, 7^n, where
n is an integer.  So, 0, 1, 3, 5, 7, 9, 15, 25, 27.

Groups that do not have backups generally will contain the block bitmap,
inode bitmap, inode table, and data.  However, the actual position will
be given in the group descriptor table.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

