Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262100AbTDKOts (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 10:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264235AbTDKOtr (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 10:49:47 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:6530 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S262100AbTDKOtq (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 10:49:46 -0400
Date: Fri, 11 Apr 2003 17:01:14 +0200 (MEST)
Message-Id: <200304111501.h3BF1EQj013871@harpo.it.uu.se>
From: mikpe@csd.uu.se
To: benh@kernel.crashing.org
Subject: Re: gcc-2.95 broken on PPC?
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10 Apr 2003 16:20:55 +0200, Benjamin Herrenschmidt wrote:
> On Thu, 2003-04-10 at 14:56, mikpe@csd.uu.se wrote:
> 
> > However, bugs #1 (zlib.c) and #3 (div64.h) disappear if I compile
> > my kernels with gcc-3.2.2 instead of 2.95.4, which is a strong
> > indication that 2.95.4 is broken on PPC. Is this something that's
> > well-known to PPC people?
> > 
> > The patches are included below for reference.
> 
> It would be interesting to see the section dumps of the resulting
> coff image and compare the version that works and the one that
> doesn't. I still suspect some alignement crap, seeing this may
> eventually show it.

That's certainly possible. I was rebuilding 2.4.21-pre7 with both
compilers, and suddenly the gcc-2.95.4-built vmlinux.coff succeeded
to boot. I didn't expect that, since I've been fighting these boot
problems for weeks now.

I managed to reproduce the problem with 2.4.20 vanilla + only the
one patch to ld.script to fix the CLAIM error on "loading .data":
the kernel compiled with gcc-3.2.2 boots, the one compiled with
gcc-2.95.4 fails at the "clearing .bss" step. The images, vmlinux
and vmlinux.coff for both compiler versions, and .config are in
<http://www.csd.uu.se/~mikpe/linux/powerpc/> in case anyone wants
to check what's wrong with the 2.95.4 build.

/Mikael
