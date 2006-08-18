Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751039AbWHRXQo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751039AbWHRXQo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 19:16:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751049AbWHRXQo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 19:16:44 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:57211 "EHLO
	pd4mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1750948AbWHRXQn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 19:16:43 -0400
Date: Fri, 18 Aug 2006 17:16:59 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: R: R: How to avoid serial port buffer overruns?
In-reply-to: <fa.f1Jp2YDS6/xT0GB2fsQq98CdRtA@ifi.uio.no>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Cc: Giampaolo Tomassoni <g.tomassoni@libero.it>
Message-id: <44E64A6B.8030105@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <fa.QIapfCxFpNcj7ZdkL+1slt8AXnQ@ifi.uio.no>
 <fa.f1Jp2YDS6/xT0GB2fsQq98CdRtA@ifi.uio.no>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os (Dick Johnson) wrote:
> Apparently to handle these kinds of kludges, the kernel
> interrupt code was modified so that the device-driver
> code needs to returna value to the kernel core code.
> If the value is not IRQ_HANDLED, then the ISR will be
> called again. If your ISR never returns IRQ_HANDLED,
> then the kernel core code will shut you off when it
> detects a loop of (last I checked) 10,000 spins.

This isn't to handle the edge-triggered case, that return value is to 
shut off the interrupt entirely in the case of a device that is 
asserting its interrupt but no driver claims to be handling it. 
Otherwise the interrupt storm could cause the machine to simply lock up. 
It doesn't just disable that ISR either, the interrupt line is disabled 
in the interrupt controller which may disable other devices using that line.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

