Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262536AbVBBOQU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262536AbVBBOQU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 09:16:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262313AbVBBOPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 09:15:49 -0500
Received: from alog0535.analogic.com ([208.224.223.72]:16768 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262571AbVBBOOj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 09:14:39 -0500
Date: Wed, 2 Feb 2005 09:14:53 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Vineet Joglekar <vintya@excite.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>,
       linux-c-programming@vger.kernel.org
Subject: Re: when and where shall I encrypt dentry?
In-Reply-To: <20050202134901.9926C3E12@xprdmailfe6.nwk.excite.com>
Message-ID: <Pine.LNX.4.61.0502020905330.16140@chaos.analogic.com>
References: <20050202134901.9926C3E12@xprdmailfe6.nwk.excite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The correct place to encrypt or decrypt ANYTHING is
just before access to the "outside" world, i.e., in the
case of a file-system, the reads and writes to the
storage device (disk drive). You are in a world of
hurt if you intend to encrypt 'data' and directories
separately.

If you need to use an existing file-system and then
encrypt it, you use the same technique but your
"storage device" is a "container file" that you mount
using the loop device. This allows you to have an
encrypted file-system below some mount-point and
a normal file-system above.

FYI, there are existing tools/code that allow one to
mount an encrypted file-system. Perhaps your masters
project just got easier?


On Wed, 2 Feb 2005, Vineet Joglekar wrote:

>
> Hi all,
>
> I am trying to add some cryptographic functionality to ext2 file system for my masters project. I am working with kernel 2.4.21
>
> Along with regular files, I intend to encrypt directory contents too. For reading I guess the function ext2_get_page in fs/ext2/dir.c is used. Hence I can put my decryption routine in that function. Is that correct?
>
> I was trying to look for the routine which writes the dentry on disk, but was unable to find it. I found out that the function d_instantiate is used to fill in inode information for a dentry, but unable to see when it is written on disk. I suppose that I have to encrypt the dentry just before writing on to the disk, as if i encrypt it before, other functions using it wont be able to access until they decrypt. So please help me with this, that when and where shall I encrypt the directory contents.
>
> Thanks and regards,
>
> Vineet
>
> _______________________________________________
> Join Excite! - http://www.excite.com
> The most personalized portal on the Web!
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
