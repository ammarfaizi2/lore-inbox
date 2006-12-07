Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1032071AbWLGLes@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032071AbWLGLes (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 06:34:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032073AbWLGLes
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 06:34:48 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:1352 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1032067AbWLGLeq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 06:34:46 -0500
Date: Thu, 7 Dec 2006 12:34:52 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: jgarzik@pobox.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: drivers/net/chelsio/my3126.c: inconsequent NULL checking
Message-ID: <20061207113452.GD8963@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Coverity checker spotted the following inconsequent NULL checking 
introduced by commit f1d3d38af75789f1b82969b83b69cab540609789:

<--  snip  -->

...
static struct cphy *my3126_phy_create(adapter_t *adapter,
                        int phy_addr, struct mdio_ops *mdio_ops)
{
        struct cphy *cphy = kzalloc(sizeof (*cphy), GFP_KERNEL);

        if (cphy)
                cphy_init(cphy, adapter, phy_addr, &my3126_ops, mdio_ops);

        INIT_WORK(&cphy->phy_update, my3216_poll, cphy);
        cphy->bmsr = 0;

        return (cphy);
}
...

<--  snip  -->

It doesn't make sense to first check whether "cphy" is NULL and 
dereference it unconditionally later.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

