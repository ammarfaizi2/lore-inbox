Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932214AbWJID2R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214AbWJID2R (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 23:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932218AbWJID2R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 23:28:17 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:7063 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932214AbWJID2R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 23:28:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=ktKxBZgLw32QXWAQg4NT/Ii7qGjt3fnWTioHLwzdnyRrGP9JO8n8mwQUeZO/1b1IPjrbxiOnvk+iqAuYt436P1rZj25hJTtyMbReeTxt0065rA3XIeO3lp5/V8zs3gt9oak/1HyLEE5jKanAXnCE+XOYwuJrx6bF95zOZ5jkb0w=
Message-ID: <4529C1DC.4030403@gmail.com>
Date: Mon, 09 Oct 2006 11:28:28 +0800
From: Liyu <raise.sail@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Dmitry Torokhov <dtor@insightbb.com>
CC: "Zephaniah E. Hull" <warp@aehallh.com>, greg <greg@kroah.com>,
       Randy Dunlap <rdunlap@xenotime.net>,
       LKML <linux-kernel@vger.kernel.org>, Liyu <raise.sail@gmail.com>,
       linux-usb-devel <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] [PATCH] usb/hid: The HID Simple Driver	Interface
 0.3.2 (core)
References: <200609291624123283320@gmail.com> <45286B85.90402@gmail.com>	<20061008124146.GA4710@aehallh.com> <200610081009.23978.dtor@insightbb.com>
In-Reply-To: <200610081009.23978.dtor@insightbb.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:
> Yes, I'd consider it a bug. Tearing down and re-creating input device
> generates proper hotplug notifications and userspace needs to respect
> them as capabilities may change even if ids stay the same. For example
> playing with atkbd's scroll attribute will regenerate an input device
> with[out] scroll capabilities but its input_id structure will stay the
> same. 
>   
    So many people said I have some wrongs here ;) it should be truth.

    I found our focus is howto or when send notification to userspace.
Intuitional, to reload such device is rather ugly means, it should have
one hotplug message for this case,
and userspace handle it. If only look from design, I will agree with my
argument, however, if also look from compatibility, I think I must agree
your arguments.

    At last, you win! :D
   
    I am going to reload.
   

PS: I found a behavior of usb subsystem, I can not sure whether it is
normal.
    After I remove usbhid.ko, the uhci_hcd will reset device repeatly.
   

usbcore: registered new driver usbhid
/usr/src/redhat/BUILD/linux-2.6.18/drivers/usb/input/hid-core.c:
v2.6:USB HID core driver
usb 5-2: reset low speed USB device using uhci_hcd and address 3
usb 5-2: reset low speed USB device using uhci_hcd and address 3
usb 5-2: reset low speed USB device using uhci_hcd and address 3
usb 5-2: reset low speed USB device using uhci_hcd and address 3
usb 5-2: reset low speed USB device using uhci_hcd and address 3

    Goodluck.

-Liyu
