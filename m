Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269357AbUJFTsP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269357AbUJFTsP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 15:48:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269415AbUJFTsP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 15:48:15 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:20671 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S269357AbUJFTsB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 15:48:01 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [RFC][PATCH] Way for platforms to alter built-in serial ports
Date: Wed, 6 Oct 2004 13:47:57 -0600
User-Agent: KMail/1.7
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel@vger.kernel.org
References: <200409301014.00725.bjorn.helgaas@hp.com> <20041006082919.B18379@flint.arm.linux.org.uk>
In-Reply-To: <20041006082919.B18379@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410061347.57947.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 06 October 2004 1:29 am, Russell King wrote:
> On Thu, Sep 30, 2004 at 10:14:00AM -0600, Bjorn Helgaas wrote:
> > This looks like a reasonable short-term fix, but I think the whole
> > serial8250_isa_init_ports() should go away.  I like dwmw2's suggestion
> > of an 8250_platform.c that could use register_serial() for each port
> > in some platform-supplied old_serial_port[] table, which is probably
> > what you mean by moving to a more dynamic allocation.
> 
> The only reason it exists in its current form is because Alan says
> we can't get rid of the serial port initialisation due to the x86
> requirement for serial console to be initialised reasonably early.
> 
> Unfortunately the early console stuff (afaik) never made it in to
> the kernel, so we've had to keep this hanging around.

My "console=uart" patch
 http://www.ussg.iu.edu/hypermail/linux/kernel/0409.1/1034.html
is a start, I think.  Relative to the current situation, it
 - requires different syntax ("console=uart" vs "console=ttyS0"),
   though a platform could choose to translate "console=ttyS0"
   into "console=uart,io,0x3f8"
 - can start working much earlier (no interrupts or clock
   calibration required)
 - doesn't deal with all the wierd devices the full driver does
 - transitions automatically to the matching ttyS device after
   the driver is initialized
