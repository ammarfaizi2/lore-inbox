Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261960AbUJYPhP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261960AbUJYPhP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 11:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261985AbUJYPeb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 11:34:31 -0400
Received: from sd291.sivit.org ([194.146.225.122]:29635 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S261960AbUJYP3X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 11:29:23 -0400
Date: Mon, 25 Oct 2004 17:30:38 +0200
From: Stelian Pop <stelian@popies.net>
To: Dominik Brodowski <linux@dominikbrodowski.de>
Cc: jgarzik@pobox.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pcmcia network drivers cleanup
Message-ID: <20041025153038.GF3161@crusoe.alcove-fr>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Dominik Brodowski <linux@dominikbrodowski.de>, jgarzik@pobox.com,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20041025152121.GA7647@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041025152121.GA7647@dominikbrodowski.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[lkml added back in CC: list]

On Mon, Oct 25, 2004 at 05:21:21PM +0200, Dominik Brodowski wrote:

> I'd prefer if the irq_ module parameters weren't defined in one header with
> the nasty INTER_MODULE_PARAM(), but be kept per-module / per-device, i.e.
> the 
> 
> #define INT_MODULE_PARM(n, v) static int n = v; MODULE_PARM(n, "i")
> 
> static int irq_list[4] = { -1 };
> MODULE_PARM(irq_list, "1-4i");
> INT_MODULE_PARM(irq_mask,	0xdeb8);
> 
> block being replaced with
> 
> 
> static int irq_list[4] = { -1 };
> static int irq_mask irq_mask = 0xdeb8;
> 
> module_parm(irq_mask, int, 0444};

Sure, it is probably saner, but INT_MODULE_PARM is used for quite a
few other parameters in each driver, and I didn't want to touch
all of them.

Would a patch modifying all occurences of INT_MODULE_PARM be accepted
by whoever maintains those drivers ?

Stelian.
-- 
Stelian Pop <stelian@popies.net>    
