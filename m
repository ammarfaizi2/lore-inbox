Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264744AbSKEJLo>; Tue, 5 Nov 2002 04:11:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264765AbSKEJLo>; Tue, 5 Nov 2002 04:11:44 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:63237 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264744AbSKEJLo>; Tue, 5 Nov 2002 04:11:44 -0500
Date: Tue, 5 Nov 2002 09:18:17 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Miles Bader <miles@gnu.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.46: drivers/mtd/mtdblock.c won't compile -- misordered declaration
Message-ID: <20021105091817.A18670@flint.arm.linux.org.uk>
Mail-Followup-To: Miles Bader <miles@gnu.org>, linux-kernel@vger.kernel.org
References: <buod6ppj20y.fsf@mcspd15.ucom.lsi.nec.co.jp> <buobs54ipzx.fsf@mcspd15.ucom.lsi.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <buobs54ipzx.fsf@mcspd15.ucom.lsi.nec.co.jp>; from miles@lsi.nec.co.jp on Tue, Nov 05, 2002 at 01:45:22PM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05, 2002 at 01:45:22PM +0900, Miles Bader wrote:
> [This is a repost of my earlier message, since the problem doesn't seem
>  to have been fixed in 2.5.46; could someone please look at this?
>  I don't think it should be controversial...]
> 
> When I compile 2.5.45, I get the following errors:

It'll be fixed in 2.5.47 - Linus has already incorporated the following.
I just missed 2.5.46 by a few hours (because I normally send my requests
to Linus at around 11pm - Midnight GMT.)

# --------------------------------------------
# 02/11/04	rmk@flint.arm.linux.org.uk	1.896
# [MTD] Fix mtdblock.c build error
# Move spin_unlock_irq() down one line.
# --------------------------------------------
diff -Nru a/drivers/mtd/mtdblock.c b/drivers/mtd/mtdblock.c
--- a/drivers/mtd/mtdblock.c	Mon Nov  4 22:56:17 2002
+++ b/drivers/mtd/mtdblock.c	Mon Nov  4 22:56:17 2002
@@ -394,8 +394,8 @@
 
 	while (!blk_queue_empty(&mtd_queue)) {
 		struct request *req = elv_next_request(&mtd_queue);
-		spin_unlock_irq(mtd_queue.queue_lock);
 		struct mtdblk_dev **p = req->rq_disk->private_data;
+		spin_unlock_irq(mtd_queue.queue_lock);
 		mtdblk = *p;
 		res = 0;
 


-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

