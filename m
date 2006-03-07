Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932227AbWCGTQD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932227AbWCGTQD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 14:16:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751526AbWCGTQD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 14:16:03 -0500
Received: from spirit.analogic.com ([204.178.40.4]:61458 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1751446AbWCGTQA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 14:16:00 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <20060307190602.GE7301@parisc-linux.org>
x-originalarrivaltime: 07 Mar 2006 19:15:43.0344 (UTC) FILETIME=[879D9700:01C6421B]
Content-class: urn:content-classes:message
Subject: Re: [PATCH] Document Linux's memory barriers
Date: Tue, 7 Mar 2006 14:15:42 -0500
Message-ID: <Pine.LNX.4.61.0603071408220.9899@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Document Linux's memory barriers
Thread-Index: AcZCG4enKSTWsaHlRx2e8171nca5Ng==
References: <31492.1141753245@warthog.cambridge.redhat.com> <1141756825.31814.75.camel@localhost.localdomain> <Pine.LNX.4.61.0603071346540.9814@chaos.analogic.com> <20060307190602.GE7301@parisc-linux.org>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Matthew Wilcox" <matthew@wil.cx>
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "David Howells" <dhowells@redhat.com>, <torvalds@osdl.org>,
       <akpm@osdl.org>, <mingo@redhat.com>, <linux-arch@vger.kernel.org>,
       <linuxppc64-dev@ozlabs.org>,
       "Linux kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 7 Mar 2006, Matthew Wilcox wrote:

> On Tue, Mar 07, 2006 at 01:54:33PM -0500, linux-os (Dick Johnson) wrote:
>> This might be a good place to document:
>>     dummy = readl(&foodev->ctrl);
>>
>> Will flush all pending writes to the PCI bus and that:
>>     (void) readl(&foodev->ctrl);
>> ... won't because `gcc` may optimize it away. In fact, variable
>> "dummy" should be global or `gcc` may make it go away as well.
>
> static inline unsigned int readl(const volatile void __iomem *addr)
> {
> 	return *(volatile unsigned int __force *) addr;
> }
>
> The cast is volatile, so gcc knows not to optimise it away.
>

When the assignment is not made a.k.a., cast to void, or when the
assignment is made to an otherwise unused variable, `gcc` does,
indeed make it go away. These problems caused weeks of chagrin
after it was found that a PCI DMA operation took 20 or more times
than it should. The writel(START_DMA, &control), followed by
a dummy = readl(&control), ended up with the readl() missing.
That meant that the DMA didn't start until some timer code
read a status register, wondering why it hadn't completed yet.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.15.4 on an i686 machine (5589.50 BogoMips).
Warning : 98.36% of all statistics are fiction, book release in April.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
