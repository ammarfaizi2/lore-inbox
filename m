Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932122AbWCGSys@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122AbWCGSys (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 13:54:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751576AbWCGSys
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 13:54:48 -0500
Received: from spirit.analogic.com ([204.178.40.4]:23822 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1751559AbWCGSyq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 13:54:46 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <1141756825.31814.75.camel@localhost.localdomain>
x-originalarrivaltime: 07 Mar 2006 18:54:41.0300 (UTC) FILETIME=[9760F540:01C64218]
Content-class: urn:content-classes:message
Subject: Re: [PATCH] Document Linux's memory barriers
Date: Tue, 7 Mar 2006 13:54:33 -0500
Message-ID: <Pine.LNX.4.61.0603071346540.9814@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Document Linux's memory barriers
Thread-Index: AcZCGJdqnzrRo9v4R3yEUhXL6YRmOQ==
References: <31492.1141753245@warthog.cambridge.redhat.com> <1141756825.31814.75.camel@localhost.localdomain>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "David Howells" <dhowells@redhat.com>, <torvalds@osdl.org>,
       <akpm@osdl.org>, <mingo@redhat.com>, <linux-arch@vger.kernel.org>,
       <linuxppc64-dev@ozlabs.org>,
       "Linux kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 7 Mar 2006, Alan Cox wrote:
[SNIPPED...]
>
> Not always. MMIO ordering is outside of the CPU ordering rules and into
> PCI and other bus ordering rules. Consider
>
> 	writel(STOP_DMA, &foodev->ctrl);
> 	free_dma_buffers(foodev);
>
> This leads to horrible disasters.

This might be a good place to document:
    dummy = readl(&foodev->ctrl);

Will flush all pending writes to the PCI bus and that:
    (void) readl(&foodev->ctrl);
... won't because `gcc` may optimize it away. In fact, variable
"dummy" should be global or `gcc` may make it go away as well.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.15.4 on an i686 machine (5589.50 BogoMips).
Warning : 98.36% of all statistics are fiction, book release in April.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
