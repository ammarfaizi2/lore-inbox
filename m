Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263358AbTH0MnY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 08:43:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263359AbTH0MnY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 08:43:24 -0400
Received: from pentafluge.infradead.org ([213.86.99.235]:1928 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S263358AbTH0MnX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 08:43:23 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Patrick Mochel <mochel@osdl.org>
Cc: Russell King <rmk@arm.linux.org.uk>, Greg KH <greg@kroah.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0308260817190.942-100000@localhost.localdomain>
References: <Pine.LNX.4.33.0308260817190.942-100000@localhost.localdomain>
Message-Id: <1061988185.1293.57.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 27 Aug 2003 14:43:06 +0200
X-SA-Exim-Mail-From: benh@kernel.crashing.org
Subject: Re: PCI PM & compatibility
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-SA-Exim-Version: 3.0+cvs (built Mon Aug 18 15:53:30 BST 2003)
X-SA-Exim-Scanned: Yes
X-Pentafluge-Mail-From: <benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> - When a device is suspended, the pm_users count of its pm_parent is 
>   decremented, and incremented when the device is resumed. 
> 
> - device_suspend() makes multiple passes over the device list, in case
>   power dependencies cause some devices to be deferred. It fails with an 
>   error (and resumes all suspended devices) if a pass was made in which 
>   no devicse were suspended, but there are still devices with a positive
>   pm_users count. 

How do you intend to deal with the childs of the device that has
pm_users non null ?

If you don't suspend it, you must also postpone all of it's childs.
That makes the list walking slightly more tricky, or you finally go
to a real tree structure ? (Which you may have to do to implement
the set_parent() thing too, no ?

Ben.


