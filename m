Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261778AbUBYWjq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 17:39:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261647AbUBYWgn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 17:36:43 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:32875 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S261774AbUBYWgC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 17:36:02 -0500
Date: Thu, 26 Feb 2004 09:34:28 +1100
From: Nathan Scott <nathans@sgi.com>
To: Nico Schottelius <nico-kernel@schottelius.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: another hard disk broken or xfs problems?
Message-ID: <20040225223428.GD640@frodo>
References: <20040225220051.GA187@schottelius.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040225220051.GA187@schottelius.org>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 25, 2004 at 11:00:51PM +0100, Nico Schottelius wrote:
> Hello!
> 
> I am now using a brand new 40GB Hitachi hard disk for my notebook and
> today I got the first problems:
> 
> 
> Starting XFS recovery on filesystem: hda3 (dev: hda3)
> Ending XFS recovery on filesystem: hda3 (dev: hda3)
> VFS: Mounted root (xfs filesystem) readonly.
> Mounted devfs on /dev
> Freeing unused kernel memory: 156k freed
> XFS mounting filesystem hda1
> Starting XFS recovery on filesystem: hda1 (dev: hda1)
> Ending XFS recovery on filesystem: hda1 (dev: hda1)
> XFS mounting filesystem loop0
> Starting XFS recovery on filesystem: loop0 (dev: loop0)
> XFS internal error XFS_WANT_CORRUPTED_GOTO at line 1589 of file fs/xfs/xfs_alloc.c.  Caller 0xc0198272
> Call Trace: [<c0197151>]  [<c0198272>]  [<c0198272>]  [<c01c7fff>]  [<c01ee628>]  [<c01e5286>]  [<c01e5355>]  [<c01e6b04>]  [<c01d24fa>]  [<c01dd2cc>]  [<c01e83bd>]  [<c0203c60>]  [<c01d908f>]  [<c01f02c6>]  [<c02048e3>]  [<c02046c8>]  [<c0215517>]  [<c0185764>]  [<c015c835>]  [<c015c268>]  [<c0204890>]  [<c0204630>]  [<c015c4af>]  [<c0171ee8>]  [<c01721f4>]  [<c0172044>]  [<c01725ef>]  [<c010b34b>] 
> Ending XFS recovery on filesystem: loop0 (dev: loop0)
> Adding 192772k swap on /dev/discs/disc0/part2.  Priority:-1 extents:1
> 
> 
> I got this after a clean shutdown. Just tell me it's an xfs error and my
> harddisk is fine...

Filesystem recovery doesn't run after a clean shutdown...
the "Starting/Ending XFS recovery" messages indicate that
all of your filesystems were not unmounted by the look of
it.

Probably file data for the file backing your loopback device
has been lost/corrupted due to what looks like an "abrupt" end
before reboot (only metadata is journalled), and hence trying
to recover the loop device is going horribly wrong.

So, doesn't look like a hard disk error to me, and nor does it
look like an XFS problem.  You should be able to run xfs_repair
on your loopback file to fix the problem.

cheers.

-- 
Nathan
