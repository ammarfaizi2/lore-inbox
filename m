Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267779AbUI1UJt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267779AbUI1UJt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 16:09:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267777AbUI1UJt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 16:09:49 -0400
Received: from minimail.digi.com ([204.221.110.13]:34539 "EHLO
	minimail.digi.com") by vger.kernel.org with ESMTP id S268280AbUI1UJU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 16:09:20 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH 2.6.8.1] drivers/char: New serial driver.
Date: Tue, 28 Sep 2004 15:09:17 -0500
Message-ID: <71A17D6448EC0140B44BCEB8CD0DA36E04B9D779@minimail.digi.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2.6.8.1] drivers/char: New serial driver.
Thread-Index: AcSk0PMv8Lu6cfR7QFub6wlch/nhfgAxVj0w
From: "Kilau, Scott" <Scott_Kilau@digi.com>
To: "Russell King" <rmk+lkml@arm.linux.org.uk>
Cc: <linux-kernel@vger.kernel.org>, <wenxiong@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell, all.

For #1, we (Digi) still must support all of the 2.4.x series of kernels
with this driver, so we are unable to convert to the serial_core layer
at this time.

For #2 and #3, IBM and I are in the process of making the changes you
suggest.

Thanks!
Scott Kilau
Digi International


-----Original Message-----
From: Russell King [mailto:rmk+lkml@arm.linux.org.uk] 
Sent: Monday, September 27, 2004 3:31 PM
To: Kilau, Scott
Cc: linux-kernel@vger.kernel.org; wenxiong@us.ibm.com
Subject: Re: [PATCH 2.6.8.1] drivers/char: New serial driver.


On Mon, Sep 27, 2004 at 03:03:32PM -0500, Kilau, Scott wrote:
> I am submitting a new serial driver for the 2.6 series of kernels.
> 
> Description:
> Digi serial driver for the Digi Neo and Classic PCI serial port
> products.
> 
> IBM has requested this submission into the Linux kernel.
> 
> The patch is quite large (300K uncompressed), so rather than attach it
> I am submitting a link to our ftp site where the patch is located.
> 
> ftp://ftp1.digi.com/pub/patches/dgnc.patch

A few comments:

(1) I'm disappointed that you aren't using the serial_core support
    in drivers/serial.
(2) I'm also concerned that you're using serial_reg.h as a description
    of an interface between your hardware specific drivers and your
    hardware independent tty core.  It isn't a description of such an
    interface and therefore should not be used as such.  Please fix
    your code in respect to this.
(3) loopback mode is normally enabled by setting TIOCM_LOOP modem
    control bit via the TIOCMBIS ioctl.

I'd also like Alan Cox to look over the driver since he's looking at
the tty layer.  Alan may have further comments since I've only briefly
looked through it.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
