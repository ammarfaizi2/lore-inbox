Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267540AbSLFD7E>; Thu, 5 Dec 2002 22:59:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267544AbSLFD7D>; Thu, 5 Dec 2002 22:59:03 -0500
Received: from pizda.ninka.net ([216.101.162.242]:56545 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S267540AbSLFD7D>;
	Thu, 5 Dec 2002 22:59:03 -0500
Date: Thu, 05 Dec 2002 20:03:31 -0800 (PST)
Message-Id: <20021205.200331.127813001.davem@redhat.com>
To: david@gibson.dropbear.id.au
Cc: adam@yggdrasil.com, James.Bottomley@steeleye.com, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, miles@gnu.org
Subject: Re: [RFC] generic device DMA implementation
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021206025303.GC17829@zax.zax>
References: <200212060208.SAA05756@adam.yggdrasil.com>
	<20021206025303.GC17829@zax.zax>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I think it's a huge error to try and move the DMA stuff into
the generic device interfaces _AND_ change semantics and arguments
at the same time.

Each operation should be done in seperate steps.

Then, if you want to talk about changing semantics etc. there are
more pressing needs (read as: real bugs) in the current DMA APIs
that must be fixed before you add new "cool" features to the
interfaces.  For example, we have a "pci_dma_sync_*()" interface
which changes ownership from the device back to the cpu, but we
do not have the corollary which returns ownership of the DMA buffer
back to the device.  Basically, every networking device driver that
recycles buffers using pci_dma_sync_*() to peak at the header but then
gives the buffer back to the device is buggy for this reason.

Fix this before changing stuff.

I don't have any time to discuss this further so please do me a big
favor and drop me from the CC: lists, I've been able to only lightly
read the existing parts of this thread, if at all, so the postings
will only hit /dev/null while I'm so busy right now.

Thanks.
