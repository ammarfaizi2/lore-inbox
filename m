Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261581AbSL1OvP>; Sat, 28 Dec 2002 09:51:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261545AbSL1OvP>; Sat, 28 Dec 2002 09:51:15 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:43910 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP
	id <S261581AbSL1OvO>; Sat, 28 Dec 2002 09:51:14 -0500
Date: Sat, 28 Dec 2002 07:05:33 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFT][PATCH] generic device DMA implementation
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: James.bottomley@steeleye.com, linux-kernel@vger.kernel.org,
       manfred@colorfulllife.com
Message-id: <3E0DBDBD.80701@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
References: <200212280248.SAA25890@adam.yggdrasil.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam J. Richter wrote:
> At 2002-12-28 1:29:54 GMT, David Brownell wrote:
> 
>>Isn't the goal to make sure that for every kind of "struct device *"
>>it should be possible to use those dma_*() calls, without BUGging
>>out.
> 
> 	No.
> 
>>If that's not true ... then why were they defined?
> 
> 	So that other memory mapped busses such as ISA and sbus
> can use them.

That sounds like a "yes", not a "no" ... except for devices on busses
that don't have do memory mapped I/O.  It's what I described:  dma_*()
calls being used with struct device, without BUGging out.


> 	USB devices should do DMA operations with respect to their USB
> host adapters, typically a PCI device.  For example, imagine a machine
> with two USB controllers on different bus instances.

USB already does that ... you write as if it didn't.  It's done that
since pretty early in the 2.4 series, when conversions to the "new" PCI
DMA APIs replaced usage of virt_to_bus and bus_to_virt and USB became
usable on platforms that weren't very PC-like.  Controllers that don't
use PCI also need Linux support, in embedded configs.

However, the device drivers can't do that using the not-yet-generic DMA
calls.  It's handled by usbcore, or by the USB DMA calls.  That works,
and will continue to do so ... but it does highlight how "generic" the
implementation of those APIs is (not very).

- Dave



