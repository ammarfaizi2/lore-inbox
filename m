Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263923AbUEHAl0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263923AbUEHAl0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 20:41:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263953AbUEHAlZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 20:41:25 -0400
Received: from madrid10.amenworld.com ([62.193.203.32]:29964 "EHLO
	madrid10.amenworld.com") by vger.kernel.org with ESMTP
	id S263923AbUEHAlW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 20:41:22 -0400
Date: Fri, 7 May 2004 20:21:49 +0200
From: DervishD <raul@pleyades.net>
To: Timothy Miller <miller@techsource.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Oliver Pitzeier <oliver@linux-kernel.at>, linux-kernel@vger.kernel.org
Subject: Re: Strange Linux behaviour!?
Message-ID: <20040507182149.GC380@DervishD>
Mail-Followup-To: Timothy Miller <miller@techsource.com>,
	Christoph Hellwig <hch@infradead.org>,
	Oliver Pitzeier <oliver@linux-kernel.at>,
	linux-kernel@vger.kernel.org
References: <409B4494.5253316B@melbourne.sgi.com> <013001c4340d$e9860470$d50110ac@sbp.uptime.at> <20040507093455.A27829@infradead.org> <409BC67F.4030701@techsource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <409BC67F.4030701@techsource.com>
User-Agent: Mutt/1.4.2.1i
Organization: Pleyades
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Timothy :)

 * Timothy Miller <miller@techsource.com> dixit:
> >?Have you checked whether you're out of inodes?
> What happens when Linux runs out of inodes?

    It returns ENOSPC on write operations on the filesystem.

> Why would it?

    Because you created lots of dirs and files ;)

> Doesn't it create more?

    EXT2 and EXT3 doesn't, the number of inodes is specified when doing
mke2fs and it's fixed. Don't know what happens under other
filesystems, but for me doesn't make much sense to create more
inodes: inodes themselves occupy disk space, and if you've run out of
inodes, you probable are near to run out of disk space too. Moreover,
disk structures are a bit complex and adding inodes is not an easy
task in most filesystems :?

    I've been seeing this problem lately on myself. I have a disk to
store temporarily backups and large files in general, so I formatted
it with ext2 using one inode per megabyte of data. This filesystem
usually have 10-50 files, no more, and even with 1/1MB inode ratio,
there were more than 10000 inodes. But when I accidentally
uncompressed one of the backups in the disk, I run out of inodes
*FAST*. I mean, the disk was 80% empty and I didn't have free inodes,
but this is not the common case, since usually you will have an inode
per 4kB of data, so if you don't have free inodes it will usually
mean that your disk space will exhaust soon, too. This is the common
case, I think, so it doesn't worth the effort of adding a few more
inodes just for making the agony longer ;)

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.pleyades.net & http://raul.pleyades.net/
