Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266638AbSKLR2p>; Tue, 12 Nov 2002 12:28:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266643AbSKLR2p>; Tue, 12 Nov 2002 12:28:45 -0500
Received: from [198.149.18.6] ([198.149.18.6]:44771 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S266638AbSKLR2o>;
	Tue, 12 Nov 2002 12:28:44 -0500
Subject: Re: 2.5-bk AT_GID clash
From: Steve Lord <lord@sgi.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Anders Gustafsson <andersg@0x63.nu>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20021112172423.91C0C2C2DA@lists.samba.org>
References: <20021112172423.91C0C2C2DA@lists.samba.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1037122398.27014.43.camel@jen.americas.sgi.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 12 Nov 2002 11:33:18 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-11-12 at 11:16, Rusty Russell wrote:
> In message <20021112011858.GB19877@gagarin> you write:
> > Hi,
> > 
> > the new module-api making module.h including elf.h have exposed a name clash
> > in xfs:
> > 
> > include/linux/elf.h:175:#define AT_GID    13    /* real gid */
> > fs/xfs/linux/xfs_vnode.h:547:#define AT_GID             0x00000008
> > 
> > Can one be renamed? 
> 
> Probably should be.  I don't use AT_GID from memory, maybe somewhere
> else in the kernel is.
> 
> > Maybe module.h shouldn't be including elf.h, that afaik is needed by the
> > arch-specific module loaders and not by all modules. A split into
> > module.h for the modules and moduleloader.h for the arch-spec-loaders?
> 
> This might be OK too, but in practice I don't think much will be in
> moduleloader.h: asm/module.h only really defines struct
> mod_arch_specific, which is embedded in struct module, and struct
> module needs to be exposed for those inlines...


But does everyone who wants to implement a module need to be exposed
to all the details of the elf header?

Steve

-- 

Steve Lord                                      voice: +1-651-683-3511
Principal Engineer, Filesystem Software         email: lord@sgi.com
