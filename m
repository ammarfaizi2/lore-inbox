Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267199AbUGaPVp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267199AbUGaPVp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 11:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267697AbUGaPVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 11:21:45 -0400
Received: from staff.cs.usyd.edu.au ([129.78.8.1]:26102 "helo
	staff.cs.usyd.edu.au") by vger.kernel.org with SMTP id S267199AbUGaPVn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 11:21:43 -0400
Message-Id: <200407311521.i6VFLcOC022100@nlp0.cs.usyd.edu.au>
Date: Sun, 01 Aug 2004 00:48:22 +1000
From: bruce@it.usyd.edu.au (Bruce Janson)
Subject: 2.6.7 kernel boot-time configuration of a non-modular tulip driver
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a linux 2.6.7 kernel which contains a compiled-in tulip driver.
I would like to be able to boot the kernel with parameters that
will allow control of the tulip device.  On some ethernet devices
this used to be possible via (something like):

  ether=0,0,1,0,eth0

which would pass the four numeric parameters (as, I think, dev->irq,
dev->ioaddr, dev->mem_start and dev->mem_end) to the net driver that
controlled eth0.  A convention adopted by some net drivers then allowed
dev->mem_start to be interpretted as a set of flags that would control
device characteristics (e.g. full-duplex vs half-duplex mode).
In .../linux-2.6.7/drivers/net/tulip/tulip_core.c:1587:

  if (dev->mem_start & MEDIA_MASK)
    tp->default_port = dev->mem_start & MEDIA_MASK;

suggests that this might still work.  However, I have been unable
to force dev->mem_start in that driver to become non-zero via any
kernel boot-time parameters.  My limited understanding of the code
that precedes the above lines in that file suggests that the "dev"
structure is not what it used to be...

../linux-2.6.7/Documentation/kernel-parameters.txt:402 still
mentions "ether=..." but marks it as obsolete, replaced by
the equivalent "netdev=...".  Elsewhere in that file, the entry
for "netdev=..." describes what appears to be the functionality
that I seek.

So, is it still possible to perform the same sort of control
operations on a tulip driver via kernel boot-time parameters
as one can do via module load-time parameters?  If so, how?
