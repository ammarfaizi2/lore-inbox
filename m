Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261449AbULIDor@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261449AbULIDor (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 22:44:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261450AbULIDor
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 22:44:47 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:21004 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261449AbULIDop (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 22:44:45 -0500
Date: Thu, 9 Dec 2004 04:44:38 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: IDE: strange WAIT_READY dependency on APM
Message-ID: <20041209034438.GF22324@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IDE contains the following strange code:

<--  snip  -->

#if defined(CONFIG_APM) || defined(CONFIG_APM_MODULE)
#define WAIT_READY      (5*HZ)          /* 5sec - some laptops are very slow */
#else
#define WAIT_READY      (HZ/10)         /* 100msec - should be instantaneous */
#endif /* CONFIG_APM || CONFIG_APM_MODULE */

<--  snip  -->

On the one hand APM isn't enabled on all laptops.
On the other hand, this also affects regular PCs with APM support (or 
using a distribution kernel with APM support).

The time for the !APM case was already increased from 30msec in 2.4 .
Isn't there a timeout that is suitable for all cases?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

