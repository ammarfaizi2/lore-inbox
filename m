Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268753AbUHTVYB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268753AbUHTVYB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 17:24:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268754AbUHTVYB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 17:24:01 -0400
Received: from a26.t1.student.liu.se ([130.236.221.26]:54996 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S268753AbUHTVX6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 17:23:58 -0400
Message-ID: <41266C5D.7000908@drzeus.cx>
Date: Fri, 20 Aug 2004 23:25:49 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040704)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Timer allocates too many ports
References: <4126600F.4050302@drzeus.cx> <20040820140503.67d23479.rddunlap@osdl.org>
In-Reply-To: <20040820140503.67d23479.rddunlap@osdl.org>
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:

>On Fri, 20 Aug 2004 22:33:19 +0200 Pierre Ossman wrote:
>
>| Hi!
>
>Ho-
>
>| The timer in linux allocates the io ports 0x40 to 0x5F. This is causing 
>| some problems for me since the hardware I'm writing a driver for has its 
>| ports at 0x4E and 0x4F. In Windows the ports 0x40 to 0x43 are used for 
>| the timer. Why does linux allocate so many more ports?
>
>Seems reasonable to me for Linux timer driver (resource) to allocate
>0x40 - 0x43 and 0x50 - 0x53 (on intel x86; only 0x40 - 0x43 for AMD x86-64).
>At least that's what is in some Intel specs.  That would be accurate
>AFAIK and still leave 0x4e - 0x4f available.
>  
>
Unfortunately the driver allocates 0x40-0x5f as can be seen in 
/proc/ioports:
0040-005f : timer
I do not know which file contains this allocation so I haven't been able 
to change it. Any ideas?

>What kind of device uses IO addresses 0x4e - 0x4f?
>Is it a motherboard device?  Intel ICH specs think that 0x4e - 0x4f
>are for LPC SIO and are forwarded to the LPC device.
>
>
>  
>
The device is a SD/MMC card reader which is indeed an LPC device. The 
ports in question are needed to identify the chip and determine which 
resources it has. Actual usage is done on higher ports.

Rgds
Pierre

