Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261225AbUCHVoP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 16:44:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261218AbUCHVoP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 16:44:15 -0500
Received: from palrel10.hp.com ([156.153.255.245]:2778 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S261224AbUCHVoK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 16:44:10 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16460.59685.452893.22564@napali.hpl.hp.com>
Date: Mon, 8 Mar 2004 13:44:05 -0800
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Takayoshi Kochi <t-kochi@bq.jp.nec.com>, benjamin.liu@intel.com,
       Russell King <rmk@arm.linux.org.uk>, iod00d@hp.com,
       kaneshige.kenji@jp.fujitsu.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix PCI interrupt setting for ia64
In-Reply-To: <200403081213.22095.bjorn.helgaas@hp.com>
References: <3ACA40606221794F80A5670F0AF15F8401B1A017@PDSMSX403.ccr.corp.intel.com>
	<20040308.182552.55855095.t-kochi@bq.jp.nec.com>
	<200403081213.22095.bjorn.helgaas@hp.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Mon, 8 Mar 2004 12:13:22 -0700, Bjorn Helgaas <bjorn.helgaas@hp.com> said:

  Bjorn> Strictly speaking, since ACPI tells us about IRQs, we
  Bjorn> shouldn't need probe_irq_on() on ia64, should we?

  Bjorn> I don't see any ACPI smarts in the IDE driver, but I think
  Bjorn> the serial driver needs only the attached patch to make it
  Bjorn> avoid the use of probe_irq_on().  I tested this on i2k and
  Bjorn> various HP zx1 boxes, and it works fine.

  Bjorn> Russell, if you agree, would you mind applying this?

  Bjorn> ACPI and HCDP tell us what IRQ the serial port uses, so
  Bjorn> there's no need to have the driver probe for the IRQ.

The patch looks good to me and I certainly agree that probe_irq_on()
should be avoided.  However, as long as this interface is part of the
Linux kernel, we should support it on ia64 since we can't know for
sure when there are no drivers left using that interface.  (And there
is no reason this interface is limited to ISA, though that certainly
is the bus that generally had to use it, for lack of explicit irq
info.)

	--david
