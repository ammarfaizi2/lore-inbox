Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264762AbUFQAGG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264762AbUFQAGG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 20:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264774AbUFQAGG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 20:06:06 -0400
Received: from [66.35.79.110] ([66.35.79.110]:7100 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S264762AbUFQAGD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 20:06:03 -0400
Date: Wed, 16 Jun 2004 17:06:02 -0700
From: Tim Hockin <thockin@hockin.org>
To: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Cc: ak@suse.de
Subject: Opteron fatal machine check during PCI probe
Message-ID: <20040617000602.GA7435@hockin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey all,

I have a couple dual Opteron boxen that consistently gets an MCE during
PCI probing. This is from linux-2.6.6, but the EXACT same scenario happens
on a 2.4.x kernel.

The MCE shows that the error is an IO read, with the address 0xfdfc000cfe.
The RIP points to pci_conf1_read(), when we try to inw() from the PCI data
register.

This is called during the PCI probing, and stops the kernel dead in it's
tracks.  The disassembly of the surrounding code is:

ffffffff802822c5:	89 ca                	mov    %ecx,%edx
ffffffff802822c7:	83 e2 02             	and    $0x2,%edx
ffffffff802822ca:	66 81 c2 fc 0c       	add    $0xcfc,%dx
ffffffff802822cf:	66 ed                	in     (%dx),%ax

This all seems legit to me.

What is interesting is that the address 0xfdfc000cfe is correct in the
low-order 16 bits.  The extra 0xfdfc000000 is what is puzzling to me, or
maybe it's a red herring.

I added a show_registers() to the MCE handler, and %rdx *really* is all
zeros, other than the 0xcfe.

If I disable MCE, then the system boot fine, and runs fine.

Anyone have any ideas?

Tim
