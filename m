Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261399AbVBNTDG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261399AbVBNTDG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 14:03:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261430AbVBNTDG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 14:03:06 -0500
Received: from it4systems-kln-gw.de.clara.net ([212.6.222.118]:59597 "EHLO
	frankbuss.de") by vger.kernel.org with ESMTP id S261399AbVBNTDC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 14:03:02 -0500
From: "Frank Buss" <fb@frank-buss.de>
To: <linux-kernel@vger.kernel.org>
Subject: SL811 problem on mach-pxa
Date: Mon, 14 Feb 2005 20:03:03 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
Thread-Index: AcUSx87lYxEcl86VRaq372C/cIGYJw==
Message-Id: <20050214190301.769C75B8A5@frankbuss.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've tried to configure the SL811 driver with 2.6.11 for mach-pxa 
platform, but it doesn't work: The hub was recognized, but no device 
(I've tested it with a USB mouse and keyboard). The hub is visible in 
proc/bus/usb after mounting it.

I've tried to find the bug, but perhaps I'm wrong. This is what I've 
found:

For me it looks like the SL11H_INTMASK_INSRMV interupt in 
drivers/usb/host/sl811-hcd.c is not enabled. In other drivers it looks 
like it is enabled in the start function, like in ohci-pxa27x.c in 
pxa27x_start_hc. After adding a port_power(sl811, 1) call at the end of 
sl811h_start at least the driver gets the interupt, if a mouse is 
connected: it crashes in the "start" function, because ep->hep is NULL. I 
fixed this by setting ep->hep=hep in sl811h_urb_enqueue. But the driver 
still doesn't work. Now it doesn't crash, but I'll get some errors and 
the device is not recognized.

What can I do to find the problem? I wonder if the driver is working at 
all. In Linux 2.4 the driver worked on the same hardware, but looks like 
the driver in Linux 2.6 is rewritten from scratch. But I'm really lost 
when it comes to kernel programming, so maybe it is trivial to fix the 
problem and it is no driver bug.

Another question (perhaps this is related to my problem): Where do I have 
to provide the sl811_platform_data data and what values and functions are 
needed?

-- 
Frank Buﬂ, fb@frank-buss.de
http://www.frank-buss.de, http://www.it4-systems.de

