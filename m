Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932094AbVH3EcU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094AbVH3EcU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 00:32:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932116AbVH3EcU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 00:32:20 -0400
Received: from ozlabs.org ([203.10.76.45]:61653 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932094AbVH3EcU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 00:32:20 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17171.57693.981385.165290@cargo.ozlabs.ibm.com>
Date: Tue, 30 Aug 2005 14:32:29 +1000
From: Paul Mackerras <paulus@samba.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       linux-ppc-embedded <linuxppc-embedded@ozlabs.org>,
       linux-kernel@vger.kernel.org, Russell King <rmk+lkml@arm.linux.org.uk>,
       Dan Malek <dan@embeddededge.com>, Pantelis Antoniou <panto@intracom.gr>
Subject: Re: [PATCH] MPC8xx PCMCIA driver
In-Reply-To: <20050830035338.GA5755@dmt.cnet>
References: <20050830024840.GA5381@dmt.cnet>
	<4313D4D6.7080108@pobox.com>
	<20050830035338.GA5755@dmt.cnet>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti writes:

> The memory map structure which contains device configuration/registers
> is _always_ directly mapped with pte's (the 8xx is a chip with builtin
> UART/network/etc functionality).
> 
> I don't think there is a need to use read/write acessors.

Generally on PowerPC you need to use at least the eieio instruction to
prevent reordering of the loads and stores to the device.  It's
possible that 8xx is sufficiently in-order that you get away without
putting in barrier instructions (eieio or sync), but it's not good
practice to omit them.

You can use accessors such as in_be32 and in_le32 in this situation,
when you have a kernel virtual address that is already mapped to the
device.

Regards,
Paul.
