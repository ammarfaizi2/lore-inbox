Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277782AbRJ1IZZ>; Sun, 28 Oct 2001 03:25:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277804AbRJ1IZQ>; Sun, 28 Oct 2001 03:25:16 -0500
Received: from pasuuna.fmi.fi ([193.166.211.17]:53266 "EHLO pasuuna.fmi.fi")
	by vger.kernel.org with ESMTP id <S277782AbRJ1IY4>;
	Sun, 28 Oct 2001 03:24:56 -0500
From: Kari Hurtta <hurtta@leija.mh.fmi.fi>
Message-Id: <200110280825.f9S8PROO004923@leija.fmi.fi>
Subject: Re: Virtual(?) kernel root
In-Reply-To: <20011026215939.A13222@polynum.org>
To: Thierry Laronde <tlaronde@polynum.com>
Date: Sun, 28 Oct 2001 10:25:27 +0200 (EET)
CC: linux-kernel@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL95a (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
X-Filter: pasuuna: 2 received headers rewritten with id 20011028/09015/01
X-Filter: pasuuna: ID 4118, 1 parts scanned for known viruses
X-Filter: leija.fmi.fi: ID 23594, 1 parts scanned for known viruses
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<...>
> The key point is in fact that there is the idea of a virtual kernel
> root, with some pseudo fs already set:
> 
> /
> |
> --/dev
> |
> --/kbin
> |
> --/proc
> 
> The "kernel" can be used via an interface that could be, for example, a
> simple interface for debugging purpose, or a simple interface to change
> the boot parameters.
> 
> Supplementary resources can be mounted on the kernel root (what is
> called "root fs") with the difference that the kernel root virtual fs
> stays always _on top_ : non kernel root fs don't mask the only root (the
> kernel one), they just add resources to the root directory.
> 
> The advantages? 
> 
> There is no more root problem for kernel threads, since
> kernel threads run with the reference of the inchanged kernel root, the
> common "root fs" being simply mounted or unmounted. No more "sliding
> carpet" problem.
> 
> One can test or question the kernel via a simple interface for debugging
> purposes. Not mounting supplementary resources doesn't create a panic,
> but leave a bare bones kernel, giving for example the choice to the user
> to give boot parameters.
> 
> The /dev (this is already the case with devfs) doesn't prevent from
> mounting the "root" ro (for example when syslog tries to access a device
> file created at run time).
> 
> Has an equivalent scheme being already discussed?

On linux/fs/namespace.c there is following comment: (from linux 2.4.12)

/*
 * Absolutely minimal fake fs - only empty root directory and nothing else.
 * In 2.5 we'll use ramfs or tmpfs, but for now it's all we need - just
 * something to go with root vfsmount.
 */
<...>
static DECLARE_FSTYPE(root_fs_type, "rootfs", rootfs_read_super, FS_NOMOUNT);
 

But I do not think that that comment refers to equivalent scheme
than what you are proposing.

-- 
          /"\                           |  Kari 
          \ /     ASCII Ribbon Campaign |    Hurtta
           X      Against HTML Mail     |
          / \                           |
