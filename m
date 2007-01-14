Return-Path: <linux-kernel-owner+w=401wt.eu-S1751640AbXANTrP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751640AbXANTrP (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 14:47:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751654AbXANTrP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 14:47:15 -0500
Received: from ppp-70-251-6-36.dsl.rcsntx.swbell.net ([70.251.6.36]:39394 "EHLO
	server.willdawg" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751640AbXANTrO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 14:47:14 -0500
Date: Sun, 14 Jan 2007 19:47:12 +0000 (GMT)
From: icxcnika@mar.tar.cc
X-X-Sender: icxcnika@server.willdawg
To: linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] 2.6.20-rc4: usb somehow broken
In-Reply-To: <Pine.LNX.4.44L0.0701141418290.24969-100000@netrider.rowland.org>
Message-ID: <Pine.LNX.4.64.0701141945010.14767@server.willdawg>
References: <Pine.LNX.4.44L0.0701141418290.24969-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 14 Jan 2007, Alan Stern wrote:

> On Sun, 14 Jan 2007, Prakash Punnoor wrote:
>
>> Am Sonntag 14 Januar 2007 10:28 schrieb Oliver Neukum:
>>> Am Sonntag, 14. Januar 2007 10:08 schrieb Prakash Punnoor:
>>>> Am Donnerstag 11 Januar 2007 18:28 schrieb Oliver Neukum:
>>>>> Am Donnerstag, 11. Januar 2007 18:20 schrieb Prakash Punnoor:
>>>>>> Hi,
>>>>>>
>>>>>> I can't scan anymore. :-( I don't know which rc kernel introduced it,
>>>>>> but this are the messages I get (w/o touching the device/usb cable
>>>>>> except pluggin it in for the first time):
>>>>>>
>>>>>> usb 1-1.2: new full speed USB device using ehci_hcd and address 4
>>>>>> ehci_hcd 0000:00:0b.1: qh ffff81007bc6c280 (#00) state 4
>>>>>> usb 1-1.2: configuration #1 chosen from 1 choice
>>>>>> usb 1-1.2: USB disconnect, address 4
>>>>>> usb 1-1.2: new full speed USB device using ehci_hcd and address 5
>>>>>> usb 1-1.2: configuration #1 chosen from 1 choice
>>>>>> usb 1-1.2: USB disconnect, address 5
>>>>>> usb 1-1.2: new full speed USB device using ehci_hcd and address 6
>>>>>> usb 1-1.2: configuration #1 chosen from 1 choice
>>>>>> usb 1-1.2: USB disconnect, address 6
>>>>>> usb 1-1.2: new full speed USB device using ehci_hcd and address 7
>>>>>> usb 1-1.2: configuration #1 chosen from 1 choice
>>>>>> usb 1-1.2: USB disconnect, address 7
>>>>>> usb 1-1.2: new full speed USB device using ehci_hcd and address 8
>>>>>> usb 1-1.2: configuration #1 chosen from 1 choice
>>>
>>> [..]
>>>
>>>> Hi, I did more tests and I was wrong about "broken". It seems more a
>>>> time-out problem, ie if I try to use sane again in short intervalls, I
>>>> will get my device working. The cause seems CONFIG_USB_SUSPEND=y. With
>>>> 2.6.20-rc5 the
>>>
>>> Have you confirmed that by using a kernel without  CONFIG_USB_SUSPEND ?
>>
>> Yes. I compiled the modules with various settings, reloaded the modules and
>> above option made the difference. I also don't get the disconnect mesages, as
>> well, w/o USB_SUSPEND.
>
> Judging from the log, it looks like the scanner cannot handle being
> suspended.  (BTW this is in violation of the USB specification -- all
> devices must be able to suspend and resume.)
>
> When the scanner is not in use, the system automatically suspends it after
> two seconds.  When you use sane the scanner is resumed, but it then
> disconnects itself and reconnects.  Sane is left trying to control the
> disconnected device instance, so of course it fails.
>
> I'm beginning to think that we need some way to deal with devices that
> cannot recover from a suspend.  Several examples have cropped up.
> Unfortunately, I can't think of anything better than a blacklist, which is
> not very satisfactory.
>
> Can anyone suggest another approach?
>
> Alan Stern

Just a thought, you could use both a blacklist approach, and a module 
paramater, or something in sysfs, to allow specifying devices that won't 
be suspend and resume compatible.

William Heimbigner
icxcnika@mar.tar.cc
