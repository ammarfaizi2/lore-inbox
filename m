Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310399AbSCGQ04>; Thu, 7 Mar 2002 11:26:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310392AbSCGQ0s>; Thu, 7 Mar 2002 11:26:48 -0500
Received: from [195.63.194.11] ([195.63.194.11]:22277 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S310389AbSCGQ0i>; Thu, 7 Mar 2002 11:26:38 -0500
Message-ID: <3C879471.8060106@evision-ventures.com>
Date: Thu, 07 Mar 2002 17:25:21 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Ben Clifford <benc@hawaga.org.uk>
CC: Dave Jones <davej@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.5-dj3 - ide_fops
In-Reply-To: <Pine.LNX.4.33.0203061648330.2886-100000@barbarella.hawaga.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Clifford wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> 
> Here's another one.
> 
> 2.5.5-dj3 removes EXPORT_SYMBOL(ide_fops)
> 
> but doesn't remove ide_fops from the code.
> 
> Hence modprobe ide-cd doesn't work.
>

Wow! I have found the following in ide-cd.c


	devinfo->de = devfs_register(drive->de, "cd", DEVFS_FL_DEFAULT,
				     HWIF(drive)->major, minor,
				     S_IFBLK | S_IRUGO | S_IWUGO,
				     ide_fops, NULL);

So in fact we are devfs_registering the ide-cd rom driver *twice*.
The proper resolution will most propably be to remove this info
there and to use this only in ide.c.

