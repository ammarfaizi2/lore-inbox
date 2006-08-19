Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751352AbWHSOgd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751352AbWHSOgd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 10:36:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751366AbWHSOgd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 10:36:33 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:14742 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751352AbWHSOgc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 10:36:32 -0400
Message-ID: <44E721E1.2030203@pobox.com>
Date: Sat, 19 Aug 2006 10:36:17 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Pozsar Balazs <pozsy@uhulinux.hu>
CC: Valerie Henson <val_henson@linux.intel.com>,
       Prakash Punnoor <prakash@punnoor.de>, Jiri Benc <jbenc@suse.cz>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC/PATCH] Fixes for ULi5261 (tulip driver)
References: <20050427124911.6212670f@griffin.suse.cz> <20060816191139.5d13fda8@griffin.suse.cz> <20060816174329.GC17650@ojjektum.uhulinux.hu> <200608162002.06793.prakash@punnoor.de> <20060816195345.GA12868@ojjektum.uhulinux.hu> <20060819001640.GE20111@goober> <20060819061507.GB8571@ojjektum.uhulinux.hu>
In-Reply-To: <20060819061507.GB8571@ojjektum.uhulinux.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pozsar Balazs wrote:
> --- a/drivers/net/tulip/uli526x.c	2006-07-15 21:00:43.000000000 +0200
> +++ a/drivers/net/tulip/uli526x.c	2006-08-18 15:41:00.000000000 +0200
> @@ -515,7 +515,8 @@
>  	phy_reg_reset = phy_read(db->ioaddr, db->phy_addr, 0, db->chip_id);
>  	phy_reg_reset = (phy_reg_reset | 0x8000);
>  	phy_write(db->ioaddr, db->phy_addr, 0, phy_reg_reset, db->chip_id);
> -	udelay(500);
> +	while (phy_read(db->ioaddr, db->phy_addr, 0, db->chip_id) & 0x8000)
> +		udelay(500);

You never want an infinite loop in a driver.  If, for example, the 
hardware is wedged or removed, registers will return all 1's, leading 
this loop to never end.

	Jeff


