Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265151AbTL2UAq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 15:00:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265130AbTL2T6i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 14:58:38 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4739 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265132AbTL2T5q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 14:57:46 -0500
Date: Mon, 29 Dec 2003 19:57:42 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Mariusz Mazur <mmazur@kernel.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Should struct inode be made available to userspace?
Message-ID: <20031229195742.GL4176@parcelfarce.linux.theplanet.co.uk>
References: <200312292040.00409.mmazur@kernel.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200312292040.00409.mmazur@kernel.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 29, 2003 at 08:40:00PM +0100, Mariusz Mazur wrote:
> Inside __KERNEL__ block in linux/fs.h there is a definition (looks rather 
> kernel specific) of struct inode. This structure is used all over the 
> headers, specificaly in ${fsname}_fs_i.h files containing 
> ${fsname}_inode_info structures. The problem is ${fsname}_fs_i.h files are  
> included in ${fsname}_fs.h files which in turn are often used by various 
> programs. This results in compile time errors since normal programs don't 
> define __KERNEL__ (they shouldn't) and thus while parsing 
> ${fsname}_inode_info structures do not have access to the inode structure 
> ("error: field `vfs_inode' has incomplete type").
> What is the complete, politicaly correct solution? (workarounds are of no use 
> to me)
> Is it (a) struct inode should be made available to userspace (yuck), (b) no 
> !kernel code should use struct inode (linux/${fsname}_fs_i.h files shouldn't 
> be included anywhere... hell... maybe all linux/${fsname}* files shouldn't be 
> available outside kernel!) or (c) this kind of structures should come with 
> apps using it and not be a part of any kernel derived userspace headers.

struct inode and structures containing it should not be used outside of kernel.
Moreover, foo_fs.h should be seriously trimmed down and everything _not_
useful outside of kernel should be taken into fs/foo/*; other kernel code
also doesn't give a fsck for that stuff, so it should be private to filesystem
instead of polluting include/linux/*.
