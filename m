Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261291AbUCHV4T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 16:56:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261330AbUCHVzw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 16:55:52 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:46609 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261296AbUCHVzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 16:55:05 -0500
Date: Mon, 8 Mar 2004 21:54:48 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: davidm@hpl.hp.com
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Takayoshi Kochi <t-kochi@bq.jp.nec.com>, benjamin.liu@intel.com,
       iod00d@hp.com, kaneshige.kenji@jp.fujitsu.com,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix PCI interrupt setting for ia64
Message-ID: <20040308215448.I21938@flint.arm.linux.org.uk>
Mail-Followup-To: davidm@hpl.hp.com, Bjorn Helgaas <bjorn.helgaas@hp.com>,
	Takayoshi Kochi <t-kochi@bq.jp.nec.com>, benjamin.liu@intel.com,
	iod00d@hp.com, kaneshige.kenji@jp.fujitsu.com,
	linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
References: <3ACA40606221794F80A5670F0AF15F8401B1A017@PDSMSX403.ccr.corp.intel.com> <20040308.182552.55855095.t-kochi@bq.jp.nec.com> <200403081213.22095.bjorn.helgaas@hp.com> <16460.59685.452893.22564@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <16460.59685.452893.22564@napali.hpl.hp.com>; from davidm@napali.hpl.hp.com on Mon, Mar 08, 2004 at 01:44:05PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 08, 2004 at 01:44:05PM -0800, David Mosberger wrote:
> >>>>> On Mon, 8 Mar 2004 12:13:22 -0700, Bjorn Helgaas <bjorn.helgaas@hp.com> said:
> 
>   Bjorn> Strictly speaking, since ACPI tells us about IRQs, we
>   Bjorn> shouldn't need probe_irq_on() on ia64, should we?
> 
>   Bjorn> I don't see any ACPI smarts in the IDE driver, but I think
>   Bjorn> the serial driver needs only the attached patch to make it
>   Bjorn> avoid the use of probe_irq_on().  I tested this on i2k and
>   Bjorn> various HP zx1 boxes, and it works fine.
> 
>   Bjorn> Russell, if you agree, would you mind applying this?
> 
>   Bjorn> ACPI and HCDP tell us what IRQ the serial port uses, so
>   Bjorn> there's no need to have the driver probe for the IRQ.
> 
> The patch looks good to me and I certainly agree that probe_irq_on()
> should be avoided.  However, as long as this interface is part of the
> Linux kernel, we should support it on ia64 since we can't know for
> sure when there are no drivers left using that interface.  (And there
> is no reason this interface is limited to ISA, though that certainly
> is the bus that generally had to use it, for lack of explicit irq
> info.)

OTOH, if you know "this port is absolutely definitely using this IRQ"
then you don't want to use IRQ probing.

As long as ACPI positively knows the correct IRQ, so we really shouldn't
be using IRQ probing here.  The only thing which causes me concern is...
what about ACPI table/BIOS bugs?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
