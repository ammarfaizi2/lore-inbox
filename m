Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263772AbRFCVFJ>; Sun, 3 Jun 2001 17:05:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263754AbRFCUj1>; Sun, 3 Jun 2001 16:39:27 -0400
Received: from hera.cwi.nl ([192.16.191.8]:11212 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S263753AbRFCUjI>;
	Sun, 3 Jun 2001 16:39:08 -0400
Date: Sun, 3 Jun 2001 22:38:29 +0200 (MET DST)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200106032038.WAA184171.aeb@vlet.cwi.nl>
To: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, viro@math.psu.edu
Subject: mount --bind accounting
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Something entirely different.

Last year I added the comment
	/* No capabilities? What if users do thousands of these? */
in super.c for "mount --bind".
Now that I do some polishing there I noticed the comment again.

Each bind does an alloc_vfsmnt() and hence takes some kernel memory.
Any user can therefore take all kernel memory, until
	kmalloc(sizeof(struct vfsmount), GFP_KERNEL)
fails. Bad security.
I suppose something needs to be done about that.

Invent an arbitrary limit
	#define MAX_NUMBER_OF_USER_BINDS 666
and refuse the "mount --bind" when inspection of the mnt_owner fields
of the entries in the vfsmntlist shows that this user already has
too many mounts?

Andries
