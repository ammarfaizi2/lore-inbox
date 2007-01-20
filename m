Return-Path: <linux-kernel-owner+w=401wt.eu-S1750925AbXATX4b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750925AbXATX4b (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 18:56:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750937AbXATX4b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 18:56:31 -0500
Received: from twin.jikos.cz ([213.151.79.26]:60901 "EHLO twin.jikos.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750925AbXATX4b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 18:56:31 -0500
Date: Sun, 21 Jan 2007 00:56:26 +0100 (CET)
From: Jiri Kosina <jikos@jikos.cz>
To: Ivan Ukhov <uvsoft@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: How to use an usb interface than is claimed by HID?
In-Reply-To: <45B2AA03.4070405@gmail.com>
Message-ID: <Pine.LNX.4.64.0701210050490.21127@twin.jikos.cz>
References: <45B265E0.5020605@gmail.com> <Pine.LNX.4.64.0701210006591.21127@twin.jikos.cz>
 <45B2AA03.4070405@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Jan 2007, Ivan Ukhov wrote:

> No, it won't do. Imagine that I'm not able to modify the kernel with its 
> drivers. 

Could I ask you what precisely is the driver you are talking about doing? 
Why is it not going to be a part of mainline kernel (i.e. being able to be 
put on blacklist easily).

> It should work with usual kernel and HID driver. So I want my driver to 
> ask the HID driver to free the interfaces or don't claim them at all. Mb 
> there's an example of such a driver?.. obviously there are a lot of HID 
> devices and mb a vendor one of them doesn't want to use HID driver for 
> one of its interfaces to provide some additional features or something, 
> so he should make the kernel use his driver instead of HID...

Sure, there are such in-kernel drivers ... for example Wacom driver. This 
driver is in-kernel, and it is hooked inside the usb_hid_configure() 
function to be ignored by the HID layer completely, and all the driver 
specific handling is handled in drivers/usb/input/wacom*.

(When looking at that code, it looks quite ugly by the way. I have no idea 
why wacom driver is not using HID_QUIRK_IGNORE, but has a hardcoded hook 
in the usb_hid_configure() instead. I will probably fix this.)

Thanks,

-- 
Jiri Kosina
