Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264578AbUFQA1v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264578AbUFQA1v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 20:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264639AbUFQA1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 20:27:50 -0400
Received: from cantor.suse.de ([195.135.220.2]:45954 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264578AbUFQA1t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 20:27:49 -0400
Date: Thu, 17 Jun 2004 02:23:00 +0200
From: Andi Kleen <ak@suse.de>
To: Tim Hockin <thockin@hockin.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Opteron fatal machine check during PCI probe
Message-Id: <20040617022300.6ba744bb.ak@suse.de>
In-Reply-To: <20040617000602.GA7435@hockin.org>
References: <20040617000602.GA7435@hockin.org>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jun 2004 17:06:02 -0700
Tim Hockin <thockin@hockin.org> wrote:

> Hey all,
> 
> I have a couple dual Opteron boxen that consistently gets an MCE during
> PCI probing. This is from linux-2.6.6, but the EXACT same scenario happens
> on a 2.4.x kernel.

> The MCE shows that the error is an IO read, with the address 0xfdfc000cfe.
> The RIP points to pci_conf1_read(), when we try to inw() from the PCI data
> register.

Is it an master abort (0x100 set in MC4_STATUS) ?
If yes it's an BIOS issue, the BIOS are supposed to disable that one.

> This is called during the PCI probing, and stops the kernel dead in it's
> tracks.  The disassembly of the surrounding code is:
> 
> ffffffff802822c5:	89 ca                	mov    %ecx,%edx
> ffffffff802822c7:	83 e2 02             	and    $0x2,%edx
> ffffffff802822ca:	66 81 c2 fc 0c       	add    $0xcfc,%dx
> ffffffff802822cf:	66 ed                	in     (%dx),%ax
> 
> This all seems legit to me.
> 
> What is interesting is that the address 0xfdfc000cfe is correct in the
> low-order 16 bits.  The extra 0xfdfc000000 is what is puzzling to me, or
> maybe it's a red herring.

It is. in only uses 16 bits of its operand.


-Andi
