Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932355AbWIIISv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932355AbWIIISv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 04:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932357AbWIIISv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 04:18:51 -0400
Received: from cantor.suse.de ([195.135.220.2]:46308 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932355AbWIIISb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 04:18:31 -0400
Date: Sat, 9 Sep 2006 01:18:18 -0700
From: Greg KH <gregkh@suse.de>
To: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: State of the Linux USB Subsystem for 2.6.18-rc6
Message-ID: <20060909081818.GA13055@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a summary of the current state of the Linux USB subsystem, as of
2.6.18-rc6.

If the information in here is incorrect, or anyone knows of any
outstanding issues not listed here, please let me know.

List of outstanding regressions from 2.6.17:
	- none known.

List of outstanding regressions from older kernel versions:
	- none known.

There are a few outstanding patches waiting for Linus to pull from at:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/usb-2.6.git/
as per a previous email message to him.

If interested, the list of all currently open USB bugs can be seen at:
    http://bugzilla.kernel.org/showdependencytree.cgi?id=5089&hide_resolved=1


Future patches that are currently in my quilt tree (as found at
	http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/
) for the USB subsystem are as follows.  All of these will be submitted
for inclusion into 2.6.19, except as noted:

	- USB core reworks to get suspend working better for the USB
	  core and drivers.
	- Initial framework for USB autosuspend (final patches enabling
	  this are not included as they caused problems on my machines,
	  they might be reworked and make it into 2.6.19 depending on
	  the issues involved).
	- OHCI changes to avoid root hub polling (this makes
	  dynamic-tick mechanisms work much better and takes USB off of
	  the list of the worse offenders of timer ticks in the kernel.)
	- helper functions for detecting usb endpoints instead of having
	  to remember those crazy bit fields all the time.  All drivers
	  are converted to use them, fixing a few bugs in the process.
	- some wireless USB infrastructure patches to make the future
	  wireless driver merge easier.
	- __must_check fixes to enable the whole USB subsystem to build
	  without compiler warnings anymore.
	- a number of new drivers:
		- aircable bluetoot dongle driver
		- adutux driver
		- vibrator driver
		- moschip 7840 usb-serial driver
		- moschip 7720 usb-serial driver (not ready for 2.6.19)
		- serqt usb-serial driver (not ready for 2.6.19)
	- ability to multi-thread the USB probe process.  Probably not
	  going to go into 2.6.19 as Alan Stern has come up with a
	  better way to do this.  I just need to integrate it into the
	  tree sometime in the near future.
	- other minor bugfixes that are not really critical or too big
	  to go into 2.6.18 at this period of time.

No new USB driver API changes are pending that I am aware of.


thanks,

greg k-h

