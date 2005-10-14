Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932071AbVJNCR7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbVJNCR7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 22:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932203AbVJNCR7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 22:17:59 -0400
Received: from rwcrmhc14.comcast.net ([204.127.198.54]:40693 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S932071AbVJNCR6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 22:17:58 -0400
From: kernel-stuff@comcast.net (Parag Warudkar)
To: Greg KH <greg@kroah.com>, Christian Krause <chkr@plauener.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bug in handling of highspeed usb HID devices
Date: Fri, 14 Oct 2005 02:10:17 +0000
Message-Id: <101420050210.18923.434F13890004C6F8000049EB220076106400009A9B9CD3040A029D0A05@comcast.net>
X-Mailer: AT&T Message Center Version 1 (Dec 17 2004)
X-Authenticated-Sender: a2VybmVsLXN0dWZmQGNvbWNhc3QubmV0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Also, what device needs this patch?  Is it a device that I can buy
> today?
> 
> thanks,
> 
> greg k-h

The patch is for hid-core.c - I don't think it is device specific - original problem 
should affect all High Speed USB HID devices. 

To summarize -

Current code just looks plain wrong since the same logic is repeated twice - endpoint->bInterval is operated upon twice if the device is HIGH SPEED one.

if (dev->speed == USB_SPEED_HIGH)
                         interval = 1 << (interval - 1);

This is first done in hid-code.c:usb_hid_configure() which then passes interval to  usb.h:usb_fill_int_urb() which again repeats the same logic as above!

Parag



