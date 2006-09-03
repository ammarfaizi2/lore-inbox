Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751196AbWICKUn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbWICKUn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 06:20:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbWICKUn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 06:20:43 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:32526 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751196AbWICKUm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 06:20:42 -0400
Date: Sun, 3 Sep 2006 11:20:35 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Alex Dubov <oakad@yahoo.com>
Cc: drzeus-list@drzeus.cx, linux-kernel@vger.kernel.org
Subject: Re: Support for TI FlashMedia (pci id 104c:8033, 104c:803b) flash card readers
Message-ID: <20060903102035.GA28880@flint.arm.linux.org.uk>
Mail-Followup-To: Alex Dubov <oakad@yahoo.com>, drzeus-list@drzeus.cx,
	linux-kernel@vger.kernel.org
References: <44F967E8.9020503@drzeus.cx> <20060903074101.77116.qmail@web36707.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060903074101.77116.qmail@web36707.mail.mud.yahoo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 03, 2006 at 12:41:01AM -0700, Alex Dubov wrote:
> > What I'd like to see from you is to double check
> > that bytes_xfered is
> > set to the number of bytes successfully sent to the
> > _card_, not the
> > controller. This is critical for correct handling of
> > bus errors.
> The OMAP datasheet is somewhat unclear, but I think
> that block and byte counters truly represent the
> amount of data shifted out to the mmc bus. Whether
> this data really reaches the flash memory I don't know
> to tell.

It's really the bus we care about at this stage, since the errors we
receive are along the lines of "the card reported that the last data
block had a CRC error", "we encountered an underrun condition during
the last data block", or "the card didn't request data before we
timed out", etc.

Basically, the transfer of the next block confirms that the previous
block was successfully received by the card.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core

-- 
VGER BF report: H 0.00934292
