Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264586AbTLKIt6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 03:49:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264591AbTLKIt6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 03:49:58 -0500
Received: from massena-4-82-67-197-146.fbx.proxad.net ([82.67.197.146]:9618
	"EHLO perso.free.fr") by vger.kernel.org with ESMTP id S264586AbTLKIt5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 03:49:57 -0500
From: Duncan Sands <baldrick@free.fr>
To: Greg KH <greg@kroah.com>
Subject: Re: [linux-usb-devel] Re: [OOPS,  usbcore, releaseintf] 2.6.0-test10-mm1
Date: Thu, 11 Dec 2003 09:49:54 +0100
User-Agent: KMail/1.5.4
Cc: Alan Stern <stern@rowland.harvard.edu>,
       David Brownell <david-b@pacbell.net>, Vince <fuzzy77@free.fr>,
       "Randy.Dunlap" <rddunlap@osdl.org>, mfedyk@matchmail.com,
       zwane@holomorphy.com, linux-kernel@vger.kernel.org,
       USB development list <linux-usb-devel@lists.sourceforge.net>
References: <3FD64BD9.1010803@pacbell.net> <200312101702.16455.baldrick@free.fr> <20031210205320.GA8621@kroah.com>
In-Reply-To: <20031210205320.GA8621@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312110949.54929.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I don't know if you've been following this thread or not, but the oops
> > occurred when I modified usbfs to hold a reference to the usb_device
> > until no-one was using a given usbfs file.
>
> That's a good thing to do.  It should work.
>
> > I guess this means that I should change my patch so that the reference
> > to the usb_device is dropped as soon as possible, right?
>
> No, the bug should be fixed.  I've seen this bug happen if someone has a
> usb-serial device open and then unload the host controller driver.  In
> fact, I think there's a bugzilla entry just for that...

Hi Greg, what I meant was: should I make my patch friendlier to rmmod by
trying hard to drop the reference as soon as possible, though some code paths
may have to hold on to it for a long time (cost: code complication), or is it OK
to always hang onto the usb_device as long as one of the usbfs files is open
(cost: rmmod may take a long or infinite time; advantages: simple, robust)?
This lowly one humbly awaits enlightenment... :)

Thanks,

Duncan.
