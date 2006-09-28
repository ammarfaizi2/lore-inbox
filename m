Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964937AbWI1QFj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964937AbWI1QFj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 12:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030198AbWI1QE4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 12:04:56 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:6412 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S964933AbWI1QEh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 12:04:37 -0400
Date: Thu, 28 Sep 2006 12:04:36 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Andy Whitcroft <apw@shadowen.org>
cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: Re: 2.6.18-git9
In-Reply-To: <451B94AA.3090100@shadowen.org>
Message-ID: <Pine.LNX.4.44L0.0609281203320.6609-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Sep 2006, Andy Whitcroft wrote:

> I have a couple of power boxes which no longer seem to be able to
> compile mainline as of 2.6.18-git9.  The build fails as below:
> 
>   CC      drivers/usb/core/driver.o
> drivers/usb/core/driver.c: In function `usb_probe_device':
> drivers/usb/core/driver.c:168: error: structure has no member named
> `pm_usage_cnt'
> drivers/usb/core/driver.c: In function `usb_driver_claim_interface':
> drivers/usb/core/driver.c:305: error: structure has no member named
> `pm_mutex'
> drivers/usb/core/driver.c:309: error: structure has no member named
> `pm_mutex'
> drivers/usb/core/driver.c: In function `usb_driver_release_interface':
> drivers/usb/core/driver.c:358: error: structure has no member named
> `pm_mutex'
> drivers/usb/core/driver.c:362: error: structure has no member named
> `pm_mutex'
> make[3]: *** [drivers/usb/core/driver.o] Error 1
> make[2]: *** [drivers/usb/core] Error 2
> make[1]: *** [drivers/usb] Error 2
> make: *** [drivers] Error 2
> 
> This seems to be realated to the changes in this commit:
> 
> 	commit 645daaab0b6adc35c1838df2a82f9d729fdb1767
>     	usbcore: add autosuspend/autoresume infrastructure
> 
> The machines in question do not have CONFIG_PM set.  It seems that the
> definition of pm_mutex et al in struct usb_device are contingent on that
> defined, but the use of it in usb_driver_release_interface() are not.
> 
> Its not clear to me if suspending in this context is quite the same as
> full suspend to disk that I associate with PM so I am unsure which bit
> is in error.  Will retest with those references under CONFIG_PM.
> 
> Alan?

This problem was noticed in -mm and the patch to fix it was sent in very 
recently; it hasn't filtered upstream yet.  The patch itself is here:

http://marc.theaimsgroup.com/?l=linux-usb-devel&m=115929663530629&w=2

Alan Stern

