Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267166AbSKMLLA>; Wed, 13 Nov 2002 06:11:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267167AbSKMLK7>; Wed, 13 Nov 2002 06:10:59 -0500
Received: from h55p111.delphi.afb.lu.se ([130.235.187.184]:26852 "EHLO
	gagarin.0x63.nu") by vger.kernel.org with ESMTP id <S267166AbSKMLK7>;
	Wed, 13 Nov 2002 06:10:59 -0500
Date: Wed, 13 Nov 2002 12:17:45 +0100
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Steve Lord <lord@sgi.com>, Anders Gustafsson <andersg@0x63.nu>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: linux/elf.h vs linux/module.h [was: 2.5-bk AT_GID clash]
Message-ID: <20021113111744.GA10014@gagarin>
References: <1037122398.27014.43.camel@jen.americas.sgi.com> <20021113071630.190EC2C077@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021113071630.190EC2C077@lists.samba.org>
User-Agent: Mutt/1.4i
From: Anders Gustafsson <andersg@0x63.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2002 at 05:07:03AM +1100, Rusty Russell wrote:
> In message <1037122398.27014.43.camel@jen.americas.sgi.com> you write:
> > On Tue, 2002-11-12 at 11:16, Rusty Russell wrote:
> > > This might be kOK too, but in practice I don't think much will be in
> > > moduleloader.h: asm/module.h only really defines struct
> > > mod_arch_specific, which is embedded in struct module, and struct
> > > module needs to be exposed for those inlines...
> > 
> > But does everyone who wants to implement a module need to be exposed
> > to all the details of the elf header?
> 
> Well, linux/module.h -> asm/module.h -> linux/elf.h.  Although if you
> use #define instead of typedef you can break the last link.  Feel free
> to send a patch to split it into moduleload.h or something, but I
> think it'll look tiny.

At least for i386 there is no inclusion of elf.h from asm/module.h, and they
are already defines. And a quick grep in the other arches shows no direct
include of elf.h. So removing elf.h from module.h should relieve all
sourcefiles[*] including module.h implicitly including elf.h too, which imho
is a good thing.

[*] find . -name "*.c" | xargs grep "include <linux/module.h>" | wc -l
   2479

-- 
Anders Gustafsson - andersg@0x63.nu - http://0x63.nu/
