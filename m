Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265126AbTAJO3q>; Fri, 10 Jan 2003 09:29:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265097AbTAJO3q>; Fri, 10 Jan 2003 09:29:46 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:30703 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S265126AbTAJO3p>; Fri, 10 Jan 2003 09:29:45 -0500
Date: Fri, 10 Jan 2003 15:38:25 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Alan Cox <alan@redhat.com>, Joachim Martillo <martillo@telfordtools.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.21pre3-ac2
Message-ID: <20030110143825.GN6626@fs.tum.de>
References: <200301090139.h091d9G26412@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200301090139.h091d9G26412@devserv.devel.redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2003 at 08:39:09PM -0500, Alan Cox wrote:

>...
> Linux 2.4.21pre3-ac2
>...
> o	Driver for Aurora Sio16 PCI adapter series	(Joachim Martillo)
> 	(SIO8000P, 16000P, and CPCI)
> 	| Initial merge
>...

siolx_cleanup in drivers/char/cd1865/cd1865.c is __exit but called from 
the __init function siolx_init causing a .text.exit error when compiling 
this driver statically into the kernel. The following patch that removes 
the __exit fixes it:

--- linux-2.4.20-ac/drivers/char/cd1865/cd1865.c.old	2003-01-10 15:31:41.000000000 +0100
+++ linux-2.4.20-ac/drivers/char/cd1865/cd1865.c	2003-01-10 15:32:26.000000000 +0100
@@ -2630,7 +2630,7 @@
 }
 
 
-static void __exit siolx_cleanup(void)
+static void siolx_cleanup(void)
 {
 	siolx_release_drivers();
 	siolx_release_memory();


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

