Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262234AbTERWXr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 18:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262235AbTERWXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 18:23:46 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:50183 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262234AbTERWXl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 18:23:41 -0400
Date: Sun, 18 May 2003 23:36:34 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Anton Blanchard <anton@samba.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Naming devices
Message-ID: <20030518233634.C4224@flint.arm.linux.org.uk>
Mail-Followup-To: Anton Blanchard <anton@samba.org>,
	linux-kernel@vger.kernel.org
References: <20030518213358.GE8994@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030518213358.GE8994@krispykreme>; from anton@samba.org on Mon, May 19, 2003 at 07:33:59AM +1000
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 19, 2003 at 07:33:59AM +1000, Anton Blanchard wrote:
> I was wondering why we dont have a consistent way of printing a device
> location? If all drivers used the same thing, eg:

Isn't this what dev->bus_id in the device structure is supposed to be?
(which is supposed to be a unique bus ID on a particular bus type, in
the pci case, a PCI device.)

> Also the tendency of network drivers to print "eth0: foo" during
> initialisation is even more of a problem. If you get a bad card then you
> could end up reusing the eth0 name for a subsequent device, making
> pinpointing the problem card difficult. On top of that some drivers use
> dev->name between calling alloc_netdev() and register_netdev() so that
> you end up with error messages like "eth%d: failed".

Now that the point has been raised, it seems pretty obvious that
initialisation failures should report the BUS ID of the failing card,
not the logical name assigned by the system to that device which could
change.  Once the card is up and running, using the logical name becomes
meaningful - it's the identifier which user space uses to reference the
device.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

