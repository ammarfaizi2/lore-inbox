Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267365AbUI0Uj0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267365AbUI0Uj0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 16:39:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267352AbUI0Ufa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 16:35:30 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:53767 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S267323AbUI0UbU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 16:31:20 -0400
Date: Mon, 27 Sep 2004 21:31:12 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: "Kilau, Scott" <Scott_Kilau@digi.com>
Cc: linux-kernel@vger.kernel.org, wenxiong@us.ibm.com
Subject: Re: [PATCH 2.6.8.1] drivers/char: New serial driver.
Message-ID: <20040927213112.B26680@flint.arm.linux.org.uk>
Mail-Followup-To: "Kilau, Scott" <Scott_Kilau@digi.com>,
	linux-kernel@vger.kernel.org, wenxiong@us.ibm.com
References: <71A17D6448EC0140B44BCEB8CD0DA36E04B9D774@minimail.digi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <71A17D6448EC0140B44BCEB8CD0DA36E04B9D774@minimail.digi.com>; from Scott_Kilau@digi.com on Mon, Sep 27, 2004 at 03:03:32PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
