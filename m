Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267343AbTALJXb>; Sun, 12 Jan 2003 04:23:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267344AbTALJXb>; Sun, 12 Jan 2003 04:23:31 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:8651 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S267343AbTALJXV>; Sun, 12 Jan 2003 04:23:21 -0500
Date: Sun, 12 Jan 2003 10:32:05 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       support@moxa.com.tw
Subject: Re: 2.5.55: static compilation of mxser.c doesn't work
Message-ID: <20030112093205.GS21826@fs.tum.de>
References: <20030110140313.GL6626@fs.tum.de> <1042211563.31612.0.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1042211563.31612.0.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2003 at 03:12:43PM +0000, Alan Cox wrote:
> On Fri, 2003-01-10 at 14:03, Adrian Bunk wrote:
> > Hi Arnaldo,
> > 
> > the 2.5 Linux kernel contains your patch
> > 
> >    o mxser: add module_exit/module_init
> >    This fixes the compilation problem in 2.5
> > 
> > This patch renames mxser_init to mxser_module_init causing a compile 
> > error when trying to compile this driver statically into the kernel 
> > since mxser_init is still called from drivers/char/tty_io.c.
> 
> You should be able to kill the call from tty_io.c

Unfortunately I don't have the hardware to test whether the driver 
actually works but the patch below fixes the compilation.

cu
Adrian

--- linux-2.5.56/drivers/char/tty_io.c.old	2003-01-12 10:15:39.000000000 +0100
+++ linux-2.5.56/drivers/char/tty_io.c	2003-01-12 10:16:14.000000000 +0100
@@ -2372,9 +2372,6 @@
 	rs_8xx_init();
 #endif /* CONFIG_8xx */
 	pty_init();
-#ifdef CONFIG_MOXA_SMARTIO
-	mxser_init();
-#endif	
 #ifdef CONFIG_MOXA_INTELLIO
 	moxa_init();
 #endif	
