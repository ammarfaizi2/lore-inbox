Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129257AbQK3XI4>; Thu, 30 Nov 2000 18:08:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129572AbQK3XIg>; Thu, 30 Nov 2000 18:08:36 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:2633 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129257AbQK3XI3>; Thu, 30 Nov 2000 18:08:29 -0500
Date: Thu, 30 Nov 2000 23:37:42 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Phillip Ezolt <ezolt@perf.zko.dec.com>
Cc: axp-list@redhat.com, rth@twiddle.net, Jay.Estabrook@compaq.com,
        linux-kernel@vger.kernel.org, clinux@zk3.dec.com,
        wcarr@perf.zko.dec.com
Subject: Re: Alpha SCSI error on 2.4.0-test11
Message-ID: <20001130233742.A21823@athlon.random>
In-Reply-To: <20001201004049.A980@jurassic.park.msu.ru> <Pine.OSF.3.96.1001130171941.32335D-100000@perf.zko.dec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.OSF.3.96.1001130171941.32335D-100000@perf.zko.dec.com>; from ezolt@perf.zko.dec.com on Thu, Nov 30, 2000 at 05:26:58PM -0500
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2000 at 05:26:58PM -0500, Phillip Ezolt wrote:
> I'll give test12-pre3 a try and see if it fixes things.

test12-pre2 crashes at boot on my DS20. This patch workaround the problem
but I would be _very_ surprised if this is the right fix :) It's obviously not
meant for inclusion.

--- 2.4.0-test12-pre2-alpha/drivers/pci/setup-res.c.~1~	Tue Nov 28 18:40:29 2000
+++ 2.4.0-test12-pre2-alpha/drivers/pci/setup-res.c	Wed Nov 29 03:15:45 2000
@@ -148,8 +148,11 @@
 			continue;
 		for (list = head; ; list = list->next) {
 			unsigned long size = 0;
-			struct resource_list *ln = list->next;
+			struct resource_list *ln;
 
+			if (!list)
+				return;
+			ln = list->next;
 			if (ln)
 				size = ln->res->end - ln->res->start;
 			if (r->end - r->start > size) {


I prefer to finish the ASN SMP rework before looking into this.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
