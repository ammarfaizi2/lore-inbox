Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266356AbTA2QTE>; Wed, 29 Jan 2003 11:19:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266367AbTA2QTE>; Wed, 29 Jan 2003 11:19:04 -0500
Received: from ns.suse.de ([213.95.15.193]:2826 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S266356AbTA2QTD>;
	Wed, 29 Jan 2003 11:19:03 -0500
Date: Wed, 29 Jan 2003 17:28:24 +0100
From: Andi Kleen <ak@suse.de>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: two x86_64 fixes for 2.4.21-pre3
Message-ID: <20030129162824.GA4773@wotan.suse.de>
References: <15921.37163.139583.74988@harpo.it.uu.se> <20030124193721.GA24876@wotan.suse.de> <15926.60767.451098.218188@harpo.it.uu.se> <20030128212753.GA29191@wotan.suse.de> <15927.62893.336010.363817@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15927.62893.336010.363817@harpo.it.uu.se>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 1. One unknown ioctl is logged from RH8.0 init:
> 
> ioctl32(iwconfig:185): Unknown cmd fd(3) cmd(00008b01){00} arg(ffffda90) on socket:[389]

Probably harmless, but if you figure it out please send me a patch.

Basically the steps are:

- find out which ioctl it is.

- check its arguments. if the arguments are 64bit clean (see
http://www.firstfloor.org/~andi/writing-ioctl32 for a definition) you just
add it as COMPATIBLE_IOCTL to arch/x86_64/ia32/ia32_ioctl.c

If not you have to write a conversion handler, also following the tutorial
in writing-ioctl32.

> 
> 2. gdb still seems broken. gdb ./sleep [where ./sleep is simply main() calling
>    nanosleep(), but linked with -lpthread] hangs or loops and takes forever
>    to respond to ^C.

It works with the SuSE 32bit gdb/userland.

I think RedHat has a different libpthread. I don't have a RedHat userland,
so someone else will have to debug it.

> 
> 3. bootsect.S still needs a patch to prevent 'bzdisk' kernels from
>    disabling the FDC

I put your previous patch already into CVS, but that was after the 
last Marcelo sync.

-Andi
