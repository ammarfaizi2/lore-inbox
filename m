Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261802AbUENRJD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261802AbUENRJD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 13:09:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261798AbUENRJD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 13:09:03 -0400
Received: from mtaw4.prodigy.net ([64.164.98.52]:49311 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S261787AbUENRI6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 13:08:58 -0400
Message-ID: <40A4FC1A.20809@pacbell.net>
Date: Fri, 14 May 2004 10:04:26 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
CC: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: 2.6.6-mm2, usb ehci warnings/error?
References: <40A3962F.3020500@pacbell.net> <40A47AC3.4010403@gmx.de>
In-Reply-To: <40A47AC3.4010403@gmx.de>
Content-Type: multipart/mixed;
 boundary="------------070507000703000105070505"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070507000703000105070505
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Prakash K. Cheemplavam wrote:
> David Brownell wrote:
> 
>>> There appear lines like
>>>
>>> usb usb2: string descriptor 0 read error: -108
>>>
>>> bug or feature? They weren't there with 2.6.6-mm1. I have no usb2.0 
>>> stuff to actually test. My usb1 stuff seems to work though.
>>
>> Bug; minor, since the only real symptom seems to be messages like
>> that.  Ignore them for now, I'll make a patch soonish.
> 
> Ok, good. Thanks for the explanation of what is going on, though I don't 
> can make too much out of it. ;-)

The short version is:  it's missing this patch.

[ Greg, please merge! ]

- Dave

--------------070507000703000105070505
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

--- bk2/xu26/drivers/usb/host/ohci-hub.c	2004-05-11 18:03:30.000000000 -0700
+++ gadget-2.6/drivers/usb/host/ohci-hub.c	2004-05-13 09:15:18.000000000 -0700
@@ -385,6 +385,7 @@
 			) {
 		ohci_vdbg (ohci, "autosuspend\n");
 		(void) ohci_hub_suspend (&ohci->hcd);
+		ohci->hcd.state = USB_STATE_RUNNING;
 		up (&hcd->self.root_hub->serialize);
 	}
 #endif

--------------070507000703000105070505--

