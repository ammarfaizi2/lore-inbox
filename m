Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161064AbVLJUeX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161064AbVLJUeX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 15:34:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161065AbVLJUeW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 15:34:22 -0500
Received: from smtp7.wanadoo.fr ([193.252.22.24]:275 "EHLO smtp7.wanadoo.fr")
	by vger.kernel.org with ESMTP id S1161064AbVLJUeW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 15:34:22 -0500
X-ME-UUID: 20051210203418775.BD5D618000AE@mwinf0707.wanadoo.fr
Subject: Re: i386 -> x86_64 cross compile failure (binutils bug?)
From: Xavier Bestel <xavier.bestel@free.fr>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1134178279.18432.55.camel@mindpipe>
References: <1134154208.14363.8.camel@mindpipe>
	 <1134168222.5270.1.camel@bip.parateam.prv>
	 <1134178279.18432.55.camel@mindpipe>
Content-Type: text/plain; charset=ISO-8859-15
Date: Sat, 10 Dec 2005 21:34:18 +0100
Message-Id: <1134246859.5192.1.camel@bip.parateam.prv>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le vendredi 09 décembre 2005 à 20:31 -0500, Lee Revell a écrit :
> On Fri, 2005-12-09 at 23:43 +0100, Xavier Bestel wrote:
> > Le vendredi 09 décembre 2005 à 13:50 -0500, Lee Revell a écrit :
> > > I'm trying to build an x66-64 kernel on a 32 bit system (Ubuntu 5.10).
> > > I added -m64 to the CFLAGS as per the gcc docs. 
> > 
> > Under debian 32bits with 64bits kernel, I just add -m64 somewhere in the
> > main Makefile to rebuild my modules. Didn't try with a whole kernel
> > though.
> 
> The bug seems to be that the kernel build system does not grok biarch
> toolchains - it really insists on a separate toolchain for i386 and
> x86_64 even though the situation can be handled with selective use of
> -m64.  If I jsut add -m64 to everything then it fails when it gets to
> the ia32 stuff.

Yes, you shouldn't compile host executables with -m64, obviously.

--- /usr/src/linux-headers-2.6.14-2/Makefile.old        2005-12-10 21:32:17.000000000 +0100
+++ /usr/src/linux-headers-2.6.14-2/Makefile    2005-11-17 14:26:02.000000000 +0100
@@ -352,7 +352,7 @@

 CFLAGS                 := -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
                   -fno-strict-aliasing -fno-common \
-                  -ffreestanding
+                  -ffreestanding -m64
 AFLAGS         := -D__ASSEMBLY__

 export VERSION PATCHLEVEL SUBLEVEL EXTRAVERSION LOCALVERSION KERNELRELEASE \


HTH,
	Xav


