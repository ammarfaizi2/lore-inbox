Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261485AbREQSr7>; Thu, 17 May 2001 14:47:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261487AbREQSrt>; Thu, 17 May 2001 14:47:49 -0400
Received: from comverse-in.com ([38.150.222.2]:42382 "EHLO
	eagle.comverse-in.com") by vger.kernel.org with ESMTP
	id <S261485AbREQSrb>; Thu, 17 May 2001 14:47:31 -0400
Message-ID: <6B1DF6EEBA51D31182F200902740436802678EDB@mail-in.comverse-in.com>
From: "Khachaturov, Vassilii" <Vassilii.Khachaturov@comverse.com>
To: "'Anders Peter Fugmann'" <afu@fugmann.dhs.org>,
        Andreas Dilger <adilger@turbolinux.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: Exporting symbols from a module.
Date: Thu, 17 May 2001 14:46:35 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If you have a local makefile with which you wish to build your module 
not linked under the kernel tree in the proper way, you still can
"ride" on the master Makefile.

This way one can eliminate the dependency on your particular 
machine kernel compilation options to be hardwired in the local Makefile.
I.e., once you reconfigure the kernel, your driver will compile
itself when you do a local "make" with the correct set of the new flags.

This is what you can do on 2.2 (Makefile excerpt follows):
EXTRA_CFLAGS := -DDEBUG -DLINUX -I/usr/src/foo/include
MI_OBJS  := your-module.o
O_TARGET := your-module.o
O_OBJS   := your1.o your2.o

# Reuse Linux kernel master makefile on this directory
ifdef MAKING_MODULES
include $(TOPDIR)/Rules.make
else
all::
        cd '/usr/src/linux' && make modules SUBDIRS=$(PWD)
endif

In 2.4 the syntax is different. Rename
MI_OBJS to obj-m and O_OBJS to obj-y to achieve the same goal there:
obj-m  := your-module.o
O_TARGET := your-module.o
obj-y   := your1.o your2.o

HTH,
	Vassilii

> -----Original Message-----
> From: Anders Peter Fugmann [mailto:afu@fugmann.dhs.org]
> Sent: Thursday, May 17, 2001 12:51 PM
> To: Andreas Dilger
> Cc: linux-kernel
> Subject: Re: Exporting symbols from a module.
> 
> 
> Resolved.
> 
> I just looked at what the kernel did whne compiling a module that 
> exported some symbols, and discovered that I needed
> to set CFLAGS to:
> 
> -D__KERNEL__ -I$/usr/src/linux)  -Wall -Wstrict-prototypes \
> -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe \
> -DMODULE  -DMODVERSIONS -include \
> /usr/src/linux/modversions.h
> 
> Now all works correctly, and I can load my modules.
