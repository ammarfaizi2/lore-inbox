Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262161AbVCVWcs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262161AbVCVWcs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 17:32:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262157AbVCVWbz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 17:31:55 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:25357 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262249AbVCVWbB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 17:31:01 -0500
Date: Tue, 22 Mar 2005 23:30:56 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] drivers/net/wireless/airo.c: correct a wrong
Message-ID: <20050322223056.GV1948@stusta.de>
References: <20050322220540.GS1948@stusta.de> <42409971.5010704@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42409971.5010704@pobox.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2005 at 05:17:21PM -0500, Jeff Garzik wrote:
> Adrian Bunk wrote:
> >if
> >Reply-To: 
> >
> >The Coverity checker correctly noted that this condition can't ever be 
> >fulfilled.
> >
> >Can someone understanding this code check whether my guess what this 
> >should have been was right?
> >
> >Or should the if get completely dropped?
> >
> >Signed-off-by: Adrian Bunk <bunk@stusta.de>
> >
> >--- linux-2.6.12-rc1-mm1-full/drivers/net/wireless/airo.c.old	2005-03-22 
> >21:41:37.000000000 +0100
> >+++ linux-2.6.12-rc1-mm1-full/drivers/net/wireless/airo.c	2005-03-22 
> >21:42:01.000000000 +0100
> >@@ -3440,9 +3440,6 @@
> > 	/* Make sure we got something */
> > 	if (rxd.rdy && rxd.valid == 0) {
> > 		len = rxd.len + 12;
> >-		if (len < 12 && len > 2048)
> >-			goto badrx;
> 
> Coverity is silly.
> 
> len is signed, and so can obviously be less than zero in edge cases.  I 
> don't see where the "> 2048" test is invalid, either.

But if it's less than zero it can't be > 2048 at the same time?

The point is: len can't be both < 12 and > 2048 at the same time.


Is this "if" simply superfluous?
Or should the && be an || ?


> 	Jeff

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

