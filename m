Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751129AbWICOAw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129AbWICOAw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 10:00:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751155AbWICOAw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 10:00:52 -0400
Received: from mtiwmhc13.worldnet.att.net ([204.127.131.117]:49116 "EHLO
	mtiwmhc13.worldnet.att.net") by vger.kernel.org with ESMTP
	id S1751129AbWICOAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 10:00:51 -0400
Message-ID: <44FAE00B.6030701@lwfinger.net>
Date: Sun, 03 Sep 2006 09:00:43 -0500
From: Larry Finger <Larry.Finger@lwfinger.net>
User-Agent: Thunderbird 1.5.0.5 (X11/20060725)
MIME-Version: 1.0
To: Miles Lane <miles.lane@gmail.com>
CC: Michael Buesch <mb@bu3sch.de>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>, linville@tuxdriver.com
Subject: Re: 2.6.18-rc5-mm1 -- bcm43xx: Out of DMA descriptor slots!
References: <a44ae5cd0609030218y547e1c94pd7ba5337e1a27b2b@mail.gmail.com> <200609031433.49658.mb@bu3sch.de>
In-Reply-To: <200609031433.49658.mb@bu3sch.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Buesch wrote:
> On Sunday 03 September 2006 11:18, Miles Lane wrote:
>> Michael, I think this is related to your code (bcm43xx_dma.c).  It is
>> quite possible that the bug isn't in your code, but rather in the
>> general management of DMA.
> 
> Please try latest wireless-2.6 tree. I think it has a bugfix for this.

There is a fix (commit 653d5b55c0125dca97a420b9a5e77fad7adbf3f0) for mac_suspended assertions in the
latest wireless-2.6. If you just want that fix, use the following:

Index: wireless-2.6/drivers/net/wireless/bcm43xx/bcm43xx_main.c
===================================================================
--- wireless-2.6.orig/drivers/net/wireless/bcm43xx/bcm43xx_main.c
+++ wireless-2.6/drivers/net/wireless/bcm43xx/bcm43xx_main.c
@@ -3349,6 +3349,8 @@
     memset(bcm->dma_reason, 0, sizeof(bcm->dma_reason));
     bcm->irq_savedstate = BCM43xx_IRQ_INITIAL;

+    bcm->mac_suspended = 1;
+
     /* Noise calculation context */
     memset(&bcm->noisecalc, 0, sizeof(bcm->noisecalc));


If this patch is already in your code, and you are still getting the assertions, please let me know.

Larry


-- 
VGER BF report: H 0.427049
