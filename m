Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262276AbVBVMGD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262276AbVBVMGD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 07:06:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262277AbVBVMGD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 07:06:03 -0500
Received: from [83.102.214.158] ([83.102.214.158]:6312 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S262276AbVBVMFz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 07:05:55 -0500
X-Comment-To: Jan Blunck
To: Jan Blunck <j.blunck@tu-harburg.de>
Cc: Alex Tomas <alex@clusterfs.com>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC] pdirops: vfs patch
References: <1109073273.421b1d7923204@webmail.tu-harburg.de>
From: Alex Tomas <alex@clusterfs.com>
Organization: HOME
Date: Tue, 22 Feb 2005 15:04:06 +0300
In-Reply-To: <1109073273.421b1d7923204@webmail.tu-harburg.de> (Jan Blunck's
 message of "Tue, 22 Feb 2005 12:54:33 +0100")
Message-ID: <m3vf8kx0ll.fsf@bzzz.home.net>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Jan Blunck (JB) writes:

 >> 1) i_sem protects dcache too

 JB> Where? i_sem is the per-inode lock, and shouldn't be used else.

read comments in fs/namei.c:read_lookup()

 >> 2) tmpfs has no "own" data, so we can use it this way (see 2nd patch)
 >> 3) I have pdirops patch for ext3, but it needs some cleaning ...

 JB> I think you didn't get my point.

 JB> 1) Your approach is duplicating the locking effort for regular filesystem
 JB> (like ext2):
 JB> a) locking with s_pdirops_sems
 JB> b) locking the low-level filesystem data
 JB> It's cool that it speeds up tmpfs, but I don't think that this legatimate the
 JB> doubled locking for every other filesystem.
 JB> I'm not sure that it also increases performance for regular filesystems, if you
 JB> do the locking right.

we've already done this for ext3. it works.
it speeds some loads up significantly.
especially on big directories.
and you can control this via mount option,
so almost zero cost for fs that doesn't support pdirops.

 JB> 2) In my opinion, a superblock-wide semaphore array which allows 1024
 JB> different (different names and different operations) accesses to ONE single
 JB> inode (which is the data it should protect) is not a good idea.

yes, it has some weakness, i'm reworking vfs patch to avoid inter-inode
collisions.

thanks, Alex

