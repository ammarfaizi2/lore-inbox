Return-Path: <linux-kernel-owner+w=401wt.eu-S1751759AbXAUXIt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751759AbXAUXIt (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 18:08:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751763AbXAUXIt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 18:08:49 -0500
Received: from mercury.sdinet.de ([193.103.161.30]:47828 "EHLO
	mercury.sdinet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751759AbXAUXIs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 18:08:48 -0500
Date: Mon, 22 Jan 2007 00:08:46 +0100 (CET)
From: Sven-Haegar Koch <haegar@sdinet.de>
To: Udo van den Heuvel <udovdh@xs4all.nl>
cc: linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
       Greg KH <greg@kroah.com>
Subject: Re: USB extension (repeater) cable
In-Reply-To: <45B31433.5000408@xs4all.nl>
Message-ID: <Pine.LNX.4.64.0701220004400.26085@mercury.sdinet.de>
References: <45B0E672.4080404@xs4all.nl> <20070120000158.GD12615@kroah.com>
 <45B313AD.7080705@zytor.com> <45B31433.5000408@xs4all.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Jan 2007, Udo van den Heuvel wrote:

> H. Peter Anvin wrote:
>> Greg KH wrote:
>>> On Fri, Jan 19, 2007 at 04:40:34PM +0100, Udo van den Heuvel wrote:
>>>>
>>>> I just tried my shiny new usb extension cable (repeater):
>>>>
>>>> Jan 19 16:01:17 epia kernel: usb 5-1: new high speed USB device using
>>>> ehci_hcd and address 60
>>>> Jan 19 16:01:17 epia kernel: usb 5-1: configuration #1 chosen from 1
>>>> choice
>>>> Jan 19 16:01:17 epia kernel: hub 5-1:1.0: USB hub found
>>>> Jan 19 16:01:17 epia kernel: hub 5-1:1.0: 4 ports detected
>>>> Jan 19 16:01:18 epia kernel: hub 5-1:1.0: Cannot enable port 1.  Maybe
>>>> the USB cable is bad?
>>>> Jan 19 16:01:22 epia last message repeated 3 times
>>>> Jan 19 16:01:23 epia kernel: hub 5-1:1.0: Cannot enable port 2.  Maybe
>>>> the USB cable is bad?
>>>> Jan 19 16:01:26 epia last message repeated 3 times
>>>> Jan 19 16:01:27 epia kernel: hub 5-1:1.0: Cannot enable port 3.  Maybe
>>>> the USB cable is bad?
>>>> Jan 19 16:01:31 epia last message repeated 3 times
>
> [...]
>
>> Actually, what it looks like is even simpler.  The extension cable
>> contains a four-port hub chip (which is the most common commodity chip)
>> and haven't bothered changing the descriptor to tell the computer only
>> one port is actually active.  So only one port can be activated, and the
>> others are stubbed out in some evil way.  In that case, it should be
>> noisy but harmless.
>
> I will do some more testing then.
> Is there a way to get rid of the messages?

I am using the following patch (with 2.6.17) to shut up these messages 
with my repeater cable - found it on the linux-usb mailinglist some time 
ago when facing the same problem, but did not write down from who it is.

(Does not silence all log messages when usb debugging is enabled, but when 
it is disabled there is no endless log-stream anymore and the cable works)

I tried to fix the logging-change to the usb id, but the cable uses 
exactly the same chip and id as the two chips inside my 7port usb-hub.


Index: linux/drivers/usb/core/hub.c
===================================================================
--- linux.orig/drivers/usb/core/hub.c	2006-10-14 00:45:50.000000000 +0200
+++ linux/drivers/usb/core/hub.c	2006-10-14 00:47:38.000000000 +0200
@@ -1496,7 +1496,8 @@

  		/* bomb out completely if something weird happened */
  		if ((portchange & USB_PORT_STAT_C_CONNECTION))
-			return -EINVAL;
+			//return -EINVAL;
+			return -ENOTCONN;

  		/* if we`ve finished resetting, then break out of the loop */
  		if (!(portstatus & USB_PORT_STAT_RESET) &&

c'ya
sven

-- 

The Internet treats censorship as a routing problem, and routes around it.
(John Gilmore on http://www.cygnus.com/~gnu/)
