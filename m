Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750794AbWDDSoW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794AbWDDSoW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 14:44:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750795AbWDDSoW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 14:44:22 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:24335 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750791AbWDDSoV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 14:44:21 -0400
Date: Tue, 4 Apr 2006 20:44:18 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Martin Langer <martin-langer@gmx.de>, Stefano Brivio <st3@riseup.net>,
       Michael Buesch <mbuesch@freenet.de>,
       Danny van Dyk <kugelfang@gentoo.org>,
       Andreas Jaggi <andreas.jaggi@waterwave.ch>
Cc: jgarzik@pobox.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       linville@tuxdriver.com
Subject: bcm43xx_power.c: uninitialized variable used
Message-ID: <20060404184418.GU6529@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Coverity checker found this case where the variable "tmp" is used 
uninitialized:

<--  snip  -->

...
static int bcm43xx_pctl_clockfreqlimit(struct bcm43xx_private *bcm,
                                       int get_max)
{
        int limit = 0;
        int divisor;
        int selection;
        int err;
        u32 tmp;
        struct bcm43xx_coreinfo *old_core;

        if (!(bcm->chipcommon_capabilities & BCM43xx_CAPABILITIES_PCTL))
                goto out;
        old_core = bcm->current_core;
        err = bcm43xx_switch_core(bcm, &bcm->core_chipcommon);
        if (err)
                goto out;

        if (bcm->current_core->rev < 6) {
...
        } else if (bcm->current_core->rev < 10) {
                selection = (tmp & 0x07);
...

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

