Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261207AbVCREAH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261207AbVCREAH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 23:00:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261228AbVCREAH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 23:00:07 -0500
Received: from soundwarez.org ([217.160.171.123]:38287 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S261207AbVCREAD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 23:00:03 -0500
Date: Fri, 18 Mar 2005 05:00:00 +0100
From: Kay Sievers <kay.sievers@vrfy.org>
To: linux-kernel@vger.kernel.org
Cc: Greg KH <greg@kroah.com>
Subject: [PATCH 0/6] kobject/hotplug split
Message-ID: <20050318040000.GA475@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This splits the implicit generation of hotplug events from
kobject_add() and kobject_del(), to give the driver core
control over the time the event is created.

The kobject_register() and unregister functions still have the same
behavior and emit the events by themselves.

The class, block and device core is changed now to emit the hotplug
event _after_ the "dev" file, the "device" symlink and the default
attributes are created. This will save udev from spinning in a stat() loop
to wait for the files to appear, which is expensive if we have a lot of
concurrent events.

