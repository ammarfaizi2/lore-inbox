Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266929AbSKLSAq>; Tue, 12 Nov 2002 13:00:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266927AbSKLSAq>; Tue, 12 Nov 2002 13:00:46 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:24329 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S266929AbSKLSAp>; Tue, 12 Nov 2002 13:00:45 -0500
Date: Tue, 12 Nov 2002 18:07:27 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Anders Gustafsson <andersg@0x63.nu>, linux-kernel@vger.kernel.org,
       lord@sgi.com
Subject: Re: 2.5-bk AT_GID clash
Message-ID: <20021112180727.A15961@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Anders Gustafsson <andersg@0x63.nu>, linux-kernel@vger.kernel.org,
	lord@sgi.com
References: <20021112011858.GB19877@gagarin> <20021112172423.91C0C2C2DA@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021112172423.91C0C2C2DA@lists.samba.org>; from rusty@rustcorp.com.au on Wed, Nov 13, 2002 at 04:16:56AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2002 at 04:16:56AM +1100, Rusty Russell wrote:
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

If it's for nothing else it's at least worth not exposing elf details
to every single file in the kernel..

