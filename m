Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264857AbTANRmy>; Tue, 14 Jan 2003 12:42:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264859AbTANRmy>; Tue, 14 Jan 2003 12:42:54 -0500
Received: from [217.167.51.129] ([217.167.51.129]:21462 "EHLO zion.wanadoo.fr")
	by vger.kernel.org with ESMTP id <S264857AbTANRmt>;
	Tue, 14 Jan 2003 12:42:49 -0500
Subject: Re: Linux 2.4.21-pre3-ac4
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ross Biro <rossb@google.com>
Cc: Alan Cox <alan@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3E244D96.4040008@google.com>
References: <200301131946.h0DJk1w32012@devserv.devel.redhat.com>
	 <1042565893.587.66.camel@zion.wanadoo.fr>  <3E244D96.4040008@google.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1042566769.587.69.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 14 Jan 2003 18:52:49 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-01-14 at 18:49, Ross Biro wrote:
> Benjamin Herrenschmidt wrote:
> 
> >Ok, but PIIX runs on intel platforms with real IOs, so there is no need
> >to perform a read... If we go the hwif->IOSYNC() way, we might well set
> >it up to no-op on x86 PIO iops by default and read of alt-status on
> >other archs if it's safe enough on other controllers/drives...
> >
> I believe that this will corrupt any inprogress UDMA transfer on the 
> promise 20265 chip and probably others.  It would be better to read the 
> dma registers for the Promise controllers.

You mean on the chip's other channel ? As we discussed earlier, we don't
need to enforce this delay at all for DMA as we wait for the DMA
controller to complete in the interrupt anyway. Or did I miss a race ?

Ben.


