Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751398AbWCGRvm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751398AbWCGRvm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 12:51:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751424AbWCGRvm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 12:51:42 -0500
Received: from atlrel7.hp.com ([156.153.255.213]:21429 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S1751398AbWCGRvl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 12:51:41 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Subject: Re: de2104x: interrupts before interrupt handler is registered
Date: Tue, 7 Mar 2006 10:51:35 -0700
User-Agent: KMail/1.8.3
Cc: "Robert Hancock" <hancockr@shaw.ca>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
References: <5N5Ql-30C-11@gated-at.bofh.it> <440D918D.2000502@shaw.ca> <Pine.LNX.4.61.0603070908460.9133@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0603070908460.9133@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603071051.35791.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 March 2006 07:21, linux-os (Dick Johnson) wrote:
> Thinking that a device powers ON in a stable state is naive. Many
> complex devices will have FPGA devices with floating pins that don't
> become stable until their contents are loaded serially. Others will
> have IRQ requests based upon power-on states that need to be cleared
> with a software reset. One can't issue a software reset until the
> device is enabled and enabling the device may generate interrupts
> with no handler in place so you have a "can't get there from here"
> problem.

Maybe you could handle this with a PCI quirk that runs before
pci_enable_device().  IIRC, we considered exposing a separate
interface for PCI IRQ allocation and routing, but decided it
wasn't worth the complexity since so few devices would need it.

> Linux-2.4.x had IRQs that were stable. One could put 
> a handler in place that would handle the possible burst of interrupts
> upon startup. Then this was changed so the IRQ value is wrong
> until an unrelated and illogical event occurs.

There are good reasons to wait to allocate the IRQ until you have
a driver that cares about the device.  I'm sorry that this broke
your specific case.

Bjorn
