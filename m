Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262380AbUDOUYJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 16:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262756AbUDOUYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 16:24:09 -0400
Received: from ida.rowland.org ([192.131.102.52]:2052 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S262380AbUDOUYE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 16:24:04 -0400
Date: Thu, 15 Apr 2004 16:24:03 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Colin Leroy <colin@colino.net>
cc: David Brownell <david-b@pacbell.net>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] 2.6.6-rc1: cdc-acm still (differently) broken
In-Reply-To: <20040415212334.4a568c5a@jack.colino.net>
Message-ID: <Pine.LNX.4.44L0.0404151617460.614-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Apr 2004, Colin Leroy wrote:

> Like this one? It works. I'm a bit wondering, however, how comes 
> usb_interface_claimed() returns true, and the check in 
> usb_driver_claim_interface() passes?

While an interface is being probed, usb_interface_claimed() will always
return true for it.  That's because the probing code sets
interface->dev.driver (which is what usb_interface_claimed() tests) before
calling the probe function.  If the probe fails then interface->dev.driver
will be reset.  This all happens inside bus_match() in drivers/base/bus.c.

For the same reason, the test of (dev->driver) in 
usb_driver_claim_interface() -- that is the test you meant, isn't it? -- 
passes (i.e., yields a true value).

Alan Stern

