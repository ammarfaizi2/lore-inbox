Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261204AbVBGIrR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261204AbVBGIrR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 03:47:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261242AbVBGIrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 03:47:17 -0500
Received: from ojjektum.uhulinux.hu ([62.112.194.64]:58277 "EHLO
	ojjektum.uhulinux.hu") by vger.kernel.org with ESMTP
	id S261204AbVBGIrN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 03:47:13 -0500
Date: Mon, 7 Feb 2005 09:47:09 +0100
From: =?iso-8859-1?Q?Pozs=E1r_Bal=E1zs?= <pozsy@uhulinux.hu>
To: Nuno Monteiro <nuno@itsari.org>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: msdos/vfat defaults are annoying
Message-ID: <20050207084709.GA30680@ojjektum.uhulinux.hu>
References: <4205AC37.3030301@comcast.net> <20050206070659.GA28596@infradead.org> <20050206232108.GA31813@ojjektum.uhulinux.hu> <20050207003610.GP8859@parcelfarce.linux.theplanet.co.uk> <20050207004218.GA12541@ojjektum.uhulinux.hu> <20050207024800.GA18010@hobbes.itsari.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050207024800.GA18010@hobbes.itsari.int>
User-Agent: Mutt/1.5.7i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2005 at 02:48:00AM +0000, Nuno Monteiro wrote:
> 
> On 2005.02.07 00:42, Pozsár Balázs wrote:
> >On Mon, Feb 07, 2005 at 12:36:10AM +0000, Al Viro wrote:
> >> On Mon, Feb 07, 2005 at 12:21:08AM +0100, Pozsar Balazs wrote:
> >> > On Sun, Feb 06, 2005 at 07:06:59AM +0000, Christoph Hellwig wrote:
> >> > > filesystem detection isn't handled at the kerne level.
>        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

> But since filesystem detection isn't handled in the kernel, changing the  
> link order is pointless. Please fix your /etc/filesystems instead.

But the contents of /proc/filesystems comes from the kernel. And the 
order of filesystems comes from the link order.

Let me show you, why it is _not_ pointless:
If you do not have /etc/filesystems, mount will read /proc/filesystems:

# strace -o mount.trace mount -t auto /dev/sda1 /mnt
# grep filesystems mount.trace
open("/etc/filesystems", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
open("/proc/filesystems", O_RDONLY|O_LARGEFILE) = 3
# grep ^mount mount.trace
mount("/dev/sda1", "/mnt", "squashfs", 0xc0ed0000, 0) = -1 EINVAL (Invalid argument)
mount("/dev/sda1", "/mnt", "vfat", 0xc0ed0000, 0) = 0

See? I _have_ that patch applied, that's why it tried vfat and not msdos 
first.

Granted, I could override the default order by using a /etc/filesystems 
file. But the kernel should have a much more sane default on its own, 
namely "try vfat before msdos".



-- 
pozsy
