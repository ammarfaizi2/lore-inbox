Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264363AbTLKW5V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 17:57:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264385AbTLKW5V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 17:57:21 -0500
Received: from mail1.kontent.de ([81.88.34.36]:39135 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S264363AbTLKW5U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 17:57:20 -0500
From: Oliver Neukum <oliver@neukum.org>
To: Duncan Sands <baldrick@free.fr>, Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-usb-devel] Re: [OOPS,  usbcore, releaseintf] 2.6.0-test10-mm1
Date: Thu, 11 Dec 2003 23:57:15 +0100
User-Agent: KMail/1.5.1
Cc: David Brownell <david-b@pacbell.net>, Vince <fuzzy77@free.fr>,
       "Randy.Dunlap" <rddunlap@osdl.org>, <mfedyk@matchmail.com>,
       <zwane@holomorphy.com>, <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
References: <Pine.LNX.4.44L0.0312081754480.2034-100000@ida.rowland.org> <200312111119.00289.oliver@neukum.org> <200312112243.37328.baldrick@free.fr>
In-Reply-To: <200312112243.37328.baldrick@free.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312112357.15661.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> (1) If both subsys.rwsem and dev->serialize are taken, then
> subsys.rwsem must be taken first.

Yes.
 
> (2) dev->serialize atomizes changes to the struct usb_device.
> 
> Why then is dev->serialize not taken in usb_reset_device
> (except in a dud code path)?
> 
> Also, why isn't dev->serialize enough to protect against
> probe() during usb_reset_device?  After all, won't
> dev->serialize be held during the probe calls (I didn't
> check this and I'm in need of coffee - I hope I'm on the
> right planet...)

In the current code definitely not.
You must make sure that the configuration is still available.
Guarding against probe() during reset is not enough.
AFAIK David is currently rewriting this.

	Regards
		Oliver

