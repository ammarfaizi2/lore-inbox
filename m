Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312505AbSEDLnT>; Sat, 4 May 2002 07:43:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312526AbSEDLnT>; Sat, 4 May 2002 07:43:19 -0400
Received: from [195.223.140.120] ([195.223.140.120]:11130 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S312505AbSEDLnR>; Sat, 4 May 2002 07:43:17 -0400
Date: Sat, 4 May 2002 13:44:11 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre8aa1 & vm-34: blkmtd.c compile failure
Message-ID: <20020504134411.T1396@dualathlon.random>
In-Reply-To: <20020503203738.E1396@dualathlon.random> <3CD32A4A.D8E86725@eyal.emu.id.au> <20020504090929.J1396@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 04, 2002 at 09:09:29AM +0200, Andrea Arcangeli wrote:
> On Sat, May 04, 2002 at 10:24:42AM +1000, Eyal Lebedinsky wrote:
> > Andrea Arcangeli wrote:
> > > 
> > > Full patchkit:
> > > http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19pre8aa1.gz
> > 
> > 'struct kiobuf' does not have a member 'blocks', used in two places.
> > 
> > Should it use 'kio_blocks'?
> 
> yes. What are the two places?

never mind, this should fix it:

--- 2.4.19pre8aa2/drivers/mtd/devices/blkmtd.c.~1~	Mon Feb 25 22:05:07 2002
+++ 2.4.19pre8aa2/drivers/mtd/devices/blkmtd.c	Sat May  4 13:43:01 2002
@@ -235,7 +235,7 @@
     return -ENOMEM;
   }
 #else 
-  blocks = iobuf->blocks;
+  blocks = iobuf->kio_blocks;
 #endif
 
   iobuf->offset = 0;
@@ -329,7 +329,7 @@
     return 0;
   }
 #else 
-  blocks = iobuf->blocks;
+  blocks = iobuf->kio_blocks;
 #endif
 
   DEBUG(2, "blkmtd: writetask: entering main loop\n");

Andrea
