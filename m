Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289504AbSAJPh3>; Thu, 10 Jan 2002 10:37:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289505AbSAJPhS>; Thu, 10 Jan 2002 10:37:18 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:65189
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S289504AbSAJPhB>; Thu, 10 Jan 2002 10:37:01 -0500
Date: Thu, 10 Jan 2002 08:36:57 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: Corey Minyard <minyard@acm.org>, linux-kernel@vger.kernel.org
Subject: Re: Moving zlib so that others may use it
Message-ID: <20020110153657.GY13931@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <3C3D1743.40900@acm.org> <24080.1010637887@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24080.1010637887@kao2.melbourne.sgi.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2002 at 03:44:47PM +1100, Keith Owens wrote:
> On Wed, 09 Jan 2002 22:23:31 -0600, 
> Corey Minyard <minyard@acm.org> wrote:
> >Keith Owens wrote:
> >>On Wed, 09 Jan 2002 17:32:20 -0600, 
> >>Corey Minyard <minyard@acm.org> wrote:
> >>>I would like to propose putting zlib in the lib directory and making it 
> >>>optionally compile if it is needed.
> >>
> >>The best option is to build zlib.o for the kernel (not module) and
> >>store it in lib.a.  Compile zlib.o if any consumer of zlib has been
> >>selected and add a dummy reference to zlib code in vmlinux to ensure
> >>that zlib is pulled from the archive if anybody needs it, even if all
> >>the consumers are in modules.  Some of the zlib symbols will need to be
> >>exported, I will leave that to you.
> >>
> >Why not just create zlib as a module if all the users are modules (so 
> >depmod and modprobe load it)?  That's what everything else does.  And 
> >that way, if it's already in the kernel, the module just won't get 
> >loaded, but if it's not the module gets loaded.  What you are suggesting 
> >seems rather convoluted.
> 
> If zlib is a module then it cannot be part of lib/lib.a, it has to be
> separate, with changes to the top level Makefile to conditionally
> include lib/zlib.o.  I did that originally but the changes to
> lib/Makefile and the top level Makefile were worse.  Building zlib as a
> module guarantees that you cannot use it in a boot loader, forcing you
> to maintain multiple versions of zlib.c.  If you are going to use one
> version of zlib then you should try to handle bootloaders as well.


It's possible they can share, but the bootloaders (PPC & MIPS) need a
slight change to the zlib.c code to to allow using zero as a real
address to store the uncompressed data.  So we'd want to guard the
changes with __BOOTER__ or so, and then cp the file or do
#define __BOOTER__
#include "zlib.c"

And do -I$(TOPDIR)/lib, or something along those lines.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
