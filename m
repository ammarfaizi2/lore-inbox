Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314288AbSEFIzW>; Mon, 6 May 2002 04:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314291AbSEFIzW>; Mon, 6 May 2002 04:55:22 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:63749 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S314288AbSEFIzT>;
	Mon, 6 May 2002 04:55:19 -0400
Message-ID: <3CD64562.9AB4D3D7@zip.com.au>
Date: Mon, 06 May 2002 01:57:06 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Brian Gerst <bgerst@didntduck.org>
CC: Linus Torvalds <torvalds@transmeta.com>, Dave Jones <davej@suse.de>,
        Linux-Kernel <linux-kernel@vger.kernel.org>,
        Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] percpu updates
In-Reply-To: <3CD06ACE.1090402@didntduck.org> <3CD4B042.A4355FD3@zip.com.au> <3CD55FF0.2030909@didntduck.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Gerst wrote:
> 
> Andrew Morton wrote:
> > Brian Gerst wrote:
> >
> >>These patches convert some of the existing arrays based on NR_CPUS to
> >>use the new per cpu code.
> >>
> ...
> Andrew, could you try this patch?  I suspect something in setup_arch()
> is touching the per cpu area before it gets copied for the other cpus.
> This patch makes certain the boot cpu area is setup ASAP.

This little recidivist is still using gcc-2.91.66.  It is not
placing the percpu data in the correct section.  It is not 
entirely obvious why.

I downgraded to 2.95.3 (build time went from 2:45 to 3:15, giving
nothing in return) and Brian's patch worked OK.

ho hum.  So.  2.91.66, rest in peace.  I shall miss you.


--- linux-2.5.14/init/main.c	Tue Apr 30 17:56:30 2002
+++ 25/init/main.c	Mon May  6 01:55:32 2002
@@ -51,7 +51,7 @@
  * To avoid associated bogus bug reports, we flatly refuse to compile
  * with a gcc that is known to be too old from the very beginning.
  */
-#if __GNUC__ < 2 || (__GNUC__ == 2 && __GNUC_MINOR__ < 91)
+#if __GNUC__ < 2 || (__GNUC__ == 2 && __GNUC_MINOR__ < 95)
 #error Sorry, your GCC is too old. It builds incorrect kernels.
 #endif
 

-
