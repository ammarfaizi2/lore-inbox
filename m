Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318746AbSH1H1s>; Wed, 28 Aug 2002 03:27:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318747AbSH1H1s>; Wed, 28 Aug 2002 03:27:48 -0400
Received: from d136-ps2-mel.alphalink.com.au ([202.161.107.136]:7041 "HELO
	spunk.spunk") by vger.kernel.org with SMTP id <S318746AbSH1H1r>;
	Wed, 28 Aug 2002 03:27:47 -0400
Date: Wed, 28 Aug 2002 17:41:24 +1000
From: Edward Coffey <ecoffey@alphalink.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux v2.5.32
Message-ID: <20020828074124.GA1476@spunk>
References: <Pine.LNX.4.33.0208271239580.2564-100000@penguin.transmeta.com> <Pine.LNX.4.33.0208271239580.2564-100000@penguin.transmeta.com> <20020827202250.GA24265@debian> <6e0.3d6be706.b5d05@gzp1.gzp.hu> <20020828061827.GB27967@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020828061827.GB27967@lug-owl.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2002 at 08:18:27AM +0200, Jan-Benedict Glaw wrote:
> On Tue, 2002-08-27 20:54:30 -0000, Gabor Z. Papp <gzp@myhost.mynet>
> wrote in message <6e0.3d6be706.b5d05@gzp1.gzp.hu>:
> >   gcc -Wp,-MD,./.8250.o.d -D__KERNEL__ -I/usr/src/linux-2.5.32-gzp3/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -nostdinc -iwithprefix include -DMODULE -include /usr/src/linux-2.5.32-gzp3/include/linux/modversions.h   -DKBUILD_BASENAME=8250 -DEXPORT_SYMTAB  -c -o 8250.o 8250.c
> > In file included from 8250.c:34:
> > /usr/src/linux-2.5.32-gzp3/include/linux/serialP.h:50: field `icount' has incomplete type
> 
> Header file problem. In serialP.h, right at the beginning, there's a
> version check, which unfortunately is in wrong direction. No sources
> available, no patch...

Guessing it wants to be (LINUX_VERSION_CODE >= 0x020300) rather than
(LINUX_VERSION_CODE < 0x020300):

--- linux.orig/include/linux/serialP.h  Sun Jun  9 15:27:21 2002
+++ linux/include/linux/serialP.h       Wed Aug 28 17:03:18 2002
@@ -24,7 +24,7 @@
 #include <linux/tqueue.h>
 #include <linux/circ_buf.h>
 #include <linux/wait.h>
-#if (LINUX_VERSION_CODE < 0x020300)
+#if (LINUX_VERSION_CODE >= 0x020300)
 /* Unfortunate, but Linux 2.2 needs async_icount defined here and
  * it got moved in 2.3 */
 #include <linux/serial.h>
