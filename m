Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261492AbTLKVnk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 16:43:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262176AbTLKVnk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 16:43:40 -0500
Received: from massena-4-82-67-197-146.fbx.proxad.net ([82.67.197.146]:14465
	"EHLO perso.free.fr") by vger.kernel.org with ESMTP id S261492AbTLKVnj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 16:43:39 -0500
From: Duncan Sands <baldrick@free.fr>
To: Oliver Neukum <oliver@neukum.org>, Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-usb-devel] Re: [OOPS,  usbcore, releaseintf] 2.6.0-test10-mm1
Date: Thu, 11 Dec 2003 22:43:37 +0100
User-Agent: KMail/1.5.4
Cc: David Brownell <david-b@pacbell.net>, Vince <fuzzy77@free.fr>,
       "Randy.Dunlap" <rddunlap@osdl.org>, <mfedyk@matchmail.com>,
       <zwane@holomorphy.com>, <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
References: <Pine.LNX.4.44L0.0312081754480.2034-100000@ida.rowland.org> <200312111045.11275.baldrick@free.fr> <200312111119.00289.oliver@neukum.org>
In-Reply-To: <200312111119.00289.oliver@neukum.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312112243.37328.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Hi Oliver, I agree, except that there are several layers of locking:
> > dev->serialize but also the bus rwsem.  So does "physical" mean no
> > subsys.rwsem or no dev->serialize or both?
>
> "physical" means no locking at all. It's the caller's responsibility.
...

> That's what the core cares about. No probe() while a reset is in
> progress. Taking the semaphore ensures that.

Hi Oliver, I'm a bit confused about the locking rules.  I suppose

(1) If both subsys.rwsem and dev->serialize are taken, then
subsys.rwsem must be taken first.

(2) dev->serialize atomizes changes to the struct usb_device.

Why then is dev->serialize not taken in usb_reset_device
(except in a dud code path)?

Also, why isn't dev->serialize enough to protect against
probe() during usb_reset_device?  After all, won't
dev->serialize be held during the probe calls (I didn't
check this and I'm in need of coffee - I hope I'm on the
right planet...)

Ciao,

Duncan.
