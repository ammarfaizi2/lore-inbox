Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261885AbTKCDz2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Nov 2003 22:55:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261889AbTKCDz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Nov 2003 22:55:28 -0500
Received: from mtaw4.prodigy.net ([64.164.98.52]:28055 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S261885AbTKCDz1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Nov 2003 22:55:27 -0500
Message-ID: <3FA5CF9E.2060507@pacbell.net>
Date: Sun, 02 Nov 2003 19:46:38 -0800
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: davidm@hpl.hp.com
CC: Greg KH <greg@kroah.com>, vojtech@suse.cz,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: serious 2.6 bug in USB subsystem?
References: <200310272235.h9RMZ9x1000602@napali.hpl.hp.com>	<20031028013013.GA3991@kroah.com>	<200310280300.h9S30Hkw003073@napali.hpl.hp.com>	<3FA12A2E.4090308@pacbell.net> <16289.29015.81760.774530@napali.hpl.hp.com>
In-Reply-To: <16289.29015.81760.774530@napali.hpl.hp.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>   David> I'm not sure that if the HID driver were to pass a null
>   David> buffer pointer, it would be caught anywhere.
> 
> OK, I'll try to find some time to trace the I/O MMU calls to see if
> something isn't kosher at that level.  Is there a good way of getting
> a relatively high-level of tracing in the USB subsystem that would
> some me what's going on between the HID and the core USB level?

Most of that story is just submitting and completing URBs.

I'd either try changing the spots in drivers/usb/core/hcd.c
marked as appropriate for generic MONITOR_URB hooks (printk
if it's your HID device, maybe), or manually turn on whatever
HCD-specific hooks exist (maybe use a VERBOSE message level).

Such a thing wasn't possible in 2.4 since there were too
many different bizarre (and sometimes buggy) ways for URBs
to return to the usb device drivers and get implicitly
resubmitted.

- Dave




