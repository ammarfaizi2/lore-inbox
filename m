Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932280AbWCGT2k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932280AbWCGT2k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 14:28:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932276AbWCGT2k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 14:28:40 -0500
Received: from [81.2.110.250] ([81.2.110.250]:6889 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S932242AbWCGT2j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 14:28:39 -0500
Subject: Re: [PATCH] Document Linux's memory barriers
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       mingo@redhat.com, linux-arch@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0603071346540.9814@chaos.analogic.com>
References: <31492.1141753245@warthog.cambridge.redhat.com>
	 <1141756825.31814.75.camel@localhost.localdomain>
	 <Pine.LNX.4.61.0603071346540.9814@chaos.analogic.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 07 Mar 2006 19:33:41 +0000
Message-Id: <1141760021.2455.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2006-03-07 at 13:54 -0500, linux-os (Dick Johnson) wrote:
> On Tue, 7 Mar 2006, Alan Cox wrote:
> > 	writel(STOP_DMA, &foodev->ctrl);
> > 	free_dma_buffers(foodev);
> >
> > This leads to horrible disasters.
> 
> This might be a good place to document:
>     dummy = readl(&foodev->ctrl);

Absolutely. And this falls outside of the memory barrier functions.
> 
> Will flush all pending writes to the PCI bus and that:
>     (void) readl(&foodev->ctrl);
> ... won't because `gcc` may optimize it away. In fact, variable
> "dummy" should be global or `gcc` may make it go away as well.

If they were ordinary functions then maybe, but they are not so a simple
readl(&foodev->ctrl) will be sufficient and isn't optimised away.

Alan

