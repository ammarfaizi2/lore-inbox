Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267444AbTASLXm>; Sun, 19 Jan 2003 06:23:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267451AbTASLXm>; Sun, 19 Jan 2003 06:23:42 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:21657 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id <S267444AbTASLXl>; Sun, 19 Jan 2003 06:23:41 -0500
Date: Sun, 19 Jan 2003 11:32:33 +0000 (GMT)
From: David Woodhouse <dwmw2@infradead.org>
X-X-Sender: dwmw2@imladris.demon.co.uk
To: Adrian Bunk <bunk@fs.tum.de>
cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030119012938.GY10647@fs.tum.de>
Message-ID: <Pine.LNX.4.44.0301191117540.29823-100000@imladris.demon.co.uk>
MIME-Version: 1.0
Subject: Re: [2.5 patch] mics cleanups for mtd
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Jan 2003, Adrian Bunk wrote:

> Below is a cleanup for mtd:
> 
> I started with removing all #if'd code for kernels < 2.4.4.

That's a reasonable idea, I suppose -- I haven't had someone bitch about
me breaking the 2.2 uClinux build for a while now. I want to go further
than that with the block device drivers -- they'll be completely forked
for 2.4/2.5 support because it's just too ugly to try to support both.  

For most of the other code, the pain of maintaining two separate versions
just isn't justified by the marginal cleanup which this affords -- 
especially for the drivers where the _only_ difference between building 
out-of-the-box in 2.4 and not doing so is a #include <linux/mtd/compatmac.h>

> After this cleanup linux/mtd/compatmac.h contained only #include's so I 
> completely removed this file, removed all #include's of it in both the 
> mtd and jffs2 (sic) code and added the few needed #include's in the .c 
> files.

You misunderstand the purpose of this. The idea is that the code itself
can be written for the latest kernel, but people can use it on older
kernels and compatmac.h makes it OK. If you remove the #include
compatmac.h then that doesn't work; obviously :)

The extra #include does no harm -- do not remove it. Removing everything
from compatmac.h in 2.5 is OK though; just leave it almost empty (but with 
the #ifdef guard to prevent GCC from reading it more than once).

Adding the include files which were indirectly included through 
compatmac.h is also OK -- we can just 'touch' those to make it build with 
older kernels; they weren't intentionally omitted.

> Besides this I removed a few #include <stdarg.h>.

OK.

-- 
dwmw2


