Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292334AbSBULPR>; Thu, 21 Feb 2002 06:15:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292335AbSBULPF>; Thu, 21 Feb 2002 06:15:05 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:27405 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S292334AbSBULOq>;
	Thu, 21 Feb 2002 06:14:46 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Christer Weinigel <wingel@acolyte.hack.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SC1200 support? 
In-Reply-To: Your message of "Thu, 21 Feb 2002 11:56:12 BST."
             <20020221105612.F12BEF5B@acolyte.hack.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 21 Feb 2002 22:14:35 +1100
Message-ID: <10746.1014290075@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Feb 2002 11:56:12 +0100 (CET), 
Christer Weinigel <wingel@acolyte.hack.org> wrote:
>I usually add "NO_MAKEFILE_GEN=anything" when compiling things so to
>avoid the dependency checking when just doing small changes, but I'm
>not allowed to do "make NO_MAKEFILE_GEN=anything install" which is a
>bit of a pain.  I usually run everything on my test system over NFS so
>I install the modules straight into the NFS tree.  So I'd really like
>to be able to tell the kbuild system "I know what I'm doing, don't
>babysit me".

A build with NO_MAKEFILE_GEN=1 is _not_ necessarily complete or
correct.  NO_MAKEFILE_GEN is for quick compiles to catch typing errors
or to add the odd printk, I cannot guarantee that the result has
recompiled everything.  I suppose I could add an option like
I_KNOW_THAT_THIS_BUILD_MAY_BE_INCORRECT_BUT_I_WANT_TO_INSTALL_IT_ANYWAY ;)

>Is it still possible to build modules outside of the kernel tree?  I
>really like the MTD model of building some modules where the Makefile
>looks like this:
>
>ifndef TOPDIR
>TOPDIR:=$(shell cd ../linux && pwd)
>endif
>
>all:
>        make -C $(TOPDIR) SUBDIRS=`pwd` modules
>
>M_OBJS := my_module.o
>
># Real actions are started from Rules.make
>include $(TOPDIR)/Rules.make
>
>Because this way I can build third party modules afterwards without
>having to recompile everything else.

Shadow trees already handle separate compilation.  Unlike kbuild 2.4,
nothing else is recompiled in kbuild 2.5, unless you have changed it.

