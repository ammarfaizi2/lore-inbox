Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264859AbTIDKPX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 06:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264898AbTIDKPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 06:15:23 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:41958 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S264859AbTIDKPT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 06:15:19 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16215.4277.540644.262286@gargle.gargle.HOWL>
Date: Thu, 4 Sep 2003 12:15:17 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Compiling an i386 kernel on AMD Opteron
In-Reply-To: <20030904115209.56e019b1.skraw@ithnet.com>
References: <20030904115209.56e019b1.skraw@ithnet.com>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephan von Krawczynski writes:
 > Hello,
 > 
 > is it possible to compile a kernel on Opteron for i386 (32-bit) and not 64 bit
 > Opteron with usual make procedures?
 > 
 > When I do a simple "make menuconfig" I can only see the Opteron processor type
 > in "Processor type and features" ...

You need to learn about cross-compilation.

make ARCH=i386

is the first step for you. Most people doing this also have cross-compilation
tool sets (compilers, linkers, libcs etc), and the CROSS_COMPILE= make
variable can be set to pick those up.

E.g., I do
make ARCH=x86_64 CROSS_COMPILE=x86_64-unknown-linux- 
or
make ARCH=ppc CROSS_COMPILE=ppc-unknown-linux-
when building x86-64 or ppc32 kernels on an i386 host.

Your x86-64 gcc should be able to generate 32-bit binaries using
the -m32 flag, so something like make ARCH=i386 CFLAGS=-m32 might work.
