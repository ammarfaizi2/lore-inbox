Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264453AbTLMLxS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Dec 2003 06:53:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264563AbTLMLxS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Dec 2003 06:53:18 -0500
Received: from mail1.kontent.de ([81.88.34.36]:30179 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S264453AbTLMLxQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Dec 2003 06:53:16 -0500
From: Oliver Neukum <oliver@neukum.org>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-usb-devel] Re: [OOPS,  usbcore, releaseintf] 2.6.0-test10-mm1
Date: Sat, 13 Dec 2003 12:52:52 +0100
User-Agent: KMail/1.5.1
Cc: David Brownell <david-b@pacbell.net>, Duncan Sands <baldrick@free.fr>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
References: <Pine.LNX.4.44L0.0312122001460.16010-100000@netrider.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0312122001460.16010-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312131252.52252.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> The API has an admitted weak spot when more than one driver is bound to 
> the device.  No one has settled on a definite policy for how to handle 
> that situation.

Right. You have to disconnect all but the driver requesting the reset.

> > IMHO you should do the code paths for late errors and the device morphed
> > case in another thread, but what's the benefit for success?
> 
> In the success case there are no errors, the device hasn't morphed, and 
> there's no need to do anything in another thread.  The existing driver(s) 
> can remain bound, usb_reset_device returns 0, and nothing more has to be 
> done.

OK, we agree.
There is one pathological case. We could have a device with several
interfaces of the same kind. In this case we would reenter probe, if
the reset was requested from within probe().
Could we avoid any complication if we move the rebinding to another
thread always?

	Regards
		Oliver


