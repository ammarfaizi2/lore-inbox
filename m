Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751803AbWI1JYW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751803AbWI1JYW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 05:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751800AbWI1JYW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 05:24:22 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:14090 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1751803AbWI1JYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 05:24:22 -0400
Message-ID: <451B94AA.3090100@shadowen.org>
Date: Thu, 28 Sep 2006 10:23:54 +0100
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
MIME-Version: 1.0
To: Alan Stern <stern@rowland.harvard.edu>
CC: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: 2.6.18-git9
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a couple of power boxes which no longer seem to be able to
compile mainline as of 2.6.18-git9.  The build fails as below:

  CC      drivers/usb/core/driver.o
drivers/usb/core/driver.c: In function `usb_probe_device':
drivers/usb/core/driver.c:168: error: structure has no member named
`pm_usage_cnt'
drivers/usb/core/driver.c: In function `usb_driver_claim_interface':
drivers/usb/core/driver.c:305: error: structure has no member named
`pm_mutex'
drivers/usb/core/driver.c:309: error: structure has no member named
`pm_mutex'
drivers/usb/core/driver.c: In function `usb_driver_release_interface':
drivers/usb/core/driver.c:358: error: structure has no member named
`pm_mutex'
drivers/usb/core/driver.c:362: error: structure has no member named
`pm_mutex'
make[3]: *** [drivers/usb/core/driver.o] Error 1
make[2]: *** [drivers/usb/core] Error 2
make[1]: *** [drivers/usb] Error 2
make: *** [drivers] Error 2

This seems to be realated to the changes in this commit:

	commit 645daaab0b6adc35c1838df2a82f9d729fdb1767
    	usbcore: add autosuspend/autoresume infrastructure

The machines in question do not have CONFIG_PM set.  It seems that the
definition of pm_mutex et al in struct usb_device are contingent on that
defined, but the use of it in usb_driver_release_interface() are not.

Its not clear to me if suspending in this context is quite the same as
full suspend to disk that I associate with PM so I am unsure which bit
is in error.  Will retest with those references under CONFIG_PM.

Alan?

-apw
