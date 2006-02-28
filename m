Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932375AbWB1SIO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932375AbWB1SIO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 13:08:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932376AbWB1SIN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 13:08:13 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:31760 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S932375AbWB1SIN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 13:08:13 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <1141149475.24103.18.camel@camp4.serpentine.com>
x-originalarrivaltime: 28 Feb 2006 18:07:54.0390 (UTC) FILETIME=[E5703B60:01C63C91]
Content-class: urn:content-classes:message
Subject: Re: [PATCH] Define wc_wmb, a write barrier for PCI write combining
Date: Tue, 28 Feb 2006 13:07:50 -0500
Message-ID: <Pine.LNX.4.61.0602281302080.4698@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Define wc_wmb, a write barrier for PCI write combining
Thread-Index: AcY8keV34qdd1ywzSSOsfMNxB5RqGw==
References: <1140841250.2587.33.camel@localhost.localdomain> <yq08xrvhkee.fsf@jaguar.mkp.net> <1141149475.24103.18.camel@camp4.serpentine.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: "Jes Sorensen" <jes@sgi.com>, "Andrew Morton" <akpm@osdl.org>,
       "Andi Kleen" <ak@suse.de>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 28 Feb 2006, Bryan O'Sullivan wrote:

> On Tue, 2006-02-28 at 05:01 -0500, Jes Sorensen wrote:
>
>> Could you explain why the current mmiowb() API won't suffice for this?
>> It seems that this is basically trying to achieve the same thing.
>
> It's a no-op on every arch I care about:
>
> #define mmiowb()
>
> Which makes it useless.  Also, based on the comments in the qla driver,
> mmiowb() seems to have inter-CPU ordering semantics that I don't want.
> I'm thus hesitant to appropriate it for my needs.
>
> 	<b
>

When accessing PCI, you can cause any/all write combinations to
occur and any/all pending writes to get written to the devices
simply by executing a read. If the code requires that all previous
writes be written NOW, then the code should not hide that in
some macro. It should issue a read in its PCI space. Also, the
PCI bus is a FIFO. Nothing gets reordered. Everything will
get to the devices in the order written, but a byte or word on
a longword boundary may be subject to write-combining if all
the components are present in the FIFO.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.15.4 on an i686 machine (5589.54 BogoMips).
Warning : 98.36% of all statistics are fiction, book release in April.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
