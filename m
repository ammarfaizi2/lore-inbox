Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272500AbTHKL1l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 07:27:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272504AbTHKL1l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 07:27:41 -0400
Received: from pub237.cambridge.redhat.com ([213.86.99.237]:24040 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id S272500AbTHKL1j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 07:27:39 -0400
Subject: Re: 2.5.x module make questions
From: David Woodhouse <dwmw2@infradead.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: yiding_wang@agilent.com, linux-kernel@vger.kernel.org,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
In-Reply-To: <20030729210916.GA20154@mars.ravnborg.org>
References: <334DD5C2ADAB9245B60F213F49C5EBCD05D55239@axcs03.cos.agilent.com>
	 <20030729210916.GA20154@mars.ravnborg.org>
Content-Type: text/plain
Message-Id: <1060601246.8833.9.camel@passion.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.1 (dwmw2) 
Date: Mon, 11 Aug 2003 12:27:34 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-07-29 at 22:09, Sam Ravnborg wrote:
> What Corbet suggest in the referenced doc is to have the following:
> 
> ifndef KERNELRELEASE
> here goes old style Makefile
> else
> here goes Kbuild makefile
> endif

This is pointless. The 'make -C $KERNELDIR SUBDIRS=`pwd`' form has been
working since at least 2.0, and surely nobody's trying to build for 1.3
kernels any more? Just do it the latter way unconditionally.


> > ag.o: ../../../../t/s/ts.o ../../../f/c/fc.o ../../../f/i/fi.o  s/sl.o 
> > 	ld -r -o ag.o ../../../../t/s/ts.o ../../../f/c/fc.o ../../../f/i/fi.o s/sl.o 
> 
> This looks really ugly. I do not expect kbuild to even get close to help
> you here. kbuild is designed around the idea that objects are built
> directory-by-directory, and in the upper level directory the are linked.
> What you have surely does not follow that principle.

In fact, the kbuild system just uses strings for the SUBDIRS variable...
it doesn't inspect them to check for '..' in them and deliberately barf
(although perhaps it should :).

ifndef TOPDIR
# Invoked from the command line... do it properly

# KERNELDIR can be overridden on the command line
KERNELDIR := /lib/modules/`uname -r`/build

default:
	make -C $(KERNELDIR) SUBDIRS=`pwd` modules

else
# Invoked from the kernel build...

SUBDIRS := ../../../../t/s../../../f/c ../../../f/i s

ag-objs := ../../../../t/s/ts.o ../../../f/c/fc.o ../../../f/i/fi.o \
		s/sl.o 
obj-m := ag.o

endif
> > Any suggestion is welcomed.  If the kbuild cannot do ascending, I have to change the source tree structure but that is the least I want to do.
> 
> This is my best suggestion. Follow the normal way of doing things in the
> kernel make it easier/possible to use the infrastructure provided
> by the kernel.
> 
> PS. Please also read the paper by Kai Germashewski from OLS -
> see www.linuxsymposium.org - it provide good background info on kbuild.
> 
> 	Sam
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
dwmw2

