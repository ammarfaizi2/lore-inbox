Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268931AbTGJFIp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 01:08:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268937AbTGJFIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 01:08:45 -0400
Received: from krynn.se.axis.com ([193.13.178.10]:28346 "EHLO
	krynn.se.axis.com") by vger.kernel.org with ESMTP id S268931AbTGJFIk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 01:08:40 -0400
From: "Mikael Starvik" <mikael.starvik@axis.com>
To: "'Alan Shih'" <alan@storlinksemi.com>,
       "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Cc: "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: RE: Question regarding DMA xfer to user space directly
Date: Thu, 10 Jul 2003 07:22:40 +0200
Message-ID: <3C6BEE8B5E1BAC42905A93F13004E8AB03277A7C@mailse01.axis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
In-Reply-To: <3C6BEE8B5E1BAC42905A93F13004E8AB034C5623@mailse01.axis.se>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Use map_user_kiobuf to do this. There are several examples
in the kernel tree. One of the simplest may be 
arch/cris/drivers/examples/kiobuftest.c.

/Mikael

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Alan Shih
Sent: Wednesday, July 09, 2003 7:35 PM
To: Alan Cox
Cc: Linux Kernel Mailing List
Subject: RE: Question regarding DMA xfer to user space directly


Next question would be what are the steps that the driver need to ping user
pages before setting up the xfer?

Thanks.

-----Original Message-----
From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
Sent: Tuesday, July 08, 2003 8:22 AM
To: Alan Shih
Cc: Linux Kernel Mailing List
Subject: Re: Question regarding DMA xfer to user space directly


On Maw, 2003-07-08 at 15:50, Alan Shih wrote:
> Is there a provision in MM for DMA transfer to user space directly 
> without allocating a kernel buffer?

Yes. Its used both for O_DIRECT I/O (direct to disk I/O from userspace) and
for things like tv capture cards. The kernel allows a driver to pin user
pages and obtain mappings for them. Note that for large systems user pages
may be above the 32bit boundary so you need DAC capable hardware to get the
best results

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org More majordomo info at
http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

