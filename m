Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131637AbQLVGqZ>; Fri, 22 Dec 2000 01:46:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131665AbQLVGqO>; Fri, 22 Dec 2000 01:46:14 -0500
Received: from mail.sun.ac.za ([146.232.128.1]:40977 "EHLO mail.sun.ac.za")
	by vger.kernel.org with ESMTP id <S131637AbQLVGpx>;
	Fri, 22 Dec 2000 01:45:53 -0500
Date: Fri, 22 Dec 2000 08:15:19 +0200 (SAST)
From: Hans Grobler <grobh@sun.ac.za>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.0test12pre3ac4
In-Reply-To: <E149GOX-0003s3-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.30.0012220812020.7405-100000@prime.sun.ac.za>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Dec 2000, Alan Cox wrote:
> o	Quota fixes/updates				(Jan Kara)

This patch (?) to breaks compiling without quota's...


diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.13pre3/mm/vmscan.c linux.ac/mm/vmscan.c
--- linux.13pre3/mm/vmscan.c	Tue Dec 19 13:30:29 2000
+++ linux.ac/mm/vmscan.c	Thu Dec 21 21:21:00 2000
@@ -943,6 +943,7 @@
 		 */
 		shrink_dcache_memory(priority, gfp_mask);
 		shrink_icache_memory(priority, gfp_mask);
+		shrink_dqcache_memory(priority, gfp_mask);

 		/*
 		 * Then, try to page stuff out..
@@ -1004,6 +1005,7 @@
 	if (free_shortage() || inactive_shortage()) {
 		shrink_dcache_memory(6, gfp_mask);
 		shrink_icache_memory(6, gfp_mask);
+		shrink_dqcache_memory(6, gfp_mask);
 		ret += refill_inactive(gfp_mask, user);
 	} else {
 		/*




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
