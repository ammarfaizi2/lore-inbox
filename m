Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265444AbUBBAjL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 19:39:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265473AbUBBAjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 19:39:10 -0500
Received: from dp.samba.org ([66.70.73.150]:59112 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265444AbUBBAjI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 19:39:08 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Martin Schlemmer <azarah@nosferatu.za.org>
Cc: Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
Cc: Greg KH <greg@kroah.com>
Subject: Re: module-init-tools/udev and module auto-loading 
In-reply-to: Your message of "Mon, 02 Feb 2004 00:31:58 +0200."
             <1075674718.27454.17.camel@nosferatu.lan> 
Date: Mon, 02 Feb 2004 11:10:11 +1100
Message-Id: <20040202003922.3180E2C078@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <1075674718.27454.17.camel@nosferatu.lan> you write:
> A quick question on module-init-tools/udev and module auto-loading ...
> lets say I have a module called 'foo', that I want the kernel to
> auto-load.

The *idea* of udev et al is that the kernel finds the devices,
/sbin/hotplug loads the driver etc.

This does not cover the class of things which are entirely created by
the driver (eg. dummy devices, socket families), so cannot be
"detected".  Many of these (eg. socket families) can be handled by
explicit request_module() in the core and MODULE_ALIAS in the driver.
Some of them cannot at the moment: the first the kernel knows of them
is an attempt to open the device.  Some variant of devfs would solve
this.

> Then a distant related issue - anybody thought about dynamic major
> numbers of 2.7/2.8 (?) and the 'alias char-major-<whatever>-* whatever'
> type modprobe rules (as the whole fact of them being dynamic, will make
> that alias type worthless ...)?

Yes.  This could be changed to probe by device name, not number
though.  And most names can't be dynamic: /dev/null has certain, fixed
semantics.

The "I found this hardware, who will drive it?" mechanism of udev, and
the "User asked for this, who will supply it?" mechanism of kmod have
some overlap, but I think both will end up being required.

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
