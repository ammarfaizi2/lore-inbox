Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262248AbVAQQeO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262248AbVAQQeO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 11:34:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262257AbVAQQeO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 11:34:14 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:45556 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S262248AbVAQQd5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 11:33:57 -0500
To: Pavel Machek <pavel@suse.cz>
Cc: torvalds@osdl.org, kernel list <linux-kernel@vger.kernel.org>
X-Message-Flag: Warning: May contain useful information
References: <20050116224922.GA4454@elf.ucw.cz>
	<20050117044955.GA8092@mars.ravnborg.org>
	<20050117114927.GD1354@elf.ucw.cz>
	<20050117154626.GA16111@mars.ravnborg.org>
From: Roland Dreier <roland@topspin.com>
Date: Mon, 17 Jan 2005 08:33:48 -0800
In-Reply-To: <20050117154626.GA16111@mars.ravnborg.org> (Sam Ravnborg's
 message of "Mon, 17 Jan 2005 16:46:26 +0100")
Message-ID: <52oefogglv.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: roland@topspin.com
Subject: Re: sparse refuses to work due to stdarg.h
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: No (on eddore); Unknown failure
X-OriginalArrivalTime: 17 Jan 2005 16:33:51.0652 (UTC) FILETIME=[53FA7E40:01C4FCB2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Sam> You seems to have a symlink? to /usr/include/asm in your
    Sam> 3.3.5/include directory.

No, with debian gcc, /usr/lib/gcc-lib/i486-linux/3.3.5/include/asm/ is
a real directory that includes nothing but posix_types.h.

    Sam> But real issue is search order of include paths in sparse.
    Sam> sparse searches standard system dirs before dir's specified
    Sam> with -I ...  This in contradiction to 'info gcc - see
    Sam> description for -I'.

Looks like you're right.  On Debian, "make C=1 V=1" ends up with:

      sparse -D__linux__ -Dlinux -D__STDC__ -Dunix -D__unix__ -nostdinc -isystem /usr/lib/gcc-lib/i486-linux/3.3.5/include -D__i386__ -Wp,-MD,init/.main.o.d -nostdinc -isystem /usr/lib/gcc-lib/i486-linux/3.3.5/include -D__KERNEL__ -Iinclude  -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffreestanding -O2     -fomit-frame-pointer -pipe -msoft-float -mpreferred-stack-boundary=2  -march=i686  -mregparm=3 -Iinclude/asm-i386/mach-default     -DKBUILD_BASENAME=main -DKBUILD_MODNAME=main init/main.c ;
    /usr/lib/gcc-lib/i486-linux/3.3.5/include/asm/posix_types.h:29:35: warning: no newline at end of file
    /usr/lib/gcc-lib/i486-linux/3.3.5/include/asm/posix_types.h:13:11: error: unable to open 'features.h'

so sparse is picking up the posix_types.h from the -isystem path
instead of the -I path as it should.

 - Roland

