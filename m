Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262789AbSJEXBS>; Sat, 5 Oct 2002 19:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262793AbSJEXBS>; Sat, 5 Oct 2002 19:01:18 -0400
Received: from mailb.telia.com ([194.22.194.6]:18897 "EHLO mailb.telia.com")
	by vger.kernel.org with ESMTP id <S262789AbSJEXBR>;
	Sat, 5 Oct 2002 19:01:17 -0400
X-Original-Recipient: linux-kernel@vger.kernel.org
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       David Woodhouse <dwmw2@infradead.org>
Subject: Re: Linux v2.5.40 - and a feature freeze reminder
References: <Pine.LNX.4.33.0210010021400.25527-100000@penguin.transmeta.com>
From: Peter Osterlund <petero2@telia.com>
Date: 06 Oct 2002 01:06:39 +0200
In-Reply-To: <Pine.LNX.4.33.0210010021400.25527-100000@penguin.transmeta.com>
Message-ID: <m2r8f47af4.fsf@p4.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

> Merges with all the regular suspects - Al's partitioning, Andrew on VM, 
> USB, networking, sparc, net drivers.

My PCMCIA network card no longer works. During boot, I see this
message:

        ds: no socket drivers loaded

It worked in 2.5.39. Also this patch helps, although I don't
understand why it is now needed:

--- linux/drivers/pcmcia/ds.c.old	Sun Oct  6 01:00:38 2002
+++ linux/drivers/pcmcia/ds.c	Sun Oct  6 00:53:23 2002
@@ -894,9 +894,9 @@
      * Ugly. But we want to wait for the socket threads to have started up.
      * We really should let the drivers themselves drive some of this..
      */
     current->state = TASK_INTERRUPTIBLE;
-    schedule_timeout(HZ/10);
+    schedule_timeout(HZ/4);
 
     pcmcia_get_card_services_info(&serv);
     if (serv.Revision != CS_RELEASE_CODE) {
 	printk(KERN_NOTICE "ds: Card Services release does not match!\n");

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
