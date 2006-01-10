Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030695AbWAKAA0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030695AbWAKAA0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 19:00:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030694AbWAKAA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 19:00:26 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:11443 "EHLO
	pd4mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1030695AbWAKAAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 19:00:24 -0500
Date: Tue, 10 Jan 2006 17:59:16 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: PCI DMA Interrupt latency
In-reply-to: <5trA6-6MD-39@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <43C44A54.5070702@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 8BIT
X-Accept-Language: en-us, en
References: <5trA6-6MD-39@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Burkhard Schölpen wrote:
> Hello,
> 
> I'm writing a driver for a custom pci card with an FPGA 
> (Xilinx Spartan 2 (XC2S150-6) with PCI 32 LogiCore), 
> which  can act as a pci bus master. The device is designed 
> to do DMA transfers with high bandwidth. One task is to 
> send image data to a printer which already works quite 
> well, but sometimes there are randomly occuring 
> problems concerning the timing between two DMA 
> transfers. The issue seems to be something like interrupt 
> latency in hardware. Measuring some signals with an 
> oscilloscope shows, that the delay from generating the 
> interrupt, which signals a finished transfer, to the time 
> when the interrupt register on the card is reset (i.e. the 
> beginning of the ISR) sometimes increases to more 
> than 500 microseconds, which is dimensions too high. 

Most likely some driver is disabling interrupts for that period, which 
is really longer than it should be. However, if your card/driver require 
such tight interrupt latency to function correctly, that seems too 
fragile and may not be reliable. Some kind of ringbuffer arrangement 
would likely work better, so that the interrupt does not have to be 
serviced so soon.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

