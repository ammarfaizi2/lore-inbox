Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751251AbVLLOjl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251AbVLLOjl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 09:39:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751265AbVLLOjl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 09:39:41 -0500
Received: from mx1.redhat.com ([66.187.233.31]:36585 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751251AbVLLOjk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 09:39:40 -0500
From: David Howells <dhowells@redhat.com>
To: nathans@sgi.com, hch@infradead.org
cc: linux-xfs@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: XFS accessing arch-specific structures
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
Date: Mon, 12 Dec 2005 14:39:12 +0000
Message-ID: <25190.1134398352@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Nathan,

I've got a problem in which XFS is accessing arch-specific structures, and
thus requiring those structures to conform to its ideals. Specifically, it's
trying to read the counter using atomic_read(), whether or not this is
possible:

    fs/xfs/linux-2.6/sema.h:
    #define valusema(sp)			(atomic_read(&(sp)->count))

    compile log:

      CC      fs/xfs/xfs_inode.o
      CC      fs/xfs/xfs_inode_item.o
    fs/xfs/xfs_inode_item.c: In function `xfs_inode_item_pushbuf':
    fs/xfs/xfs_inode_item.c:803: error: structure has no member named `count'
    fs/xfs/xfs_inode_item.c:825: error: structure has no member named `count'

Can you fix this please? This will not compile with all archs.

I'm told that Christoph Hellwig may have an idea or a patch that might provide
a fix. If it's necessary to get the count on the semaphore (which it might
be), then you should add a function to each asm/semaphore.h to retrieve it and
use that.

David
