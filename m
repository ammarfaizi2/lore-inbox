Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965028AbWFHVwA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965028AbWFHVwA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 17:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965031AbWFHVwA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 17:52:00 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:32462 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S965028AbWFHVv7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 17:51:59 -0400
Message-Id: <200606082151.k58LpTq7007519@laptop11.inf.utfsm.cl>
To: Sascha Nitsch <Sash_lkl@linuxhowtos.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Idea about a disc backed ram filesystem 
In-Reply-To: Message from Sascha Nitsch <Sash_lkl@linuxhowtos.org> 
   of "Thu, 08 Jun 2006 22:33:13 +0200." <200606082233.13720.Sash_lkl@linuxhowtos.org> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 19)
Date: Thu, 08 Jun 2006 17:51:28 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.21.155]); Thu, 08 Jun 2006 17:51:31 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sascha Nitsch <Sash_lkl@linuxhowtos.org> wrote:
> this is (as of this writing) just an idea.
> 
> === current state ===
> Currently we have ram filesystems (like tmpfs) and disc based file systems
> (ext2/3, xfs, <insert your fav. fs>).

Right.

> tmpfs is extremely fast but suffers from data losses from restarts, crashes
> and power outages.

Part of the design tradeoffs.

>                    Disc access is slow against a ram based fs.

On-disk filesystems (and block device handling) are designed around that
fact.

> === the idea ===
> My idea is to mix them to the following hybrid:
> - mount the new fs over an existing dir as an overlay
> - all files overlayed are still accessible
> - after the first read, the file stays in memory (like a file cache)
> - all writes are flushed out to the underlying fs (maybe done async)
> - all reads are always done from the memory cache unless they are not cached
>   yet
> - the cache stays until the partition is unmounted
> - the maximum size of the overlayed filesystem could be physical ram/2 (like tmpfs)

But the current on.disk filesystems use caching of data in RAM extensively,
/without/ having to keep the whole file in memory, just the pieces
currently in active use. Your proposal negates the RAM for caches, so it
would be much /slower/ than the current on-disk filesystems.

BTW, many of the live-CD distributions do exactly this (RAM overlay over a
CD-based filesystem).
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
