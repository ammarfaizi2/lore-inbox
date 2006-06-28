Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751778AbWF1X1h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751778AbWF1X1h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 19:27:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751780AbWF1X1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 19:27:37 -0400
Received: from vms042pub.verizon.net ([206.46.252.42]:50679 "EHLO
	vms042pub.verizon.net") by vger.kernel.org with ESMTP
	id S1751778AbWF1X1g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 19:27:36 -0400
Date: Wed, 28 Jun 2006 19:27:27 -0400
From: Andy Gay <andy@andynet.net>
Subject: USB driver for Sierra Wireless EM5625/MC5720 1xEVDO modules
To: Greg KH <gregkh@suse.de>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Message-id: <1151537247.3285.278.camel@tahini.andynet.net>
MIME-version: 1.0
X-Mailer: Evolution 2.4.2.1
Content-type: text/plain
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have adapted the modified Airprime driver that Greg posted a few weeks
ago to add support for these 2 modules.

That driver works for these modules if the USB IDs are added, and fixes
the throughput problems in the earlier driver. I had to make some
changes though -

- there's a memory leak because the transfer buffers are kmalloc'ed
every time the device is opened, but they're never freed;

- these modules present 3 bulk EPs, the 2nd & 3rd can be used for
control & status monitoring while data transfer is in progress on the
1st EP. This is useful (and necessary for my application) so we need to
increase the port count.

So what should I do next? I see a few possibilities, assuming anyone is
interested in this:

- I could post a diff from Greg's driver. But I don't have hardware to
test whether my changes will break it for the other devices that it
supports;

- I could post it as a new driver for just these 2 modules, using some
other name;

- I could post it as a replacement for Greg's driver (which isn't yet in
the official sources, I think), including all the USB IDs, if someone
can test it for the other devices.

Any preference, anyone?

(Please CC replies. Thanks.)

- Andy


