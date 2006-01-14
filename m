Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423218AbWANASW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423218AbWANASW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 19:18:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423219AbWANASW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 19:18:22 -0500
Received: from [62.38.115.213] ([62.38.115.213]:41926 "EHLO pfn3.pefnos")
	by vger.kernel.org with ESMTP id S1423218AbWANASW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 19:18:22 -0500
From: "P. Christeas" <p_christ@hol.gr>
To: Christoph Hellwig <hch@lst.de>, "lkml, " <linux-kernel@vger.kernel.org>
Subject: Regression in Autofs, 2.6.15-git
Date: Sat, 14 Jan 2006 02:17:55 +0200
User-Agent: KMail/1.9
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601140217.56724.p_christ@hol.gr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had been testing some other thing in the kernel, when I noticed that the 
commit (in Linus' tree) given below makes *autofs4* crash.
It does crash with a hard oops whenever I try to enter a /net/host/... address 
in konqueror's location bar.
Is this a known issue or should I provide more information?


commit fc33a7bb9c6dd8f6e4a014976200f8fdabb3a45c
Author: Christoph Hellwig <hch@lst.de>
Date:   Mon Jan 9 20:52:17 2006 -0800

    [PATCH] per-mountpoint noatime/nodiratime

    Turn noatime and nodiratime into per-mount instead of per-sb flags.

    After all the preparations this is a rather trivial patch.  The mount code
    needs to treat the two options as per-mount instead of per-superblock, and
    touch_atime needs to be changed to check the new MNT_ flags in addition to
    the MS_ flags that are kept for filesystems that are always
    noatime/nodiratime but not user settable anymore.  Besides that core code
    only nfs needed an update because it's leaving atime updates to the server
    and thus sets the S_NOATIME flag on every inode, but needs to know whether
    it's a real noatime mount for an getattr optimization.

    While we're at it I've killed the IS_NOATIME/IS_NODIRATIME macros that 
were
    only used by touch_atime.
