Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262538AbUFJTPE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262538AbUFJTPE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 15:15:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262459AbUFJTPE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 15:15:04 -0400
Received: from sweetums.bluetronic.net ([24.199.150.42]:752 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id S262538AbUFJTNk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 15:13:40 -0400
Date: Thu, 10 Jun 2004 15:07:12 -0400 (EDT)
From: Ricky Beam <jfbeam@bluetronic.net>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: Serial ATA (SATA) on Linux status report (2.6.x mainstream plan
 for AHCI and iswraid??)
In-Reply-To: <40C8A5F6.3030002@pobox.com>
Message-ID: <Pine.GSO.4.33.0406101452220.14297-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jun 2004, Jeff Garzik wrote:
>Have you tried Carl-Daniel's raiddetect?  2.6 does not include
>ataraid-based drivers, preferred a Device Mapper (DM) approach instead.

Have you looked at it lately?  It's a nice start but far from finished.
It will not build an array or tell you how to build one yourself.  (Yet)
And it's completely userland (part of udev) so it's a complicated
initrd-required path.

If you can read code (lkml... I'll assume everyone can), the header files
provide the on-disk metadata, so you can figure out the appropriate dm table
and/or mdadm config to get the job done.  For example:
  mdadm --build /dev/md/d0 --chunk=16 --level=0 --raid-devices=4 /dev/sd[abcd]
or a dm-table:
  0 1250327228 striped 4 32 /dev/sda 0 /dev/sdb 0 /dev/sdc 0 /dev/sdd 0
works for me (4x160G SATA drives on a SI3114 in raid0 mode.)  The same
md setup can be done via the kernel cmdline to boot into the array.
However, there aren't any code pieces in the kernel for reading any of
the various ataraid metadata formats and setting things up. (again, /yet/)

--Ricky

PS: Only the "dm" version is 100% safe.  /dev/md/d0 exposes the entire
    disk, metadata sectors included.


