Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261204AbVAWETP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261204AbVAWETP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 23:19:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261205AbVAWETP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 23:19:15 -0500
Received: from soundwarez.org ([217.160.171.123]:45706 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S261204AbVAWETN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 23:19:13 -0500
Date: Sun, 23 Jan 2005 05:19:11 +0100
From: Kay Sievers <kay.sievers@vrfy.org>
To: linux-kernel@vger.kernel.org
Cc: Greg KH <greg@kroah.com>
Subject: [PATCH 0/7] driver core: export MAJOR/MINOR to the hotplug env
Message-ID: <20050123041911.GA9209@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch sequence moves the creation of the sysfs "dev" file of the class
devices into the driver core. The struct class_device contains a dev_t
value now. If set, the driver core will create the "dev" file containing
the major/minor numbers automatically.

The MAJOR/MINOR values are also exported to the hotplug environment. This
makes it easy for userspace, especially udev to know if it should wait for
a "dev" file to create a device node or if it can just ignore the event.
We currently carry a compiled in blacklist around for that reason.

It would also be possible to run some "tiny udev" while sysfs is not
available - just by reading the hotplug call or the netlink-uevent.

Thanks,
Kay

