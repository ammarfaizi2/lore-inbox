Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262738AbUKAPNs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262738AbUKAPNs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 10:13:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265981AbUKAOnl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 09:43:41 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:25612 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S265244AbUKAOdL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 09:33:11 -0500
Date: Mon, 1 Nov 2004 15:32:38 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Paul Dickson <dickson@permanentmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc1: drivers/ide/ide-dma.o: value of -130 too large for field of 1 bytes at 911
Message-ID: <20041101143238.GR2495@stusta.de>
References: <20041101035402.556616d2.dickson@permanentmail.com> <20041101121256.GK2495@stusta.de> <20041101064828.1d67078a.dickson@permanentmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041101064828.1d67078a.dickson@permanentmail.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 01, 2004 at 06:48:28AM -0700, Paul Dickson wrote:
> On Mon, 1 Nov 2004 13:12:56 +0100, Adrian Bunk wrote:
> 
> > On Mon, Nov 01, 2004 at 03:54:02AM -0700, Paul Dickson wrote:
> > > With the attached .config, I'm getting this while compiling...
> > > 
> > >...
> > >   CC      drivers/ide/ide-dma.o
> > > {standard input}: Assembler messages:
> > > {standard input}:607: Error: value of -130 too large for field of 1 bytes at 911
> > > make[3]: *** [drivers/ide/ide-dma.o] Error 1
> > > make[2]: *** [drivers/ide] Error 2
> > > make[1]: *** [drivers] Error 2
> > > make: *** [bzImage] Error 2
> > > 
> > > I got the same error with 2.6.9 too.
> > > 
> > > GCC 3.2.2 and 3.4.1.
> > > 
> > > Has this been fixed since 2.6.10-rc1?  Searching my Linux-Kernel folder
> > > didn't find a match.
> > 
> > I can't reproduce it with your .config in 2.6.10-rc1.
> > 
> > Please send the output of ./scripts/ver_linux .
> 
> The problem does not occur if I unselect "Generic PCI bus-master DMA
> support".

That's not a surprise since in this case ide-dma.c won't be included 
into your kernel.

> I'm also using 0=../out.router.20041030 for an external directory:
>     make O=../out.router.20041030/ bzImage

Works for me...

> >From the FC2 system:
>...
> >From the RH9 system:
>...

The systems seem to be different enough for ruling out a problem with a 
specific compiler or assembler version (in both cases, my versions 
are between your versions).

You don't have _any_ patches applied?
Your kernel comes directly from ftp.kernel.org (or one of it's mirrors)?

Does unsetting
  General setup
    Configure standard kernel features (for small systems)
      Optimize for size
help?

Please do the following:
- make V=1 O=../out.router.20041030/ bzImage
- cd ../out.router.20041030/
- the first command should have given you the failed gcc command;
  run it with the following changes:
  - replace "-c" with "-S"
  - replace "ide-dma.o" with "ide-dma.s"
- send me the resulting file drivers/ide/ide-dma.s
  (please Cc linux-kernel)

> 	-Paul

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

