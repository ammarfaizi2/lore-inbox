Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932394AbVLMQvL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932394AbVLMQvL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 11:51:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932401AbVLMQvL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 11:51:11 -0500
Received: from radius8.csd.net ([204.151.43.208]:60631 "EHLO
	bastille.tuells.org") by vger.kernel.org with ESMTP id S932394AbVLMQvJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 11:51:09 -0500
Date: Tue, 13 Dec 2005 09:50:57 -0700
From: marcus hall <marcus@tuells.org>
To: linux-kernel@vger.kernel.org
Subject: PCI-ISA bridge and IO resource registration
Message-ID: <20051213165057.GA6276@bastille.tuells.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have run into a problem while dragging an application from 2.4.20 to
2.4.28 (baby steps..)

Anyhow, between these kernel versions, the ACPI code was seriously changed
and now it calls request_resource() for various I/O space resources.

The problem is that the PCI-ISA bridge is also trying to register the
IO address space range (in arch/i386/kernel/pci-i386.c:
pcibios_allocate_resources() ).  Since the ACPI already has resources
allocated in this range, when it tries to allocate the space to the bridge,
the request_resource() call fails and we assign a new address to the bridge
later, which of course confuses the ACPI code since its registers are no
longer at the exptected address.

It seems that the problem is that the resources assigned over a bridge
should not be reserved by a bridge itself, but I don't see where this
gets accounted for.

This is probably brought about because the particular bridge is not explicitly
recognized by the kernel (100b:002b, CS5535 ISA bridge), and I believe that
the kernel thinks that this is a normal PCI device.

Currently, I have the request_resource() calls in ACPI commented out, but
I would really want to get the CS5535 properly treated as a bridge instead,
if I can get a few pointers to how it is supposed to work.

Thanks in advance!

Marcus Hall
marcus@tuells.org
