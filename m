Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266623AbSKLRRf>; Tue, 12 Nov 2002 12:17:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266631AbSKLRRf>; Tue, 12 Nov 2002 12:17:35 -0500
Received: from dp.samba.org ([66.70.73.150]:10720 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S266623AbSKLRRd>;
	Tue, 12 Nov 2002 12:17:33 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Anders Gustafsson <andersg@0x63.nu>
Cc: linux-kernel@vger.kernel.org, lord@sgi.com
Subject: Re: 2.5-bk AT_GID clash 
In-reply-to: Your message of "Tue, 12 Nov 2002 02:18:58 BST."
             <20021112011858.GB19877@gagarin> 
Date: Wed, 13 Nov 2002 04:16:56 +1100
Message-Id: <20021112172423.91C0C2C2DA@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20021112011858.GB19877@gagarin> you write:
> Hi,
> 
> the new module-api making module.h including elf.h have exposed a name clash
> in xfs:
> 
> include/linux/elf.h:175:#define AT_GID    13    /* real gid */
> fs/xfs/linux/xfs_vnode.h:547:#define AT_GID             0x00000008
> 
> Can one be renamed? 

Probably should be.  I don't use AT_GID from memory, maybe somewhere
else in the kernel is.

> Maybe module.h shouldn't be including elf.h, that afaik is needed by the
> arch-specific module loaders and not by all modules. A split into
> module.h for the modules and moduleloader.h for the arch-spec-loaders?

This might be OK too, but in practice I don't think much will be in
moduleloader.h: asm/module.h only really defines struct
mod_arch_specific, which is embedded in struct module, and struct
module needs to be exposed for those inlines...

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
