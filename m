Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314483AbSFEMYV>; Wed, 5 Jun 2002 08:24:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315406AbSFEMYU>; Wed, 5 Jun 2002 08:24:20 -0400
Received: from d06lmsgate-5.uk.ibm.com ([195.212.29.5]:6330 "EHLO
	d06lmsgate-5.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S314483AbSFEMYU>; Wed, 5 Jun 2002 08:24:20 -0400
Message-Id: <200206051224.g55COIZ208776@d06relay02.portsmouth.uk.ibm.com>
Content-Type: text/plain; charset=US-ASCII
From: Arnd Bergmann <arnd@bergmann-dalldorf.de>
To: Patrick Mochel <mochel@osdl.org>
Subject: Re: device model documentation 3/3
Date: Wed, 5 Jun 2002 16:24:18 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arndb@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Jun 04 2002 - 11:25:19 EST,
Patrick Mochel <mochel@osdl.org> wrote:

> When a driver is removed, the list of devices that it supports is 
> iterated over, and the driver's remove callback is called for each 
> one. The device is removed from that list and the symlinks removed. 

Maybe I'm blind, but I can't see how this works without races for
bridge device drivers. Imagine for example what happens when I rmmod
a usb hcd driver. Its module use count should be zero as long as the 
devices attached to it are not in use, right?
When I e.g. open a file in directory of a device behind my hcd, the 
devices use count is incremented but can still remove the driver.
Reading the file after module unload then can do bad things if the
show() callback was inside the hcd driver.
Did I miss the obvious anywhere?

Arnd <><
