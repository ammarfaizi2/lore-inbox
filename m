Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315541AbSEHGsF>; Wed, 8 May 2002 02:48:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315542AbSEHGsC>; Wed, 8 May 2002 02:48:02 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:17603 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S315541AbSEHGrv>;
	Wed, 8 May 2002 02:47:51 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15576.51389.931803.495093@argo.ozlabs.ibm.com>
Date: Wed, 8 May 2002 16:42:05 +1000 (EST)
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] IDE 58
In-Reply-To: <3CD7ECB9.9050606@evision-ventures.com>
X-Mailer: VM 6.75 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Dalecki writes:

> - Virtualize the udma_enable method as well to help ARM and PPC people.  Please
>    please if you would like to have some other methods virtualized in a similar
>    way - just tell me or even better do it yourself at the end of ide-dma.c.
>    I *don't mind* patches.
> 
> - Fix the pmac code to adhere to the new API. It's supposed to work again.
>    However this is blind coding... I give myself 80% chances for it to work ;-).

OK, now I am truly impressed.  Not only does it compile cleanly, it
works first go!

I am using the tiny patch below, it sets the unmask flag so interrupts
will be unmasked by default (which is safe on powermacs).

Thanks,
Paul.

diff -urN linux-2.5/drivers/ide/ide-pmac.c pmac-2.5/drivers/ide/ide-pmac.c
--- linux-2.5/drivers/ide/ide-pmac.c	Wed May  8 16:40:17 2002
+++ pmac-2.5/drivers/ide/ide-pmac.c	Wed May  8 08:26:48 2002
@@ -343,6 +343,7 @@
 			ide_hwifs[ix].autodma = 1;
 #endif
 	}
+	ide_hwifs[ix].unmask = 1;
 }
 
 #if 0
