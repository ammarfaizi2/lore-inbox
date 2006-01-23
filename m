Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751478AbWAWQ2z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751478AbWAWQ2z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 11:28:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751475AbWAWQ2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 11:28:55 -0500
Received: from gate.crashing.org ([63.228.1.57]:22944 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751478AbWAWQ2y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 11:28:54 -0500
Date: Mon, 23 Jan 2006 10:21:43 -0600 (CST)
From: Kumar Gala <galak@gate.crashing.org>
To: netdev@vger.kernel.org
cc: linux-kernel@vger.kernel.org
Subject: proper way to deal with a sparse warning (fwd)
Message-ID: <Pine.LNX.4.44.0601231021010.11937-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wasn't getting much of a response on lkml to this, so maybe netdev will 
be more helpful :)

thanks

- kumar

---------- Forwarded message ----------
Date: Thu, 19 Jan 2006 00:19:47 -0600
From: Kumar Gala <galak@kernel.crashing.org>
To: LKML List <linux-kernel@vger.kernel.org>
Subject: proper way to deal with a sparse warning

I'm getting the following sparse warning:

drivers/net/gianfar_mii.c:165:16: warning: incorrect type in  
assignment (different address spaces)
drivers/net/gianfar_mii.c:165:16:    expected void *priv
drivers/net/gianfar_mii.c:165:16:    got struct gfar_mii [noderef] * 
[assigned] regs<asn:2>

This is line 165 of gianfar_mii.c:

         new_bus->priv = regs;

new_bus->priv is of type void *.  regs is of type struct gfar_mii  
__iomem *.

Is it acceptable to do the following:

	new_bus->priv = (void __force *)regs;

- kumar

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

