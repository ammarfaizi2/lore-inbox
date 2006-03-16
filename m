Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752378AbWCPQNV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752378AbWCPQNV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 11:13:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752385AbWCPQNV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 11:13:21 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:14094 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1752378AbWCPQNV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 11:13:21 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
in-reply-to: <14CFC56C96D8554AA0B8969DB825FEA0970C7D@chicken.machinevisionproducts.com>
x-originalarrivaltime: 16 Mar 2006 16:13:19.0122 (UTC) FILETIME=[8A119720:01C64914]
Content-class: urn:content-classes:message
Subject: Re: remap_page_range() vs. remap_pfn_range()
Date: Thu, 16 Mar 2006 11:13:18 -0500
Message-ID: <Pine.LNX.4.61.0603161101070.7394@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: remap_page_range() vs. remap_pfn_range()
Thread-Index: AcZJFIokBGyhKY6STC214YsnDaomRw==
References: <14CFC56C96D8554AA0B8969DB825FEA0970C7D@chicken.machinevisionproducts.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Brian D. McGrew" <brian@visionpro.com>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 16 Mar 2006, Brian D. McGrew wrote:

> I've seen the change in the kernel for this call so I changed my device
> drive to use the new call and now every time I access the device the
> machine gets really unstable and crashes after a minute or so.
>
> When changing over the call, what else do I need to change?  All I did
> was change the one call to the other.  Do I have to do anything else?
>
> If someone can't help me, can anybody recommend a consultant that I can
> hire to get this working?  I've already wasted three months on something
> that is way beyond me.
>
> TIA,
>
> :b!
>
> Brian D. McGrew { brian@visionpro.com || brian@doubledimension.com }
> --
>> Those of you who think you know it all,
>  really annoy those of us who do!

Look at the prototype(s)! One takes elements from a structure. The
newer(s) one take both elements from a structure PLUS a pointer to
the structure itself  ... plus .... !

Here are some macros for various kernel versions....

Linux-2.6.10 to linux-current
#define REMAP(a,b,c,d,e) remap_pfn_range((a), (b), (c) >> PAGE_SHIFT, (d), (e))

Linux-2.6.9 Linux-2.6.8
#define REMAP(a,b,c,d,e) remap_page_range((a), (b), (c), (d), (e))

Linux-2.4.n to linux-2.6.5
#define REMAP(a,b,c,d,e) remap_page_range((b), (c), (d), (e))


Cheers,
Dick Johnson
Penguin : Linux version 2.6.15.4 on an i686 machine (5589.54 BogoMips).
Warning : 98.36% of all statistics are fiction, book release in April.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
