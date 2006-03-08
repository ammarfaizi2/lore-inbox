Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964786AbWCHABX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964786AbWCHABX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 19:01:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964797AbWCHABX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 19:01:23 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:27371 "EHLO
	pd2mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S964786AbWCHABW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 19:01:22 -0500
Date: Tue, 07 Mar 2006 18:00:31 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: de2104x: interrupts before interrupt handler is registered
In-reply-to: <Pine.LNX.4.61.0603070908460.9133@chaos.analogic.com>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <440E1E9F.3020208@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <5N5Ql-30C-11@gated-at.bofh.it> <5NnDE-44v-11@gated-at.bofh.it>
 <440CCD9A.3070907@shaw.ca>
 <Pine.LNX.4.61.0603070705490.8536@chaos.analogic.com>
 <440D918D.2000502@shaw.ca>
 <Pine.LNX.4.61.0603070908460.9133@chaos.analogic.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os (Dick Johnson) wrote:
> Thinking that a device powers ON in a stable state is naive.

I don't think so.. if you build a device that connects to the PCI bus it 
had better come up in a stable state if it wants to be compliant with 
the spec. That's what the reset line and power-up reset interval is for.

> Many
> complex devices will have FPGA devices with floating pins that don't
> become stable until their contents are loaded serially. Others will
> have IRQ requests based upon power-on states that need to be cleared
> with a software reset. One can't issue a software reset until the
> device is enabled and enabling the device may generate interrupts
> with no handler in place so you have a "can't get there from here"
> problem.

You still aren't seeing my point. Why does enabling the device BARs 
cause the device to generate interrupts? And if there's something you 
need to do to prevent the device from generating interrupts, how can you 
do it without enabling the device?

Also, the device's ISR must clear the condition which is causing the 
interrupt, otherwise interrupt storms will result. If your device can 
enter a state where the interrupt cannot be reliably cleared, how can 
you possibly comply with this?

> Linux-2.4.x had IRQs that were stable. One could put
> a handler in place that would handle the possible burst of interrupts
> upon startup. Then this was changed so the IRQ value is wrong
> until an unrelated and illogical event occurs. Now, you need to
> make work-arounds that were never before necessary. My request
> to fix this fell upon deaf ears.

I don't think any workarounds are needed except for devices that don't 
comply with the spec. Asserting interrupts that have not been 
specifically enabled by the driver would meet that definition in my 
view. If a device happens to do this then maybe a workaround would be 
needed, but that's what it would be, a workaround for a broken device.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

