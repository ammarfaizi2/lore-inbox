Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263770AbUJETt4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263770AbUJETt4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 15:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263743AbUJETr1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 15:47:27 -0400
Received: from quechua.inka.de ([193.197.184.2]:8391 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S263770AbUJETqZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 15:46:25 -0400
Subject: block till hotplug is done?
From: Andreas Jellinghaus <aj@dungeon.inka.de>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1097005927.4953.4.camel@simulacron>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 05 Oct 2004 21:52:07 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

is there any way to block till all hotplug events are handled/
the hotplug processes terminated?

For example
	fdisk
	mkfs
fails, because after fdisk create a partition, and the kernel
reread the partition table, called hotplug, hotplug called udev
and udev created the matching /dev file, all of that might be
too slow and mkfs might fail in the mean time.

even
	fdisk
	sleep 2
	mkfs
sometimes failes with machines I'm installing.

so I can either randomly increase the delay everytime the installation
fails because the device isn't created in time, or I can create the
devices myself with mkdev, which defeats the whole purpose of hotplug
and udev. Or - preferable - I would want to wait till something
tells me the device is there. some way to sleep till not kernel
triggered hotlug process is running any more, that would be nice.
does the kernel keep track of it's hotplug processes? is there such
a way to wait till they are all done? 

(and would that work, if hotplug spawned some child process/daemon, i.e.
not wait for the daemon to end?)

Regards, Andreas

