Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751423AbVKIPhY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751423AbVKIPhY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 10:37:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751425AbVKIPhY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 10:37:24 -0500
Received: from 66.239.25.20.ptr.us.xo.net ([66.239.25.20]:32687 "EHLO
	zoot.lnxi.com") by vger.kernel.org with ESMTP id S1751423AbVKIPhX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 10:37:23 -0500
To: =?iso-8859-1?q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
Cc: linux-mtd@lists.infradead.org, dwmw2@infradead.org,
       linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
       Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 06/25] mtd: move ioctl32 code to mtdchar.c
References: <20051105162650.620266000@b551138y.boeblingen.de.ibm.com>
	<20051105162712.921102000@b551138y.boeblingen.de.ibm.com>
	<20051108105923.GA31446@wohnheim.fh-wedel.de>
	<m3zmofovsc.fsf@maxwell.lnxi.com>
	<20051108183339.GB31446@wohnheim.fh-wedel.de>
From: ebiederman@lnxi.com (Eric W. Biederman)
Date: Wed, 09 Nov 2005 08:37:16 -0700
In-Reply-To: <20051108183339.GB31446@wohnheim.fh-wedel.de> (
 =?iso-8859-1?q?J=F6rn_Engel's_message_of?= "Tue, 8 Nov 2005 19:33:39
 +0100")
Message-ID: <m3slu5al3n.fsf@maxwell.lnxi.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn Engel <joern@wohnheim.fh-wedel.de> writes:

> mtdchar.c is one of the worst drivers inside the kernel.  The concept
> of having a simple char device driver for flash may have its charm,
> but the actual implementation is horrible.  And things like the
> read-only devices are even unfixable.

This is a confusing statement, you complain that the implementation is horrible
and then go on to complain about the interface to the character device.

The implementation appears small and concise.   There are a couple of
FIXMEs but they are all about wishing the interface to the flash chips
mapped better to a user space interface.  I routinely fix things in
the kernel whose implementations are much worse than mtdchar. 

> Can you name a few examples, where mtdchar.c makes sense?  I've found
> it to be quite useless.

I have found just the opposite.  It happens to be the only interface
to mtd devices I use.   In general when you have flash devices small
enough that you can't use a filesystem without waisting a lot of space
(keeping 1 free erase block out of 4 or 8 is a problem).  Or when you are
doing low-level mucking mtdchar is invaluable.

As for the interface to mtdchar.  I agree that the readonly character
device is silly, and does weird things to the mtd device minor numbers.
I agree that ioctls are not the prettiest interface around, however
the raw functionality the ioctls export is needed, and interesting.  Some
of the functionality would be hard to export even in sysfs the cool ascii
replacement for ioctl.

Long term it does look like a sysfs interface to the mtd functionality
could suffice.

Eric
