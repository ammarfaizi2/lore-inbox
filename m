Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263248AbSJHV5b>; Tue, 8 Oct 2002 17:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263214AbSJHV4S>; Tue, 8 Oct 2002 17:56:18 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:34579 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262690AbSJHV4I>; Tue, 8 Oct 2002 17:56:08 -0400
Date: Tue, 8 Oct 2002 23:01:43 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Adrian Bunk <bunk@fs.tum.de>, Mitchell Blank Jr <mitch@sfgoth.com>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [2.5 patch] fix kbuild breakage in drivers/atm
Message-ID: <20021008230143.F12270@flint.arm.linux.org.uk>
References: <Pine.NEB.4.44.0210081752240.8340-100000@mimas.fachschaften.tu-muenchen.de> <20021008194946.A2212@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021008194946.A2212@mars.ravnborg.org>; from sam@ravnborg.org on Tue, Oct 08, 2002 at 07:49:46PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2002 at 07:49:46PM +0200, Sam Ravnborg wrote:
> find -name Makefile | cut -d: -f 1 | grep -v arch | xargs grep '\.\./'
> 
> ./drivers/atm/Makefile:    CONFIG_ATM_FORE200E_PCA_FW := $(shell if test -n "`$(CC) -E -dM ../../include/asm/byteorder.h | grep ' __LITTLE_ENDIAN '`"; then echo pca200e.bin; else echo pca200e_ecd.bin2; fi)
> ./drivers/net/Makefile:obj-$(CONFIG_ARCH_ACORN) += ../acorn/net/
> ./drivers/scsi/Makefile:obj-$(CONFIG_ARCH_ACORN)	+= ../acorn/scsi/
> ./fs/devfs/Makefile:TOPDIR = ../..
> ./fs/devfs/Makefile:	gcc -o /tmp/base.o -D__KERNEL__ -I../../include -Wall \
> 
> Dunno about the acorn part, but devfs looks broken.

I'd love for the acorn ones to go away, but certainly the SCSI one is
needed to get things to happen in the right order (or last time I
tested it which was quite some while ago, scsi still required a specific
init ordering.)

Whatever happens, I'll see about fixing them up once I've caught up with
2.5.41.  Other stuff is taking a back seat while I finish cleaning up
2.5.40 for the ARM people (a fair amount of crap has accumulated since
my previous 2.5.30 release, and those who normally follow what I do will
realise that there's been a very long silence, some would say too long...)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

