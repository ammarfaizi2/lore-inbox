Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263228AbTLJNNB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 08:13:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263504AbTLJNNB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 08:13:01 -0500
Received: from massena-4-82-67-197-146.fbx.proxad.net ([82.67.197.146]:11662
	"EHLO perso.free.fr") by vger.kernel.org with ESMTP id S263228AbTLJNM7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 08:12:59 -0500
From: Duncan Sands <baldrick@free.fr>
To: Alan Stern <stern@rowland.harvard.edu>,
       David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] Re: [OOPS,  usbcore, releaseintf] 2.6.0-test10-mm1
Date: Wed, 10 Dec 2003 14:12:57 +0100
User-Agent: KMail/1.5.4
Cc: Vince <fuzzy77@free.fr>, "Randy.Dunlap" <rddunlap@osdl.org>,
       <mfedyk@matchmail.com>, <zwane@holomorphy.com>,
       <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       Greg KH <greg@kroah.com>
References: <Pine.LNX.4.44L0.0312092233340.6615-100000@netrider.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0312092233340.6615-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312101412.57388.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In an earlier message I wrote that the HC driver couldn't unload so long
> as the device usbfs was using held a reference to its bus.  I just did
> some checking, and guess what: It can!

Uh oh.

> I looked at both the UHCI and OHCI drivers.  In their module_exit routines
> they call pci_unregister_driver().  Without knowing how the PCI subsystem
> works, I would assume this behaves like any other "deregister" routine in
> the driver model and returns without waiting for any reference count to go
> to 0 -- that's what release callbacks are for.
>
> However, the module_exit routines _don't_ wait for the release callbacks.
> They just go right on ahead and exit.  Result: when the reference count
> eventually does go to 0 (when usbfs drops its last reference), the
> hcd_free routine is no longer present and you get an oops.
>
> The proper fix would be to have each HC driver keep track of how many
> instances are allocated.  The module_exit routine must wait for that
> number to drop to 0 before returning.

Is this how it is usually done?

All the best,

Duncan.
