Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261959AbVADBF7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261959AbVADBF7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 20:05:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261472AbVADBD7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 20:03:59 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:19612 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261965AbVACX2t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 18:28:49 -0500
Subject: Re: FAT, NTFS, CIFS and DOS attributes
From: Nicholas Miell <nmiell@comcast.net>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: sfrench@samba.org, linux-ntfs-dev@lists.sourceforge.net,
       samba-technical@lists.samba.org, aia21@cantab.net,
       hirofumi@mail.parknet.co.jp,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <41D9C635.1090703@zytor.com>
References: <41D9C635.1090703@zytor.com>
Content-Type: text/plain
Date: Mon, 03 Jan 2005 15:28:45 -0800
Message-Id: <1104794925.3604.39.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3.njm.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-01-03 at 14:24 -0800, H. Peter Anvin wrote:
> Hello all,
> 
> I recently posted to LKML a patch to get or set DOS attribute flags for 
> fatfs.  That patch used ioctl().  It was suggested that a better way 
> would be using xattrs, although the xattr mechanism seems clumsy to me, 
> and has namespace issues.
> 
> I also think it would be good to have a unified interface for FAT, NTFS 
> and CIFS for these attributes.
> 
> I noticed that CIFS has a placeholder "user.DosAttrib" in cifs/xattr.c, 
> although it doesn't seem to be implemented.
> 
> Questions:
> 
> a) is xattr the right thing?  It seems to be a fairly complex and 
> ill-thought-out mechanism all along, especially the whole namespace 
> business (what is a system attribute to one filesystem is a user 
> attribute to another, for example.)

More importantly, what has a defined meaning for one filesystem and is
interpreted and generated on demand by the kernel is irrelevant or
unsupported on other filesystems.

So, yes, you can't just copy a bunch of files from vfat to ext3 and
preserve the vfat attributes, but you should be able to stuff a bunch of
vfat files into a tar file and then restore them to a vfat filesystem
with all their original attributes intact.

> b) if xattr is the right thing, shouldn't this be in the system 
> namespace rather than the user namespace?

Yes.

> c) What should the representation be?  Binary byte?  String containing a 
> subset of "rhsvda67" (barf)?

ASCII strings require no special tools to manipulate from shell scripts
(or even for the end user to interpret).

-- 
Nicholas Miell <nmiell@comcast.net>

