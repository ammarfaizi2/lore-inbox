Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932295AbVHSV0r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932295AbVHSV0r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 17:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932302AbVHSV0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 17:26:47 -0400
Received: from anchor-post-33.mail.demon.net ([194.217.242.91]:13833 "EHLO
	anchor-post-33.mail.demon.net") by vger.kernel.org with ESMTP
	id S932295AbVHSV0q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 17:26:46 -0400
Message-ID: <43064E46.3040706@lougher.demon.co.uk>
Date: Fri, 19 Aug 2005 22:25:26 +0100
From: Phillip Lougher <phillip@lougher.demon.co.uk>
User-Agent: Mozilla Thunderbird 0.8 (X11/20041012)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Johnson <djohnson+linux-kernel@sw.starentnetworks.com>
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fix cramfs making duplicate entries in inode cache
References: <17158.15932.939201.786982@cortez.sw.starentnetworks.com>
In-Reply-To: <17158.15932.939201.786982@cortez.sw.starentnetworks.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Johnson wrote:

> 
> Patch below fixes this by making get_cramfs_inode() use the inode
> cache before blindly creating a new entry every time.  This eliminates
> the duplicate inodes and duplicate buffer cache.
> 
 > +	struct inode * inode = iget_locked(sb, CRAMINO(cramfs_inode));

Doesn't iget_locked() assume inode numbers are unique?

In Cramfs inode numbers are set to 1 for non-data inodes (fifos, 
sockets, devices, empty directories), i.e

%stat device namedpipe
   File: `device'
   Size: 0               Blocks: 0          IO Block: 4096   character 
special file
Device: 700h/1792d      Inode: 1           Links: 1     Device type: 1,1
Access: (0644/crw-r--r--)  Uid: (    0/    root)   Gid: (    0/    root)
Access: 1970-01-01 01:00:00.000000000 +0100
Modify: 1970-01-01 01:00:00.000000000 +0100
Change: 1970-01-01 01:00:00.000000000 +0100
   File: `namedpipe'
   Size: 0               Blocks: 0          IO Block: 4096   fifo
Device: 700h/1792d      Inode: 1           Links: 1
Access: (0644/prw-r--r--)  Uid: (    0/    root)   Gid: (    0/    root)
Access: 1970-01-01 01:00:00.000000000 +0100
Modify: 1970-01-01 01:00:00.000000000 +0100
Change: 1970-01-01 01:00:00.000000000 +0100

Should iget5_locked() be used here?

Phillip
