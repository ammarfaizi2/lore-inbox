Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751278AbWBJPKP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbWBJPKP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 10:10:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751280AbWBJPKO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 10:10:14 -0500
Received: from spirit.analogic.com ([204.178.40.4]:37125 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1751278AbWBJPKM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 10:10:12 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <200602101559.04954.Serge.Noiraud@bull.net>
X-OriginalArrivalTime: 10 Feb 2006 15:10:09.0267 (UTC) FILETIME=[15181C30:01C62E54]
Content-class: urn:content-classes:message
Subject: Re: Memory managment differences between 2.4 and 2.6 with mem=
Date: Fri, 10 Feb 2006 10:10:03 -0500
Message-ID: <Pine.LNX.4.61.0602101000340.3425@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Memory managment differences between 2.4 and 2.6 with mem=
Thread-Index: AcYuVBUfm7UJnC2KRb6xXnmfv98lVg==
References: <200602101559.04954.Serge.Noiraud@bull.net>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Serge Noiraud" <serge.noiraud@bull.net>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 10 Feb 2006, Serge Noiraud wrote:

> Hi,
> 	In 2.4 I used to have mem=2000 on a machine with 2GB of memory.
> I used the differences between 2000 and 2048 for a specific driver.
> This means I use addresses between 0x7d000000 and 0x7fffffff.
> I was sure the system did not take this memory.
>
> In 2.6 it does not work like that.
> In /proc/iomem the end of memory is 0x7d000000.
> I think this is normal.
>
> but I saw the IDE driver allocate 1KB in addresses between 0x7d000000 and
> 0x7d0003ff
>
> 	I have some question  :
> Is it normal ?
> If it is not, how to get the same functionality ? are there some new
> options ?
> Does memap= can help ?
> Is there any impact in the driver ?
>
> I red mel gorman "Understanding the Linux Virtual Memory Manager", but it does not help me.
> In which chapter this is explained ?
>
> --
> Serge Noiraud

Don't use a fixed address! When you load your driver, use the value
in the global, num_physpages, to find out how many pages the kernel
owns. Multiply that by PAGE_SIZE, then add one extra page. Use that
at the starting address for your private page to 'ioremap...'
In principle, you shouldn't have to add an additional page but
the last time I checked, something in the kernel scribbles beyond
the address-space it owns. Also, you should check to see if
some other driver owns the area you want to claim (request_mem_region).
If so, claim another. Remember to release it when unloading your
driver.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.66 BogoMips).
Warning : 98.36% of all statistics are fiction.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
