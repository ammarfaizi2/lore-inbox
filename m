Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265477AbTAWRYF>; Thu, 23 Jan 2003 12:24:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265480AbTAWRYF>; Thu, 23 Jan 2003 12:24:05 -0500
Received: from rumms.uni-mannheim.de ([134.155.50.52]:38046 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id <S265477AbTAWRYE>; Thu, 23 Jan 2003 12:24:04 -0500
From: Thomas Schlichter <schlicht@uni-mannheim.de>
To: "Randy.Dunlap" <rddunlap@osdl.org>, Sam Ravnborg <sam@ravnborg.org>
Subject: Re: no version magic, tainting kernel.
Date: Thu, 23 Jan 2003 18:32:59 +0100
User-Agent: KMail/1.4.3
Cc: LKML <linux-kernel@vger.kernel.org>, Rusty Russell <rusty@rustcorp.com.au>
References: <200301231459.22789.schlicht@uni-mannheim.de> <20030123165256.GA1092@mars.ravnborg.org>
In-Reply-To: <20030123165256.GA1092@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_ZQG6OHDDZNQTQM1DTAA3"
Message-Id: <200301231832.59942.schlicht@uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_ZQG6OHDDZNQTQM1DTAA3
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Thanks for your answers!

I did not compile my module with a kernel Makefile, I used the very small and 
simple one attatched to this mail. So it seems I miss something when the 
module is linked and I have to know what I have to link to the module or 
which header-file I have to include...

For me it seems link I have to link the init/vermagic.c file to my module, but 
how would this be possible if only the kernel includes were available??
I think only these should be needed to compile a module...

  Thomas Schlichter


Am Donnerstag, 23. Januar 2003 17:29 schrieb Randy.Dunlap:
> Did you rebuild the module with a 2.5.59 Makefile?
>
>
> Yes, it's a 2.5.59 change according to the Changelog at kernel.org:
>
> <QUOTE>
> <kai@tp1.ruhr-uni-bochum.de>
> Module Sanity Check
>
> This patch, based on Rusty's implementation,
> adds a special section to vmlinux and all modules, which
> contain the kernel version string, values of some
> particularly important config options (SMP,preempt,proc
> family) and the gcc version.
>
> When inserting a module, the version string is checked against the
> kernel version string and loading is rejected if they don't match.
>
> The version string is actually added to the modules during the final
> .ko generation, so that a changed version string does only cause relinking,
> not recompilation, which is a major performance improvement over the old
> 2.4 way of doing things.
> </QUOTE>


Am Donnerstag, 23. Januar 2003 17:52 schrieb Sam Ravnborg:
> What command did you use to build your module?
> If you did no use:
> make -C path/to/kernel/src SUBDIRS=$PWD modules
>
> chances are big you did not compile the module correct.
> This requires the Makefile to look like any other kernel (kbuild) makefile.
>
> 	Sam

--------------Boundary-00=_ZQG6OHDDZNQTQM1DTAA3
Content-Type: text/x-makefile;
  charset="iso-8859-1";
  name="Makefile"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="Makefile"

# get current release for include path
RELEASE   = $(shell uname -r)

# set compile flags, defines and include directory
CFLAGS    = -Wall -O2 -fno-common
INCLUDES  = -I/lib/modules/$(RELEASE)/build/include
DEFINES   = -D__KERNEL__ -DMODULE -DKBUILD_MODNAME="tlbstat"

all: tlbstat.o

tlbstat.o: tlbstat.c
	gcc -c $(CFLAGS) $(INCLUDES) $(DEFINES) $<

clean:
	rm -f tlbstat.o *~ core


--------------Boundary-00=_ZQG6OHDDZNQTQM1DTAA3--

