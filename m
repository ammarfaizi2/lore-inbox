Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265928AbSKBKpB>; Sat, 2 Nov 2002 05:45:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265927AbSKBKpA>; Sat, 2 Nov 2002 05:45:00 -0500
Received: from sullivan.realtime.net ([205.238.132.76]:65293 "EHLO
	sullivan.realtime.net") by vger.kernel.org with ESMTP
	id <S265926AbSKBKo7>; Sat, 2 Nov 2002 05:44:59 -0500
Date: Sat, 2 Nov 2002 04:51:29 -0600 (CST)
Message-Id: <200211021051.gA2ApTZ17164@sullivan.realtime.net>
From: <miltonm@bga.com> Milton Miller
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCHES] initramfs merge, part 1 of N
In-Reply-To: <3DC38939.90001@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Items For Discussion
> 
> #1 - shared kinit
> 
> "kinit" is _the_ early userspace binary -- but not necessarily the only
> one. Peter Anvin and Russell King have several binaries in the klibc
> tarball, gzip, ash, and several smaller utilities. Peter also put work
> into making klibc a shared object -- that doesn't need an shlib loader.
>  It's pretty nifty how he does it, IMO: klibc.so becomes an ELF
> interpreter for any klibc-linked binaries. klibc-linked binaries are,
> to the ELF system, static binaries, but they wind up sharing klibc.so
> anyway due to this trick.
> 
> Anyway, there is a certain elegance in adding coding to kinit instead of
> an explosion of binaries and shell scripts. The other side of that coin
> is that with elegance you sacrifice some ease of making changes. I am
> 60% certain we want a shared klibc and multiple binaries, but am willing
> to be convinced in either direction. If you think about it, there _are_
> several benefits to leaving kinit as the lone binary in the stock kernel
> early userspace build, so the decision is not as cut-n-dry as it may
> immediately seem. 


One idea I experimented some time ago with (and can revive after
some sleep) is, rather than interpreting cpio in the kernel, objcopy
a binary into a init and copy that into pagecache in a ramfs/libfs
file system.   The population was all initfunctions, trying to make
it disappear at runtime.  /dev/initrd was left for userspace to
expand the rest of the loaders.  With libfs, the write code reinstated
so standard directories, device nodes, console and initrd nodes
can be created and opened in userspace, further shrinking the static
linked-in code.

This argues that this initial code is unshared and uncompressed
(or rather, compressed like the rest of the kernel); for shared we
would have to copy a couple of pieces this way.  It traded off a
table of offset,length,mode,name with cpio headers and parsing.

I had this running on 2.4.19-pre10 (around the time of the kernel
summit, just before the fixed directory link counts went in) with
busybox.  (I seperated the 2.4 compat vs 2.5 stuff at that time).

Comments?

milton
