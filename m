Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262278AbUBXPeI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 10:34:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262279AbUBXPeI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 10:34:08 -0500
Received: from aun.it.uu.se ([130.238.12.36]:12742 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262278AbUBXPeD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 10:34:03 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16443.28391.185684.697432@alkaid.it.uu.se>
Date: Tue, 24 Feb 2004 16:33:59 +0100
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Martin Schaffner <schaffner@gmx.li>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.4.25] enable cross-compilation from Mac OS X
In-Reply-To: <9D6F6210-66DA-11D8-A093-0003931E0B62@gmx.li>
References: <9D6F6210-66DA-11D8-A093-0003931E0B62@gmx.li>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Schaffner writes:
 > Hi,
 > 
 > After setting up a cross-compile toolchain (using 
 > http://vserver.13thfloor.at/Stuff/Cross/) on Mac OS X 10.3.2, and 
 > applying the following patch, I was able to compile a bootable linux 
 > kernel with the command:
 > make CROSS_COMPILE=/usr/local/bin/powerpc-linux-gnu-
 > 
 > Please consider applying the patch to the main 2.4 tree.
 > 
 > I was also able to compile 2.6.1 with basically the same patch, but it 
 > required some additional fiddling with the makefiles in 
 > not-entirely-clean ways.
 > 
 > --- Makefile.old        Wed Feb 18 13:36:32 2004
 > +++ Makefile    Tue Feb 24 11:36:13 2004
 > @@ -5,7 +5,7 @@
 > 
 >   KERNELRELEASE=$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)
 > 
 > -ARCH := $(shell uname -m | sed -e s/i.86/i386/ -e s/sun4u/sparc64/ -e 
 > s/arm.*/arm/ -e s/sa110/arm/)
 > +ARCH := $(shell uname -m | sed -e s/i.86/i386/ -e s/sun4u/sparc64/ -e 
 > s/arm.*/arm/ -e s/sa110/arm/ -e s/Power\ Macintosh/ppc/)
 >   KERNELPATH=kernel-$(shell echo $(KERNELRELEASE) | sed -e "s/-//g")
 > 
 >   CONFIG_SHELL := $(shell if [ -x "$$BASH" ]; then echo $$BASH; \

Just do
make ARCH=$ARCH CROSS_COMPILE=$CROSS_COMPILE
like we've always done when cross-compiling.

This patch is not needed.
