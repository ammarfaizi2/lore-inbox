Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261276AbSJHRom>; Tue, 8 Oct 2002 13:44:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261288AbSJHRom>; Tue, 8 Oct 2002 13:44:42 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:63504 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S261276AbSJHRom>;
	Tue, 8 Oct 2002 13:44:42 -0400
Date: Tue, 8 Oct 2002 19:49:46 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Mitchell Blank Jr <mitch@sfgoth.com>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [2.5 patch] fix kbuild breakage in drivers/atm
Message-ID: <20021008194946.A2212@mars.ravnborg.org>
Mail-Followup-To: Adrian Bunk <bunk@fs.tum.de>,
	Mitchell Blank Jr <mitch@sfgoth.com>,
	Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
References: <Pine.NEB.4.44.0210081752240.8340-100000@mimas.fachschaften.tu-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.NEB.4.44.0210081752240.8340-100000@mimas.fachschaften.tu-muenchen.de>; from bunk@fs.tum.de on Tue, Oct 08, 2002 at 06:02:41PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2002 at 06:02:41PM +0200, Adrian Bunk wrote:
> BTW:
> There might be places in the kernel that are now broken without a compile
> error, consider the second part of this line would output a compiler flag
> instead of a file name.

find -name Makefile | cut -d: -f 1 | grep -v arch | xargs grep '\.\./'

./drivers/atm/Makefile:    CONFIG_ATM_FORE200E_PCA_FW := $(shell if test -n "`$(CC) -E -dM ../../include/asm/byteorder.h | grep ' __LITTLE_ENDIAN '`"; then echo pca200e.bin; else echo pca200e_ecd.bin2; fi)
./drivers/net/Makefile:obj-$(CONFIG_ARCH_ACORN) += ../acorn/net/
./drivers/scsi/Makefile:obj-$(CONFIG_ARCH_ACORN)	+= ../acorn/scsi/
./fs/devfs/Makefile:TOPDIR = ../..
./fs/devfs/Makefile:	gcc -o /tmp/base.o -D__KERNEL__ -I../../include -Wall \

Dunno about the acorn part, but devfs looks broken.
Checking, devfs makefile has some documentation support in the makefile.
I'm tempted to delete it, surely it's not part of the kernel build system,
but I guess someone would yell at me.

If we include the architecture Makefiles:
find -name Makefile |  xargs grep '\.\./' | wc -l
   148

But I'm sure we hit a lot of false positves here.

	Sam
