Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266316AbUHBSeR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266316AbUHBSeR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 14:34:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266319AbUHBSeQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 14:34:16 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:21897 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S266316AbUHBSeO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 14:34:14 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: OLS and console rearchitecture
Date: Mon, 2 Aug 2004 11:33:09 -0700
User-Agent: KMail/1.6.2
Cc: lkml <linux-kernel@vger.kernel.org>
References: <20040802142416.37019.qmail@web14923.mail.yahoo.com>
In-Reply-To: <20040802142416.37019.qmail@web14923.mail.yahoo.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408021133.09935.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, August 2, 2004 7:24 am, Jon Smirl wrote:
> 1) PCI ROMs - these would be exposed via sysfs. A quirk is needed to
> track the boot video device and expose the contents of C000:0 for that
> special case. See the lkml thread: Exposing ROM's though sysfs, there
> are already proposed patches.

I just posted what I hope is a final patch for this one.  We'll see what 
gregkh comes back with.

> 2) VGA control - there needs to be a device for coordinating this. It
> would ensure that only a single VGA device gets enabled at a time. It
> would also adjust PCI bus routing as needed. It needs commands for
> disabling all VGA devices and then enabling a selected one. This device
> may need to coordinate with VGA console. You have to use this device
> even if you aren't using VGA console since it ensures that only a
> single VGA device gets enabled.
> Alan Cox: what about hardware that supports multiple vga routers? do we
> care?
> JS: no design work has been done for this device, what would be it's
> major/minor? would this be better done in sysfs?

It should probably be a real device driver rather than a sysfs pseudofile.  
Not sure if it should be dynamic or not though.  It would be nice if apps 
used the driver to do legacy VGA I/O port accesses as well, since that would 
make things easier on platforms that unconditionally master abort when a PIO 
times out, and would probably make it easier to deal with multiple domains.

Jesse
