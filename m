Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965043AbWECAAh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965043AbWECAAh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 20:00:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965046AbWECAAg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 20:00:36 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:48118 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S965043AbWECAAg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 20:00:36 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: "Jared Hulbert" <jaredeh@gmail.com>
Subject: Re: [RFC] Advanced XIP File System
Date: Wed, 3 May 2006 02:00:28 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <6934efce0605021453l31a438c4j7c429e6973ab4546@mail.gmail.com>
In-Reply-To: <6934efce0605021453l31a438c4j7c429e6973ab4546@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200605030200.29141.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:bf0b512fe2ff06b96d9695102898be39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Tuesday 02 May 2006 23:53 schrieb Jared Hulbert:
> I will be submitting a new filesystem for inclusion into the kernel as
> soon as it is ready.  (It mounts but doesn't like doing much else
> right now.)  I would like to get feedback now to mold the development
> as we go along.  Please comment on the technical approaches and other
> inherent qualities or lack thereof.  Let me know of any serious
> obstacles to inclusion in the mainline.  We will Lindent it and clean
> it up quite a bit before really submitting.
>
> You may find it at its very boring sourceforge site
> https://sourceforge.net/projects/axfs/.  Browse the source at
> http://svn.sourceforge.net/axfs
> Or get the tarball at
> http://prdownloads.sourceforge.net/axfs/axfs-0.1.tar.gz?download
>
>
> What is it?:
> - AXFS for Advanced XIP File System.
> - Intended to be a root filesystem for embedded systems
> - Readonly
> - Uses addressable memory such as NOR flash instead of a block device
> - Borrows much from CRAMFS with Linear XIP patches
> - Allows XIP* of individual pages instead of just individual files
> - Uses filemap_xip.c where possible
>
> * By XIP, eXecute In Place, we mean that when a file is mmap'd() the
> pages are mapped directly to where they are stored in non volatile
> storage, rather than copied to RAM in the page cache and mapped from
> there

Nice, this is the first time I heard of anyone using filemap_xip on MTD.

> Why a new filesystem?
> - XIP of kernel is mainline, but not XIP of applications.  This
> enables application XIP

ext2fs does have XIP of applications, but of course only works on
block devices, not MTD. Is there more missing than an implementation
of block_device_operations::direct_access for mtd_blktrans_ops?

Why can't you get the same result with a combination of cramfs for
data files and ext2 with -o xip for your mmapped binaries?

> - Cramfs linear XIP patches not suitable for submission and lack some
> features of AXFS

Is that a fundamental problem of cramfs, or rather a problem of the
implementation of the linear XIP patches for it? IOW, can't you just
do a better patch to add filemap_xip support to cramfs?

> - Design allows for tighter packing of data and higher performance
> than XIP cramfs

why? by how much?

	Arnd <><
