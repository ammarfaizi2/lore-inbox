Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267753AbTBRJuH>; Tue, 18 Feb 2003 04:50:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267754AbTBRJuH>; Tue, 18 Feb 2003 04:50:07 -0500
Received: from [81.80.245.157] ([81.80.245.157]:18664 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S267753AbTBRJuG>; Tue, 18 Feb 2003 04:50:06 -0500
Date: Tue, 18 Feb 2003 10:56:19 +0100
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: sam@ravnborg.org, kai@tp1.ruhr-uni-bochum.de, greg@kroah.com,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [RFC] klibc for 2.5.59 bk
Message-ID: <20030218095619.GC3980@cedar.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Jeff Garzik <jgarzik@pobox.com>, sam@ravnborg.org,
	kai@tp1.ruhr-uni-bochum.de, greg@kroah.com,
	linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@transmeta.com>
References: <20030209125759.GA14981@kroah.com> <Pine.LNX.4.44.0302162057200.5217-100000@chaos.physics.uiowa.edu> <20030217180246.GA26112@mars.ravnborg.org> <1911.212.181.176.76.1045505249.squirrel@www.zytor.com> <3E512BCB.1010000@pobox.com> <1144.62.20.229.212.1045558700.squirrel@www.zytor.com> <3E51FA1C.7060807@pobox.com> <20030218093601.GA3980@cedar.alcove-fr> <3E5200BD.6000604@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E5200BD.6000604@pobox.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2003 at 04:45:33AM -0500, Jeff Garzik wrote:

> >Linus, please apply.
> 
> um, please don't...

[...]
> 
> ...because
> (a) the Crusoe cflags are no longer together,
> (b) Cyrix-3 cflags are suddenly bisected by Crusoe cflags, and
> (c) you just dumped a crusoe-specific line in the middle of a bunch of 
> Via/Cyrix CPU settings.
> 
> None of those choices makes sense.  If you want to improve upon my 
> patch, I would suggest consolidating the -f/-m check above the CPU 
> cflags section, and then reference the calculated value, rather than 
> wholly duplicating the calculation.  The comment line "# The alignment 
> flags [...]" is obviously not the start of a new alignment-flags section.

Agreed, I was overzealous here...

Consolidating the -f/-m check above seems a bit overkill, especially
since we don't want the same align options for all architectures.

Maybe removing the comment is the simplest improvement on your 
patch then. Not a big improvement however :)

Stelian.

===== arch/i386/Makefile 1.44 vs edited =====
--- 1.44/arch/i386/Makefile	Fri Feb  7 19:59:54 2003
+++ edited/arch/i386/Makefile	Tue Feb 18 10:51:40 2003
@@ -39,12 +39,12 @@
 cflags-$(CONFIG_MK6)		+= $(call check_gcc,-march=k6,-march=i586)
 cflags-$(CONFIG_MK7)		+= $(call check_gcc,-march=athlon,-march=i686 -malign-functions=4)
 cflags-$(CONFIG_MK8)		+= $(call check_gcc,-march=k8,$(call check_gcc,-march=athlon,-march=i686 -malign-functions=4))
-cflags-$(CONFIG_MCRUSOE)	+= -march=i686 -malign-functions=0 -malign-jumps=0 -malign-loops=0
+cflags-$(CONFIG_MCRUSOE)	+= -march=i686
+cflags-$(CONFIG_MCRUSOE)	+= $(call check_gcc,-falign-functions=0 -falign-jumps=0 -falign-loops=0,-malign-functions=0 -malign-jumps=0 -malign-loops=0)
 cflags-$(CONFIG_MWINCHIPC6)	+= $(call check_gcc,-march=winchip-c6,-march=i586)
 cflags-$(CONFIG_MWINCHIP2)	+= $(call check_gcc,-march=winchip2,-march=i586)
 cflags-$(CONFIG_MWINCHIP3D)	+= -march=i586
 cflags-$(CONFIG_MCYRIXIII)	+= $(call check_gcc,-march=c3,-march=i486)
-# The alignment flags change with gcc 3.2
 cflags-$(CONFIG_MCYRIXIII)	+= $(call check_gcc,-falign-functions=0 -falign-jumps=0 -falign-loops=0,-malign-functions=0 -malign-jumps=0 -malign-loops=0)
 cflags-$(CONFIG_MVIAC3_2)	+= $(call check_gcc,-march=c3-2,-march=i686)
 

-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
