Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262776AbVAQLtv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262776AbVAQLtv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 06:49:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262777AbVAQLtv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 06:49:51 -0500
Received: from gprs215-56.eurotel.cz ([160.218.215.56]:42651 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262776AbVAQLts (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 06:49:48 -0500
Date: Mon, 17 Jan 2005 12:49:27 +0100
From: Pavel Machek <pavel@suse.cz>
To: torvalds@osdl.org, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: sparse refuses to work due to stdarg.h
Message-ID: <20050117114927.GD1354@elf.ucw.cz>
References: <20050116224922.GA4454@elf.ucw.cz> <20050117044955.GA8092@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050117044955.GA8092@mars.ravnborg.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I'm probably doing something wrong, but... how do I force it to work?
> > I'm pretty sure it worked before, I'm not sure what changed in my
> > config.
> 
> kbuild was changed to reliably pick up the stdarg.h for the gcc used.
> Two issues has popped up:
> 1) sparse did not support -isystem dir
> 	- fixed a few days ago, and fix is at sparse.bkbits.net

Thanks, I installed -01-17 version.

> 2) misconfigured gcc's that report a wrong directory when using
> gcc -print-file-name=include
> The directory given must include stdarg.h - otherwise gcc config is
> broken.

That seems to be ok here:

pavel@amd:~$ gcc -print-file-name=include
/usr/lib/gcc-lib/i486-linux/3.3.5/include
pavel@amd:~$ gcc --version
gcc (GCC) 3.3.5 (Debian 1:3.3.5-5)
Copyright (C) 2003 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There
is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR
PURPOSE.

pavel@amd:~$ ls /usr/lib/gcc-lib/i486-linux/3.3.5/
SYSCALLS.c.X  cc1plus       crtbegin.o    crtbeginT.o   crtendS.o
libgcc.a      libgcc_s.so   libstdc++.so  specs
cc1           collect2      crtbeginS.o   crtend.o      include
libgcc_eh.a   libstdc++.a   libsupc++.a
pavel@amd:~$ ls /usr/lib/gcc-lib/i486-linux/3.3.5/include/st
stdarg.h   stdbool.h  stddef.h
pavel@amd:~$ ls /usr/lib/gcc-lib/i486-linux/3.3.5/include/stdarg.h
/usr/lib/gcc-lib/i486-linux/3.3.5/include/stdarg.h
pavel@amd:~$

but now I'm getting:

pavel@amd:/usr/src/linux-cvs$ make C=2
  CHK     include/linux/version.h
  CHECK   scripts/mod/empty.c
make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
  CHECK   init/main.c
/usr/lib/gcc-lib/i486-linux/3.3.5/include/asm/posix_types.h:29:35: warning: no newline at end of file
/usr/lib/gcc-lib/i486-linux/3.3.5/include/asm/posix_types.h:13:11: error: unable to open 'features.h'
make[1]: *** [init/main.o] Error 1
make: *** [init] Error 2
pavel@amd:/usr/src/linux-cvs$

Any ideas?
								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
