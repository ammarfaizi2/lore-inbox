Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262475AbTHUG7i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 02:59:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262466AbTHUG5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 02:57:53 -0400
Received: from dsl092-013-071.sfo1.dsl.speakeasy.net ([66.92.13.71]:60585 "EHLO
	pelerin.serpentine.com") by vger.kernel.org with ESMTP
	id S262472AbTHUGaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 02:30:20 -0400
Subject: Re: Initramfs
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: gkajmowi@tbaytel.net
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200308210044.17876.gkajmowi@tbaytel.net>
References: <200308210044.17876.gkajmowi@tbaytel.net>
Content-Type: text/plain
Message-Id: <1061447419.19503.20.camel@camp4.serpentine.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 20 Aug 2003 23:30:20 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-08-20 at 21:44, Garrett Kajmowicz wrote:

> Upon booting I get the following:
> 
> Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
> Inode-cache hash table entries: 8196 (order: 3, 32768 bytes)
> Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
> ->(three characters, an 'o' with an I superimposed, a carat^, and a white 
> smilyface)
> Kernel panic: populate_root: bogus mode: 0
> 
> In idle task - not syncing

The initramfs cpio unpacker is quite cranky, and has some undocumented
limits.  What does "cpio -itv" report on your cpio archive?

If your archive contains any symlinks, for example, the unpacker will
almost certainly blow up.

> How would you suggest I go about fixing this problem, or do you require more 
> information?

If you actually want to fix the problem, you'll want to port
init/initramfs.c to userspace, hammer on it until it unpacks what you
want, then port the patches back to the kernel code and test them
there.  Unless you're unbelievably patient, in which case do all the
hacking on the kernel code and reboot a lot.

> Also, is there a good detailed FAQ or a HOWTO document available 
> online that I might be able to refer to?

No.  initramfs is stuck in limbo at the moment, and early userspace is
unlikely to see any real work until 2.7.  Feel free to ask questions,
but don't expect them to result in anything actually happening.

If you want to do real work in this area, the klibc mailing list is the
place to go: http://www.zytor.com/mailman/listinfo/klibc

	<b

