Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279499AbRKRNXV>; Sun, 18 Nov 2001 08:23:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279502AbRKRNXM>; Sun, 18 Nov 2001 08:23:12 -0500
Received: from fungus.teststation.com ([212.32.186.211]:3088 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S279499AbRKRNWy>; Sun, 18 Nov 2001 08:22:54 -0500
Date: Sun, 18 Nov 2001 14:17:44 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
To: Sven Vermeulen <sven.vermeulen@rug.ac.be>
cc: Linux-Kernel Development Mailinglist 
	<linux-kernel@vger.kernel.org>
Subject: Re: /sbin/mount and /proc/mounts difference
In-Reply-To: <20011118135007.A787@Zenith.starcenter>
Message-ID: <Pine.LNX.4.30.0111181401140.13487-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Nov 2001, Sven Vermeulen wrote:

> As you can see the notail-option of reiserfs isn't listed on /proc/mounts,
> but it is on "mount".
> 
> Does this have any particular reason?

mount writes everything to /etc/mtab and displays that when asked.

The kernel doesn't ask the individual filesystem "drivers" if they have
some options they would like to list there. So for /proc it simply lists
the options the VFS knows about. Except for NFS that for some reson has
code there.

I don't know if there are any plans to change that. Wouldn't be difficult
to add something to super_operations.

fs/namespace.c:
	show_vfsmnt
	show_nfs_mount

If it is important to you, you could add a "show_reiserfs_mount" by
copying how things are done for nfs.

/Urban

