Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751337AbWJLX6d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337AbWJLX6d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 19:58:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751344AbWJLX6d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 19:58:33 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:15378 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751337AbWJLX6c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 19:58:32 -0400
Date: Fri, 13 Oct 2006 00:58:21 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Jiri Kosina <jikos@jikos.cz>
Cc: Phil Blundell <philb@gnu.org>, Tim Waugh <tim@cyberelk.net>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-parport@lists.infradead.org
Subject: Re: [PATCH] fix parport_serial_pci_resume() ignoring return value from pci_enable_device()
Message-ID: <20061012235820.GC24658@flint.arm.linux.org.uk>
Mail-Followup-To: Jiri Kosina <jikos@jikos.cz>,
	Phil Blundell <philb@gnu.org>, Tim Waugh <tim@cyberelk.net>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-parport@lists.infradead.org
References: <Pine.LNX.4.64.0610130139510.29022@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610130139510.29022@twin.jikos.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2006 at 01:44:24AM +0200, Jiri Kosina wrote:
> (I guess that the parport_serial_pci_remove() is the right way(tm) to 
> remove the device from the system in non-destructive way even in case 
> pci_enable_device() failed. Tim?)

I suspect all these kind of patches are introducing additional problems.
This one certainly is.  Who's auditing all these patches?  I mean _properly_
auditing them rather than just saying "that's a good idea"?

In this case, you're calling parport_serial_pci_remove() in the failure
path.  That's fine, but this opens the possibility of it being called
twice - once on resume failure and once when the device/driver is
removed.  If this happens, we dereference a NULL pointer. *BAD*.

So, the original without this resume fix is probably far better than
with the fix.

So, patch violently rejected.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
