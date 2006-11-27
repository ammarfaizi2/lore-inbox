Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758072AbWK0Lr2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758072AbWK0Lr2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 06:47:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758070AbWK0Lr1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 06:47:27 -0500
Received: from mtagate6.de.ibm.com ([195.212.29.155]:2995 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP
	id S1758071AbWK0Lr1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 06:47:27 -0500
Date: Mon, 27 Nov 2006 12:48:01 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Greg K-H <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Patch 3/7] driver core fixes: device_register() retval check
 in platform.c
Message-ID: <20061127124801.0248e3f6@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <20061127112447.GA28761@flint.arm.linux.org.uk>
References: <20061127103508.36d36539@gondolin.boeblingen.de.ibm.com>
	<20061127112447.GA28761@flint.arm.linux.org.uk>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Nov 2006 11:24:47 +0000,
Russell King <rmk+lkml@arm.linux.org.uk> wrote:

> I still say this is absolutely crazy.  If a bus does not get registered,
> what happens to all the devices and drivers which are registered against
> that bus?

This is a generic problem. Does any driver check if the bus it is
registering against is really present? Or should the driver core check
whether a bus is registered when someone tries to register a
device/driver?

> I suspect that if this bus_register doesn't work, you'll see an oops
> sooner or later.  So it might as well be a BUG_ON here.

What we need to do here is to make sure we get to know that something
went really wrong here. If a BUG_ON is considered preferrable to oopses
on platform device registering, I can roll a patch.

-- 
Cornelia Huck
Linux for zSeries Developer
Tel.: +49-7031-16-4837, Mail: cornelia.huck@de.ibm.com
