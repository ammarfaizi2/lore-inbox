Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262272AbVBVLyy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262272AbVBVLyy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 06:54:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262273AbVBVLyx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 06:54:53 -0500
Received: from smtp2.rz.tu-harburg.de ([134.28.205.13]:63574 "EHLO
	smtp2.rz.tu-harburg.de") by vger.kernel.org with ESMTP
	id S262272AbVBVLyt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 06:54:49 -0500
Message-ID: <1109073273.421b1d7923204@webmail.tu-harburg.de>
Date: Tue, 22 Feb 2005 12:54:33 +0100
From: Jan Blunck <j.blunck@tu-harburg.de>
To: Alex Tomas <alex@clusterfs.com>
Cc: Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC] pdirops: vfs patch
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alex Tomas <alex@clusterfs.com>:

>
> 1) i_sem protects dcache too

Where? i_sem is the per-inode lock, and shouldn't be used else.

> 2) tmpfs has no "own" data, so we can use it this way (see 2nd patch)
> 3) I have pdirops patch for ext3, but it needs some cleaning ...

I think you didn't get my point.

1) Your approach is duplicating the locking effort for regular filesystem
(like ext2):
a) locking with s_pdirops_sems
b) locking the low-level filesystem data
It's cool that it speeds up tmpfs, but I don't think that this legatimate the
doubled locking for every other filesystem.
I'm not sure that it also increases performance for regular filesystems, if you
do the locking right.

2) In my opinion, a superblock-wide semaphore array which allows 1024
different (different names and different operations) accesses to ONE single
inode (which is the data it should protect) is not a good idea.

Jan
