Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131511AbRBKBjU>; Sat, 10 Feb 2001 20:39:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131549AbRBKBjK>; Sat, 10 Feb 2001 20:39:10 -0500
Received: from kwalitee.nolab.conman.org ([208.143.53.154]:37224 "EHLO
	nolab.conman.org") by vger.kernel.org with ESMTP id <S131511AbRBKBjD>;
	Sat, 10 Feb 2001 20:39:03 -0500
Date: Sat, 10 Feb 2001 20:38:55 -0500 (EST)
From: Mark Grosberg <myg@nolab.conman.org>
To: linux-kernel@vger.kernel.org
Subject: Bug in AMI Raid controller, Linux 2.4
Message-ID: <Pine.LNX.4.04.10102102035090.8227-100000@kwalitee.nolab.conman.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello all, forgive me if this has already been discovered...

I think I have found a bug in the AMI Megatrends RAID controller driver,
scsi/megaraid.c.

If I look in the old, 2.2.x code, in the routine mega_findCard, I find:

    if (flag != BOARD_QUARTZ) {
      /* Request our IO Range */
      if (check_region (megaBase, 16)) {
        printk (KERN_WARNING "megaraid: Couldn't register I/O range!" ...
        scsi_unregister (host);
        continue;
      }
     request_region (megaBase, 16, "megaraid");

And in the 2.4.1 code, same routine, I find:

         if (flag != BOARD_QUARTZ) {
      /* Request our IO Range */
      if (request_region (megaBase, 16, "megaraid")) {
        printk (KERN_WARNING "megaraid: Couldn't register I/O range!" ...
        scsi_unregister (host);
        continue;
      }
    }

I think the code is missing a "!" in front of request_region(). It seems
that the 2.4.1 kernel does not recognize my RAID controller where as
2.2.x does. 

L8r,
Mark G.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
