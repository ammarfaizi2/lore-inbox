Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132808AbRDUSSm>; Sat, 21 Apr 2001 14:18:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132807AbRDUSSc>; Sat, 21 Apr 2001 14:18:32 -0400
Received: from asterix.hrz.tu-chemnitz.de ([134.109.132.84]:65513 "EHLO
	asterix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S132804AbRDUSSV>; Sat, 21 Apr 2001 14:18:21 -0400
Date: Sat, 21 Apr 2001 20:18:15 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Christoph Hellwig <hch@ns.caldera.de>
Cc: linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: Re: rwsem.o listed twice as export-objs
Message-ID: <20010421201815.U719@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <20010420215330.N682@nightmaster.csn.tu-chemnitz.de> <200104211606.SAA06630@ns.caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <200104211606.SAA06630@ns.caldera.de>; from hch@ns.caldera.de on Sat, Apr 21, 2001 at 06:06:34PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 21, 2001 at 06:06:34PM +0200, Christoph Hellwig wrote:
> In article <20010420215330.N682@nightmaster.csn.tu-chemnitz.de> you wrote:
> > please remove rwsem.o from the list of exported objects, if it is
> > not used.
> 
> No!  The whole point of 'export-objs' is to _always_ list the objects there
> to make the makefiles smaller and cleaner.

Ok, so this patch is better?

--- linux/lib/Makefile.orig       Sat Apr 21 20:15:00 2001
+++ linux/lib/Makefile    Sat Apr 21 20:14:37 2001
@@ -8,12 +8,11 @@

 L_TARGET := lib.a

 export-objs := cmdline.o rwsem.o

 obj-y := errno.o ctype.o string.o vsprintf.o brlock.o cmdline.o bust_spinlocks.o

 ifneq ($(CONFIG_RWSEM_GENERIC_SPINLOCK)$(CONFIG_RWSEM_XCHGADD_ALGORITHM),nn)
-export-objs += rwsem.o
 obj-y += rwsem.o
 endif



Because any of the solutions should be applied, because rwsem.o
is listed twice currently, which gives a warning at compile time.

Regards

Ingo Oeser
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<     been there and had much fun   >>>>>>>>>>>>
