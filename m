Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964874AbWEZXsn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964874AbWEZXsn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 19:48:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751733AbWEZXsm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 19:48:42 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:54562 "EHLO
	pd3mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1751685AbWEZXsm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 19:48:42 -0400
Date: Fri, 26 May 2006 17:46:32 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: memcpy_toio on i386 using byte writes even when n%2==0
In-reply-to: <6gMqr-8uW-23@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Chris Lesiak <chris.lesiak@licor.com>
Message-id: <44779358.9010703@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <6gMqr-8uW-23@gated-at.bofh.it>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Lesiak wrote:
> I'm working on a driver for a custom PCI card on the i386 architecture.
> The card uses a PLX9030 pci bridge to link an FPGA to the PCI bus using
> a 16 bit bus.  I found that something broke when moving from 2.6.10 to
> 2.6.17-rc4.  In the driver, I use memcpy_toio to write 14 bytes to a
> memory region in the FPGA.
> 
> To copy the 14 bytes, 2.6.10 does three 32 bit writes followed by one 16
> bit write.  2.6.10 does three 32 bit writes followed by two 8 bit write.
> 
> The PLX9030 breaks the 32 bit writes into 16 bit writes for its local
> bus just fine.  The problem is that my board doesn't handle byte
> enables.  It was assumed that if all memory transfers were a multiple of
> 2 bytes, then byte accesses wouldn't be used.  This is no longer true in
> 2.6.7-rc4.
> 
> I've solved the problem by padding to 16 bytes, but should this be
> considered a bug in the kernel?

It does seem a little bit less efficient, but I don't know think it's 
necessarily a bug. There's no guarantee of what size writes will be used 
with the memcpy_to/fromio functions.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

