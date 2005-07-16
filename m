Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261734AbVGPQvp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261734AbVGPQvp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 12:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261710AbVGPQvo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 12:51:44 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:16338 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261734AbVGPQuf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 12:50:35 -0400
Date: Sat, 16 Jul 2005 18:50:33 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: randy_dunlap <rdunlap@xenotime.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Module option for compiled-in parts
In-Reply-To: <20050716091620.3d812b11.rdunlap@xenotime.net>
Message-ID: <Pine.LNX.4.61.0507161846570.4126@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0507161043470.5993@yvahk01.tjqt.qr>
 <20050716091620.3d812b11.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I have added a module_param() to a component that is compiled in
>> (drivers/char/vt.c). Since it's not a module, will it still show a 
>> /sys/module/WhatGoesHere/parameters/myvariablename file? What will be put as 
>> "WhatGoesHere" as vt.c does not become vt.ko?

I actually done it, and a /sys/module/vt popped up, as expected.

>Interesting question.
>
>Are you adding one/some module parameters to vt.c ?

Yes

>I don't see any there.

It's my first.

>I have usbcore built-in (not a loadable module), and I still see
>in /sys/module/usbcore/parameters these files:
>
>blinkenlights
>old_scheme_first
>usbfs_snoop
>use_both_schemes
>
>but usbcore is "defined" as containing a list of .o files
>in drivers/usb/core/Makefile.

I don't know who's deciding what the * in /sys/module/* will be, but it seems 
that the module name will become the one that is listed in obj-y or obj-m, 
respectively.

In your usb case, this would be:
obj-y := usbcore
usbcore-objs := blinkenlights usbfs_snoop otherfiles uhci-hcd

Seems fine for me.

And vt.c is one that applies to obj-y



Jan Engelhardt
-- 
