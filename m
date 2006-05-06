Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750704AbWEFTcz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbWEFTcz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 May 2006 15:32:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751095AbWEFTcz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 May 2006 15:32:55 -0400
Received: from smtp113.sbc.mail.mud.yahoo.com ([68.142.198.212]:54628 "HELO
	smtp113.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750704AbWEFTcy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 May 2006 15:32:54 -0400
From: David Brownell <david-b@pacbell.net>
To: "Nathan Becker" <nathanbecker@gmail.com>
Subject: Re: USB 2.0 ehci failure with large amount of RAM (4GB) on x86_64
Date: Sat, 6 May 2006 12:32:51 -0700
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
References: <2151339d0605032148n5d6936ay31ab017fbabc65b3@mail.gmail.com> <200605041922.52243.david-b@pacbell.net> <2151339d0605042246n1e40a496l8af646218edc781e@mail.gmail.com>
In-Reply-To: <2151339d0605042246n1e40a496l8af646218edc781e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605061232.52303.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 04 May 2006 10:46 pm, Nathan Becker wrote:
> Yes, GART_IOMMU is already turned on.  Do you want me to send more
> detailed debugging messages?

And when you tell the kernel to only use 2 GB, it works again right?
Just trying to rule out hardware or hardware-init bugs.

Maybe you could change both dma masks to be 31 bits and then force the
IOMMU active, so it gives out addresses below 2GB.  You should be able
to make it so that the EHCI controller never sees addresss with the
high bit set, making your 4 GB config act like a 2 GB one (via IOMMU).

Which one hopes means "working" ... it'd be good to know a workaround!

This isn't neceessarily a variant of that known NForce silicon bug, but you
could help confirm that by changing the "3strikes" message so it prints
out urb->transfer_dma ... and maybe make qh_completions() dump the dma
addresses of the qh and qtd too (iff urb->status becomes -EPROTO).

