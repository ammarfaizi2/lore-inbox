Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263082AbTKJJeW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 04:34:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263088AbTKJJeW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 04:34:22 -0500
Received: from mail.humboldt.co.uk ([81.2.65.18]:39878 "EHLO
	mail.humboldt.co.uk") by vger.kernel.org with ESMTP id S263082AbTKJJeV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 04:34:21 -0500
Subject: Re: Exception on host-PCI-bridge master-abort
From: Adrian Cox <adrian@humboldt.co.uk>
To: daz@tiscali.it
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3FAA85C400002BAB@mail-6.tiscali.it>
References: <3FAA85C400002BAB@mail-6.tiscali.it>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 10 Nov 2003 09:34:16 +0000
Message-Id: <1068456857.6750.22.camel@newt>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-11-07 at 19:34, daz@tiscali.it wrote:

> I'm developing i386 linux drivers for a custom PCI card basically built
> on
> a programmable FPGA.
> 
> Every time I re-program the FPGA (without re-booting the PC), the PCI
> configuration regs of the card are resetted, which makes memory and I/O
> aperture of the card disappearing from the PCI bus.
> 
> By calling pci_restore_state() I restore the proper configuration, but
> unfortunately sometimes I'm not fast enough, and the PC issues a read or
> write requests when the card is still wrong configured.
> In such bad situation the PC freezes!

I've dealt with cards like that, but without that sort of problem.
Here's some things to think about: 
 
1) Linux should not issue read or write requests to PCI devices
randomly. If the request is directed to your card, are you sure that it
isn't coming from your own driver code? If so, fix your driver.

2) If the fatal access is to another device, then does your device pass
through an intermediate state where it corrupts accesses to other cards
on the same bus? If so, you need to use a PCI-PCI bridge to put it on a
bus by itself.

3) If it's a new custom card, worry about electrical issues. Maybe the
FPGA configuration fails sometimes.

- Adrian Cox
http://www.humboldt.co.uk/





