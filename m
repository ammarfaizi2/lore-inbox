Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932284AbVHXVgE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932284AbVHXVgE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 17:36:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932285AbVHXVgD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 17:36:03 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:49558 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S932284AbVHXVgB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 17:36:01 -0400
Date: Wed, 24 Aug 2005 22:38:59 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Paul Jackson <pj@sgi.com>, paulus@samba.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: Linux-2.6.13-rc7
Message-ID: <20050824213859.GN9322@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.58.0508232203520.3317@g5.osdl.org> <20050824064342.GH9322@parcelfarce.linux.theplanet.co.uk> <20050824114351.4e9b49bb.pj@sgi.com> <20050824191544.GM9322@parcelfarce.linux.theplanet.co.uk> <20050824201301.GA23715@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050824201301.GA23715@mipter.zuzino.mipt.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2005 at 12:13:02AM +0400, Alexey Dobriyan wrote:
> On Wed, Aug 24, 2005 at 08:15:44PM +0100, Al Viro wrote:
> > Most of the remaining stuff is for
> > m68k (and applies both to Linus' tree and m68k CVS); I'll send that today
> > and if Geert ACKs them, we will be _very_ close to having 2.6.13 build
> > out of the box on the following set:
> > alpha,
> 
> Do I understand correctly that alpha in "--><-- close" list?
> 
> 2.6.13-rc7, alpha, allmodconfig:
> 
>   LD      .tmp_vmlinux1
> net/built-in.o: In function `kmalloc':
> include/linux/slab.h:92: undefined reference to `__you_cannot_kmalloc_that_much'
> include/linux/slab.h:92: undefined reference to `__you_cannot_kmalloc_that_much'
> 
> Guilty: net/ipv4/route.c
> 
> $ nm net/ipv4/route.o | grep kmalloc
>                  U __you_cannot_kmalloc_that_much

Not here...

  CC      arch/alpha/lib/udelay.o
  AR      arch/alpha/lib/lib.a
  GEN     .version
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
  KSYM    .tmp_kallsyms1.S
  AS      .tmp_kallsyms1.o
  LD      .tmp_vmlinux2
  KSYM    .tmp_kallsyms2.S
  AS      .tmp_kallsyms2.o
  LD      .tmp_vmlinux3
  KSYM    .tmp_kallsyms3.S
  AS      .tmp_kallsyms3.o
  LD      vmlinux
  SYSMAP  System.map
  SYSMAP  .tmp_System.map
  STRIP  arch/alpha/boot/vmlinux

Allmodconfig on alpha, alpha-linux-gcc (GCC) 4.0.1 20050727 (Red Hat 4.0.1-5).

Which place triggers it in your build?
