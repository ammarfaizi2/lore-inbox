Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261556AbVBHQIc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261556AbVBHQIc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 11:08:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261553AbVBHQIc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 11:08:32 -0500
Received: from styx.suse.cz ([82.119.242.94]:38863 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S261557AbVBHQIa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 11:08:30 -0500
Date: Tue, 8 Feb 2005 17:09:28 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: zyphr <infzyphr@gmail.com>
Cc: Mikkel Krautz <krautz@gmail.com>, linux-kernel@vger.kernel.org,
       greg@kroah.com
Subject: Re: [PATCH] hid-core: Configurable USB HID Mouse Interrupt Polling Interval
Message-ID: <20050208160928.GA6516@ucw.cz>
References: <20050207185706.GA6701@omnipotens.localhost> <3de2c80b050208071520375d28@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3de2c80b050208071520375d28@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2005 at 04:15:53PM +0100, zyphr wrote:
> Something looks odd.
> I've tested this with 2.6.11-rc3-bk5 + your lasted patch
> 
> cat /sys/module/usbhid/parameters/mousepoll says it's at 2ms
> but if I check /proc/bus/usb/devices it's reading 10ms
> 
> I've used parameter under /etc/modules (debian sarge)
> in there I have added: usbhid mousepoll=2
> 
> this used to work ok with:
> http://omfg.linux.dk/pub/configurable-hid-mouse-polling/archive/chmp-r5-add-modparam.patch
> 
> rmmod usbhid and then "modprobe usbhid mousepoll=x" with a different value,
> does change the vualue under /sys
> but under /proc/bus/usb/devices it keeps reading the same value (10ms)
> I also tried replugging the mouse, the value's stay the same.
> 
> I am just a just user, so maybe I did something wrong =)

This is correct. The new patch is not modifying the device descriptors,
which should be considered read-only by driver code, it only changes
only the actual polling behavior.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
