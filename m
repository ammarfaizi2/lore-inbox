Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265847AbUFDQqW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265847AbUFDQqW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 12:46:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265872AbUFDQqW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 12:46:22 -0400
Received: from kempelen.iit.bme.hu ([152.66.241.120]:58759 "EHLO
	kempelen.iit.bme.hu") by vger.kernel.org with ESMTP id S265847AbUFDQqU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 12:46:20 -0400
Date: Fri, 4 Jun 2004 18:46:11 +0200 (MET DST)
Message-Id: <200406041646.i54GkB125696@kempelen.iit.bme.hu>
From: Miklos Szeredi <mszeredi@inf.bme.hu>
To: Eduard Bloch <blade@debian.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [HOWTO...] LUFS, readpage and large files
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> while writting a new LUFS plugin (to emulate large file support on
> FAT32;) I stumbled over a problem with it's kernel communication module.
> The symptoms were the same as with broken programs that use int or long
> int instead of size_t (or even long long) for storing file offsets.
> However, here the broken offsets (modulo 4GB) came from kernel so I
> traced it down to this method:

[...]

>     offset = p->index << PAGE_CACHE_SHIFT;

This should be:

     offset = (unsigned long long) p->index << PAGE_CACHE_SHIFT;

BTW, you can use FUSE + LUFIS for running LUFS filesystems with the
FUSE kernel module. Or even better: you can write your filesystem
natively with FUSE ;)

You can download LUFIS from http://sourceforge.net/projects/avf, FUSE
is already in debian testing.

Cheers,
Miklos


