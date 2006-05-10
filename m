Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964924AbWEJQ5v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964924AbWEJQ5v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 12:57:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964989AbWEJQ5v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 12:57:51 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:17307 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S964924AbWEJQ5u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 12:57:50 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: "Andrea Galbusera" <gizero@gmail.com>
Subject: Re: custom parallel interface driver
Date: Wed, 10 May 2006 10:57:47 -0600
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org
References: <f8e53fb0605100224r298d4799q16c088a5ca9918d5@mail.gmail.com>
In-Reply-To: <f8e53fb0605100224r298d4799q16c088a5ca9918d5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605101057.47870.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 10 May 2006 03:24, Andrea Galbusera wrote:
> Here are some specifications of the hardware module to support (not
> developed by me):
> - single unidirectional Centronics-like with control signals interface
> - 1K x 8bit FIFO for data
> 
> Minimal driver requirements are:
> - capability to read data from the FIFO (possiblbly through ususal
> device file interfaces and using interrupts)
> - capability to read/write control registers of the interface

If the parallel interface is directly exposed as a PCI device
and it supports the typical 8255 programming model, it should
just work if you add the appropriate vendor and device IDs to
parport_pc_pci_tbl[].

The serial driver has a default case that claims any device that
PCI_CLASS_COMMUNICATION_SERIAL class code.  In theory, the parport
driver could claim anything with PCI_CLASS_COMMUNICATION_PARALLEL.
In that case, you wouldn't even need to modify anything.  But
maybe there are issues that prevent parport_pc.c from doing this.

The following sites have lots of information that might be useful
to you:
    http://www.torque.net/linux-pp.html
    http://www.lvr.com/parport.htm
