Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265340AbUAJTxw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 14:53:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265346AbUAJTxw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 14:53:52 -0500
Received: from web14905.mail.yahoo.com ([216.136.225.57]:56841 "HELO
	web14905.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265340AbUAJTxu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 14:53:50 -0500
Message-ID: <20040110195348.24557.qmail@web14905.mail.yahoo.com>
Date: Sat, 10 Jan 2004 11:53:48 -0800 (PST)
From: Jon Smirl <jonsmirl@yahoo.com>
Subject: 2.6.1-pci_register_driver() and counts
To: lkml <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is this code in drivers/pci/pci-driver.c, pci_register_driver() correct?

/* register with core */
 count = driver_register(&drv->driver);
if (count >= 0) {
       pci_populate_driver_dir(drv);
}
return count ? count : 1;

Looking at base/driver.c,  driver_register() returns the output from
bus_add_driver().
Looking at base/bus.c, bus_add_driver() does not return a count, it only returns
error codes.

So the code in pci_register_driver() works as long as there is no error and the
return from driver_register() is zero, but it isn't going to work right in the
error case. Also the code is just wrong because it is expecting a count that
isn't returned.

I don't know if the count is needed, but if it is, it looks like driver_attach()
would need to modified to return it instead of void.

=====
Jon Smirl
jonsmirl@yahoo.com

__________________________________
Do you Yahoo!?
Yahoo! Hotjobs: Enter the "Signing Bonus" Sweepstakes
http://hotjobs.sweepstakes.yahoo.com/signingbonus
