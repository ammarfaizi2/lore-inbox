Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316580AbSFDIxy>; Tue, 4 Jun 2002 04:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316582AbSFDIxx>; Tue, 4 Jun 2002 04:53:53 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:22192 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S316580AbSFDIxv>;
	Tue, 4 Jun 2002 04:53:51 -0400
Date: Tue, 4 Jun 2002 10:53:36 +0200
From: Jens Axboe <axboe@suse.de>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Russell King <rmk@arm.linux.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: PATCH/RFC: fix 2.5.20 ramdisk
Message-ID: <20020604085336.GI1105@suse.de>
In-Reply-To: <20020603180627.A23056@flint.arm.linux.org.uk> <20020604083525.GA2512@suse.de> <20020604094532.A30552@flint.arm.linux.org.uk> <3CFC7226.2010101@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04 2002, Martin Dalecki wrote:
> Russell King wrote:
> >On Tue, Jun 04, 2002 at 10:35:25AM +0200, Jens Axboe wrote:
> >
> >>On Mon, Jun 03 2002, Russell King wrote:
> >>
> >>>2.5.20 seems to be incapable of executing binaries in a ramdisk-based
> >>>root filesystem.  The ramdisk in question is an ext2fs, with a 1K
> >>>block size loaded via the compressed ramdisk loader in do_mounts().
> >>>
> >>>It appears that, in the case of a 1K block sized filesystem, we attempt
> >>>to read two 512-byte sectors into a BIO vector.  The first one is copied
> >>>into the first 512 bytes.  The second sector, however, is copied over
> >>>the first 512 bytes.  Obviously not what we really want.
> >>
> >>Looks good.
> >
> >
> >Ok, rev. 2, slightly cleaned up:
> >
> >--- orig/drivers/block/rd.c	Wed May 29 21:40:26 2002
> >+++ linux/drivers/block/rd.c	Tue Jun  4 09:44:21 2002
> >@@ -144,6 +144,7 @@
> > {
> > 	struct address_space * mapping;
> > 	unsigned long index;
> >+	unsigned int vec_offset;
> 
> 
> Just a small nit. Shouldn't taht be size_t ?

It's just the offset into the current page.

-- 
Jens Axboe

