Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315552AbSECFDk>; Fri, 3 May 2002 01:03:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315554AbSECFDj>; Fri, 3 May 2002 01:03:39 -0400
Received: from zok.SGI.COM ([204.94.215.101]:52671 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S315552AbSECFDi>;
	Fri, 3 May 2002 01:03:38 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel 
In-Reply-To: Your message of "Thu, 02 May 2002 21:17:43 MST."
             <Pine.LNX.4.33L2.0205022102570.11832-100000@dragon.pdx.osdl.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 03 May 2002 15:02:29 +1000
Message-ID: <7691.1020402149@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 May 2002 21:17:43 -0700 (PDT), 
"Randy.Dunlap" <rddunlap@osdl.org> wrote:
>I kinda like to do 'make bzImage' without making modules also.
>Would that be difficult to do in kbuild 2.5?
>Oh, but then I would also (still) need 'make modules'...

Sample testing targets, to see if you made any typing errors.

  make vmlinux
  make arch/i386/boot/bzImage
  make drivers/acpi (non-recursive)
  make drivers/acpi-r (recursive)

Do it with NO_MAKEFILE_GEN=1 for much, much! faster builds.  But you
should really do a clean make installable (which will do modules as
well) before make install.

>Any ideas about this error?  user error??
>
>$ make oldconfig menuconfig
>
>... and then
>
>[rddunlap@midway linux-2513-pv]$ make -f Makefile-2.5
>spec value %p not found
>Using ARCH='i386' AS='as' LD='ld' CC='/usr/bin/gcc' CPP='/usr/bin/gcc
>-E' AR='ar' HOSTAS='as' HOSTLD='gcc' HOSTCC='gcc' HOSTAR='ar'
>Generating global Makefile
>  phase 1 (find all inputs)
>Error: The CML input files have changed since .config was created.
>       Always make one of xconfig menuconfig oldconfig defconfig
>config randconfig allyes allno allmod after changing CML files
>make: *** [/usr/linsrc/linux-2513-pv/.config] Error 1

You mixed the old kbuild 2.4 make *config with a kbuild 2.5 build.
Don't do that.

One of the downsides of coexistence, users can get it wrong.

make -f Makefile-2.5 menuconfig installable

