Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265438AbUADM1s (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 07:27:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265452AbUADM1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 07:27:48 -0500
Received: from aun.it.uu.se ([130.238.12.36]:10913 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S265438AbUADM1q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 07:27:46 -0500
Date: Sun, 4 Jan 2004 13:27:40 +0100 (MET)
Message-Id: <200401041227.i04CReNI004912@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: szepe@pinerecords.com
Subject: Re: Pentium M config option for 2.6
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Jan 2004 03:28:48 +0100, Tomas Szepe wrote:
>Since the Pentium M has 64 byte cache lines and is not a K7 or K8...  ;)
...
>--- a/arch/i386/Makefile	2003-09-28 11:38:05.000000000 +0200
>+++ b/arch/i386/Makefile	2004-01-04 03:02:52.000000000 +0100
>@@ -35,6 +35,7 @@
> cflags-$(CONFIG_MPENTIUMII)	+= $(call check_gcc,-march=pentium2,-march=i686)
> cflags-$(CONFIG_MPENTIUMIII)	+= $(call check_gcc,-march=pentium3,-march=i686)
> cflags-$(CONFIG_MPENTIUM4)	+= $(call check_gcc,-march=pentium4,-march=i686)
>+cflags-$(CONFIG_MPENTIUMM)	+= $(call check_gcc,-march=pentium4,-march=i686)
> cflags-$(CONFIG_MK6)		+= $(call check_gcc,-march=k6,-march=i586)
> # Please note, that patches that add -march=athlon-xp and friends are pointless.
> # They make zero difference whatsosever to performance at this time.

P-M is not a P4 core, it's an enhanced PIII core.
SSE2 was added, but compiler support for SSE2 f.p.
math shouldn't matter for the kernel.

Using P4 optimisations on a P-M may actually reduce
performance, due to the different micro-architectures.
(P4 made shifts and some leas more expensive, and
simple add/and/sub/etc less expensive.)

IOW, don't lie to the compiler and pretend P-M == P4
with that -march=pentium4.

And since P-M doesn't do SMP, does cache line size even
matter? There are no locks to protect from ping-ponging.

/Mikael
