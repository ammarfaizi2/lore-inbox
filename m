Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262210AbTERVYv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 17:24:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262211AbTERVYv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 17:24:51 -0400
Received: from dp.samba.org ([66.70.73.150]:27363 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262210AbTERVYt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 17:24:49 -0400
Date: Mon, 19 May 2003 07:33:59 +1000
From: Anton Blanchard <anton@samba.org>
To: linux-kernel@vger.kernel.org
Subject: Naming devices
Message-ID: <20030518213358.GE8994@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I just spent 2 hours trying to make a machine boot. It had one bad disk
and one bad network card. Normally not a problem, but this thing had 40
cards in it so identifying the problem ones was not straight forward.

I was wondering why we dont have a consistent way of printing a device
location? If all drivers used the same thing, eg:

struct pci_dev *foo;
...
printf("%s: could not enable card\n", PCI_LOCATION(foo));

Which by default would print pci bus/devfn and an arch could override eg
on ppc64 it would also print a location code:

U1.6-P1-I2/E1 (90:0c.0)

This sounds like the domain of the event logging guys but I havent seen
anything from them in a while. The nice thing about this is that when we
get pci domains nothing needs to be changed in the driver, we just
update the PCI_LOCATION macro.

Also the tendency of network drivers to print "eth0: foo" during
initialisation is even more of a problem. If you get a bad card then you
could end up reusing the eth0 name for a subsequent device, making
pinpointing the problem card difficult. On top of that some drivers use
dev->name between calling alloc_netdev() and register_netdev() so that
you end up with error messages like "eth%d: failed".

Anton
