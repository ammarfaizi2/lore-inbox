Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267117AbSKMHJj>; Wed, 13 Nov 2002 02:09:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267121AbSKMHJj>; Wed, 13 Nov 2002 02:09:39 -0500
Received: from dp.samba.org ([66.70.73.150]:57223 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267117AbSKMHJi>;
	Wed, 13 Nov 2002 02:09:38 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Steve Lord <lord@sgi.com>
Cc: Anders Gustafsson <andersg@0x63.nu>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5-bk AT_GID clash 
In-reply-to: Your message of "12 Nov 2002 11:33:18 MDT."
             <1037122398.27014.43.camel@jen.americas.sgi.com> 
Date: Wed, 13 Nov 2002 05:07:03 +1100
Message-Id: <20021113071630.190EC2C077@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <1037122398.27014.43.camel@jen.americas.sgi.com> you write:
> On Tue, 2002-11-12 at 11:16, Rusty Russell wrote:
> > This might be kOK too, but in practice I don't think much will be in
> > moduleloader.h: asm/module.h only really defines struct
> > mod_arch_specific, which is embedded in struct module, and struct
> > module needs to be exposed for those inlines...
> 
> But does everyone who wants to implement a module need to be exposed
> to all the details of the elf header?

Well, linux/module.h -> asm/module.h -> linux/elf.h.  Although if you
use #define instead of typedef you can break the last link.  Feel free
to send a patch to split it into moduleload.h or something, but I
think it'll look tiny.

But IMHO the nameclash needs to be fixed *anyway*, not hacked around,
or someone else will run over it one day.  AFAICT, changing
fs/binfmt_elf.c and elf.h to AT_RGID is the simplest.  Both should be
mildly chastised for using a prefix like AT_ publically.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
