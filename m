Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261868AbVCSV62@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261868AbVCSV62 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 16:58:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261869AbVCSV62
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 16:58:28 -0500
Received: from host.almesberger.net ([204.10.140.10]:10002 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S261868AbVCSV6H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 16:58:07 -0500
Date: Sat, 19 Mar 2005 18:54:58 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Andries Brouwer <Andries.Brouwer@cwi.nl>
Cc: torvalds@osdl.org, akpm@osdl.org, bon@elektron.ikp.physik.tu-darmstadt.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] partitions/msdos.c
Message-ID: <20050319185458.B17469@almesberger.net>
References: <20050226213459.GA21137@apps.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050226213459.GA21137@apps.cwi.nl>; from Andries.Brouwer@cwi.nl on Sat, Feb 26, 2005 at 10:35:00PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer wrote:
> In other words, we need the user space command `partition',
> where "partition -t dos /dev/sda" reads a DOS-type partition
> table.

So if you e.g. hotplug a new device, its partitions won't be
accessible before you (or some hotplug manager, etc.) run
"partition" ?

> The two variants are: (i) partition tells the kernel
> to do the partition table reading, and (ii) partition uses partx
> to read the partition table and tells the kernel one-by-one
> about the partitions found this way.

I guess, once you've reached the point where the kernel is
unable to find partitions without user-space help, you may
as well do everything in user space.

> Since this is a fundamental change,

Pretty much, yes. Except for a few embedded systems (*), this
would mark the end of kernels that can do anything useful
without initrd or initramfs.

(*) Oh, regarding the other exception, ceterum censeo nfsroot
    esse delendam.

> a long transition period
> is needed, and that period could start with a kernel boot parameter
> telling the kernel not to do partition table parsing on a particular
> disk, or a particular type of disks, or all disks.

... and allow "partition" to override partitions previously
auto-detected by the kernel. That way, you can phase in
"partition" without needing to change your kernel setup.

Besides, the ability to correct past mistakes would also be
useful if auto-detection from user space yields garbage.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
