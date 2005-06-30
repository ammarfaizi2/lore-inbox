Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262823AbVF3Lb6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262823AbVF3Lb6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 07:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262948AbVF3Lb6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 07:31:58 -0400
Received: from [81.2.110.250] ([81.2.110.250]:40170 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S262823AbVF3Lb4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 07:31:56 -0400
Subject: Re: ISA DMA controller hangs
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <42C3A698.9020404@drzeus.cx>
References: <42987450.9000601@drzeus.cx>
	 <1117288285.2685.10.camel@localhost.localdomain>
	 <42A2B610.1020408@drzeus.cx> <42A3061C.7010604@drzeus.cx>
	 <42B1A08B.8080601@drzeus.cx> <20050616170622.A1712@flint.arm.linux.org.uk>
	 <42C3A698.9020404@drzeus.cx>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1120130926.6482.83.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 30 Jun 2005 12:28:48 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-06-30 at 09:00, Pierre Ossman wrote:
> +	for (i = 0;i < 8;i++) {
> +	  set_dma_addr(i, 0x000000);
> +	  /* DMA count is a bit wierd so this is not 0 */
> +	  set_dma_count(i, 1);

It is spelt "weird"

Looks basically OK although it would be good to document the situation
for a bus mastering DMA controller. Does the device have to reconfigure
the DMA on a resume or is that something the restore code for the device
should handle ?

My own feeling is tha we should dump that on the device (safer) and also
expect the device to prevent suspends during an active DMA transfer (eg
floppy)

Alan

