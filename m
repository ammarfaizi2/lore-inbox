Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261985AbUJYPif@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261985AbUJYPif (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 11:38:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261982AbUJYPhd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 11:37:33 -0400
Received: from natsmtp00.rzone.de ([81.169.145.165]:10470 "EHLO
	natsmtp00.rzone.de") by vger.kernel.org with ESMTP id S261994AbUJYPgV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 11:36:21 -0400
Date: Mon, 25 Oct 2004 17:36:15 +0200
From: Dominik Brodowski <linux@dominikbrodowski.de>
To: Stelian Pop <stelian@popies.net>, jgarzik@pobox.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pcmcia network drivers cleanup
Message-ID: <20041025153615.GA7730@dominikbrodowski.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.de>,
	Stelian Pop <stelian@popies.net>, jgarzik@pobox.com,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20041025152121.GA7647@dominikbrodowski.de> <20041025153038.GF3161@crusoe.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041025153038.GF3161@crusoe.alcove-fr>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2004 at 05:30:38PM +0200, Stelian Pop wrote:
> > #define INT_MODULE_PARM(n, v) static int n = v; MODULE_PARM(n, "i")
> > 
> > static int irq_list[4] = { -1 };
> > MODULE_PARM(irq_list, "1-4i");
> > INT_MODULE_PARM(irq_mask,	0xdeb8);
> > 
> > block being replaced with
> > 
> > 
> > static int irq_list[4] = { -1 };
> > static int irq_mask irq_mask = 0xdeb8;
> > 
> > module_parm(irq_mask, int, 0444};
> 
> Sure, it is probably saner, but INT_MODULE_PARM is used for quite a
> few other parameters in each driver, and I didn't want to touch
> all of them.

You need to convert all paramters at once, as MODULE_PARM and module_parm()
can't exist in the same module at the same time anyway. Also, as all
INT_MODULE_PARMs were defined to be MODULE_PARM, it should be safe to do so.

Thanks,
	Dominik
