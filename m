Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261287AbVDZCgy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261287AbVDZCgy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 22:36:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261289AbVDZCgy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 22:36:54 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:19299 "EHLO
	pd2mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S261287AbVDZCgw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 22:36:52 -0400
Date: Mon, 25 Apr 2005 20:36:37 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: IRQ Disabling
In-reply-to: <3Xgvq-2Vn-9@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <426DA935.3070507@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <3Xgvq-2Vn-9@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Niessner wrote:
> 1) Write some general handler that resets the IRQ and nothing else and
> install it as the default handler instead of the current one that is
> disabling the IRQ?

The only thing the kernel can do generically in this case is what it's 
doing already - disabling the interrupt line. What needs to be done to a 
device to clear the interrupt is device-dependent. If the interrupt 
doesn't get cleared by the handler, it will just keep interrupting 
continuously and using a ton of CPU time.

You could try disabling the USB controller and see if the APC card still 
is producing spurious interrupts. If that's the case, though, fixing the 
driver (so that it properly recognizes the interrupts) or the hardware 
(so it doesn't generate spurious interrupts) is about the only option.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

