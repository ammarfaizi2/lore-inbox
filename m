Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261301AbVCYB67@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261301AbVCYB67 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 20:58:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261296AbVCYAsz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 19:48:55 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:55056 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261304AbVCYAPq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 19:15:46 -0500
Date: Fri, 25 Mar 2005 01:15:45 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/net/wireless/airo.c: correct a wrong check
Message-ID: <20050325001545.GG3966@stusta.de>
References: <20050322220540.GS1948@stusta.de> <42409971.5010704@pobox.com> <20050322223056.GV1948@stusta.de> <20050322223403.GA19026@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050322223403.GA19026@havoc.gtf.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2005 at 05:34:03PM -0500, Jeff Garzik wrote:
> On Tue, Mar 22, 2005 at 11:30:56PM +0100, Adrian Bunk wrote:
>...
> > Is this "if" simply superfluous?
> > Or should the && be an || ?
> 
> Yes, it looks like it should be "||".

Patch below.

> 	Jeff

cu
Adrian


<--  snip  -->


The Coverity checker correctly noted that this condition can't ever be 
fulfilled.

This patch changes it to what it should have been.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.12-rc1-mm1-full/drivers/net/wireless/airo.c.old	2005-03-22 21:41:37.000000000 +0100
+++ linux-2.6.12-rc1-mm1-full/drivers/net/wireless/airo.c	2005-03-22 22:50:03.000000000 +0100
@@ -3440,7 +3440,7 @@
 	/* Make sure we got something */
 	if (rxd.rdy && rxd.valid == 0) {
 		len = rxd.len + 12;
-		if (len < 12 && len > 2048)
+		if (len < 12 || len > 2048)
 			goto badrx;
 
 		skb = dev_alloc_skb(len);
