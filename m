Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267325AbUIOTX0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267325AbUIOTX0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 15:23:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267330AbUIOTXZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 15:23:25 -0400
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:49049 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S267325AbUIOTXW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 15:23:22 -0400
Date: Wed, 15 Sep 2004 21:21:34 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Greg KH <greg@kroah.com>
Cc: "Marco d'Itri" <md@Linux.IT>, "Giacomo A. Catenazzi" <cate@pixelized.ch>,
       linux-kernel@vger.kernel.org
Subject: Re: udev is too slow creating devices
Message-ID: <20040915192134.GA4197@dualathlon.random>
References: <41474926.8050808@nortelnetworks.com> <20040914195221.GA21691@kroah.com> <414757FD.5050209@pixelized.ch> <20040914213506.GA22637@kroah.com> <20040914214552.GA13879@wonderland.linux.it> <20040914215122.GA22782@kroah.com> <20040914224731.GF3365@dualathlon.random> <20040914230409.GA23474@kroah.com> <20040914232011.GG3365@dualathlon.random> <20040915161541.GD21971@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040915161541.GD21971@kroah.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2004 at 09:15:41AM -0700, Greg KH wrote:
> But the low level driver (like a USB driver for example), has no way of
> knowing when the "device discovery" process is over.  Actually the USB
> core never knows this either, as devices come and go all the time.

eventually the discovery will end with a call into userspace, it'd be
enough to wait4 and wakeup a waitqueue when the wait4 returns. 

> So the kernel can not know what or when to wait for something it doesn't
> know is going to ever happen in the future.

the kernel certainly knows when it's about time to fork an userspace
process to create the device, doesn't it? then just wait4 while the
process is running.

> Remember, this isn't your old "static device tree" unix-like kernel that
> people grew up with, anymore. :)

if you intentionally don't want to provide serialization and force into
/var/run locking, that's fine with me, but I don't buy your claim that
it's not feasible.
