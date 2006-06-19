Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932514AbWFSPvK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932514AbWFSPvK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 11:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932520AbWFSPvK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 11:51:10 -0400
Received: from spirit.analogic.com ([204.178.40.4]:28176 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S932514AbWFSPvI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 11:51:08 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 19 Jun 2006 15:51:06.0698 (UTC) FILETIME=[2D2012A0:01C693B8]
Content-class: urn:content-classes:message
Subject: Re: Option to clear allocated kernel memory before freeing it?
Date: Mon, 19 Jun 2006 11:51:06 -0400
Message-ID: <Pine.LNX.4.61.0606191145470.4384@chaos.analogic.com>
In-Reply-To: <4496B92A.3010907@free-electrons.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Option to clear allocated kernel memory before freeing it?
thread-index: AcaTuC1D3vE4f/luR5mLCqaLXktQ2g==
References: <4496B92A.3010907@free-electrons.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Michael Opdenacker" <michael-lists@free-electrons.com>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 19 Jun 2006, Michael Opdenacker wrote:

> Hello,
>
> Would it make sense to implement a kernel option that would clear kernel
> memory before freeing it (by kfree or free_page(s))?
>

No. Memory is cleared before being mapped to user-space. Memory
that is allocated for use by the kernel is never cleared by default.
To do so would waste valuable time for nothing gained.

> Unless I'm missing something, uncleared memory previously used for
> kernel allocations could later be recycled for user allocations, making
> it possible for a user program to access sensitive driver data if it's
> lucky.

Wrong. You are missing a lot.

>
> Tough clearing memory should be efficient (thanks to the use of
> memset(), optimized for each platform), there would of course be a
> significant performance hit. However, this could be acceptable for
> systems with strong security requirements...
>

Clearing, using the CPU is never efficient. That's why demand-zero
paging is used by many operating systems.

> What do you think? If this idea makes sense, I'll be glad to help in
> implementing it.
>
>    Thanks in advance,
>    Cheers,
>    Michael.
> --
> Michael Opdenacker, Free Electrons
> Free Embedded Linux Training Materials
> on http://free-electrons.com/training
> (More than 1000 pages!)

Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.4 on an i686 machine (5592.72 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
