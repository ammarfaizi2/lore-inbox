Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264606AbTFANjY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 09:39:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264622AbTFANjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 09:39:24 -0400
Received: from postfix4-1.free.fr ([213.228.0.62]:30610 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S264606AbTFANjW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 09:39:22 -0400
Subject: Re: 2.4.18 /dev/random problem
From: Philippe Amelant <philippe.amelant@free.fr>
To: linux-kernel@vger.kernel.org
In-Reply-To: <20030531162934.A1522@schatzie.adilger.int>
References: <1054395393.20196.211.camel@smp-tux.free.fr>
	 <20030531162934.A1522@schatzie.adilger.int>
Content-Type: text/plain; charset=ISO-8859-15
Organization: 
Message-Id: <1054475598.20196.321.camel@smp-tux.free.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 01 Jun 2003 15:53:19 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le dim 01/06/2003 à 00:29, Andreas Dilger a écrit :
> On May 31, 2003  17:36 +0200, Philippe Amelant wrote:
> > I have a compaq server with a little problem.
> > cat /proc/sys/kernel/random/entropy_avail is always 0
> > so /dev/random block on all read.
> > 
> > I have read some discussion about /dev/random on this list.
> > and if I understand /dev/urandom rely on /dev/random for providing good
> > randomness and /dev/random rely on server activity for it's entropy.
> > 
> > But I don't understand why my disk activity doesn't refill the entropy
> > counter. If I try to mount floppy I get some entropy but even updating
> > locate db does not provide any entropy ? Should I activate something in
> > disk driver ?
> 
> Maybe you only have disk drives attached via CCISS or other special
> RAID controller, and you do not use keyboard or mouse?  It might be
> that the RAID controller is not contributing to the entopy pool.

You are right.
Pasi Pirhonen provide me this little patch
Maybe it could be useful for someone else....

--- linux/drivers/block/cpqarray.c      Fri Apr  4 01:23:24 2003
+++ linux.TE/drivers/block/cpqarray.c   Fri Apr  4 01:21:04 2003
@@ -517,7 +517,7 @@
 
        hba[i]->access.set_intr_mask(hba[i], 0);
        if (request_irq(hba[i]->intr, do_ida_intr,
-               SA_INTERRUPT|SA_SHIRQ, hba[i]->devname, hba[i])) 
+               SA_INTERRUPT|SA_SHIRQ|SA_SAMPLE_RANDOM, hba[i]->devname, hba[i])) 
        {
 
                printk(KERN_ERR "cpqarray: Unable to get irq %d for %s\n", 


thank for help


