Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315416AbSFEMfY>; Wed, 5 Jun 2002 08:35:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315419AbSFEMfX>; Wed, 5 Jun 2002 08:35:23 -0400
Received: from meg.hrz.tu-chemnitz.de ([134.109.132.57]:14085 "EHLO
	meg.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S315416AbSFEMfW>; Wed, 5 Jun 2002 08:35:22 -0400
Date: Wed, 5 Jun 2002 13:10:46 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Hans-Christian Armingeon <linux.johnny@gmx.net>
Cc: Andreas Dilger <adilger@clusterfs.com>, Andrew Morton <akpm@zip.com.au>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [rfc] "laptop mode"
Message-ID: <20020605131046.S681@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <3CFD453A.B6A43522@zip.com.au> <20020604233124.GA18668@turbolinux.com> <200206051340.47261.root@johnny>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 05, 2002 at 01:41:28PM +0200, Hans-Christian Armingeon wrote:
> What parts of the filesystem needs to be accessed very often? I
> think, that placing var on a ramdisk, that is mirrored on the
> hd and is synced every 30 minutes, would be a good solution.
> I think, that we should add a sysrq key to save the ramdisk to
> the disk. Is there a similar project, that loads an image into
> a ramdisk at mount, and writes it back at unmount?

It's all there already. Just killall -STOP kupdated, use
sys_readahead() to read your often needed files into pagecache
and SysRq+S to sync, if needed.

Your solution involves copying things twice and using memory
twice, so it is not the right approach.

Andrews point was to control flushing by the power state of the
ide device.

Regards

Ingo Oeser
-- 
Science is what we can tell a computer. Art is everything else. --- D.E.Knuth
