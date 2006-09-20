Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751953AbWITRHM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751953AbWITRHM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 13:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751887AbWITRHM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 13:07:12 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:10248 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1751953AbWITRHK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 13:07:10 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 20 Sep 2006 17:07:08.0028 (UTC) FILETIME=[344E8BC0:01C6DCD7]
Content-class: urn:content-classes:message
Subject: Re: Block information: Changing from GB to GiB
Date: Wed, 20 Sep 2006 13:07:06 -0400
Message-ID: <Pine.LNX.4.61.0609201248040.25504@chaos.analogic.com>
In-Reply-To: <20060920155328.GB3432@schottelius.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Block information: Changing from GB to GiB
thread-index: Acbc1zR3G5gnj08sQ8GPEI20nYb4KQ==
References: <20060920155328.GB3432@schottelius.org>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "LKML" <linux-kernel@vger.kernel.org>,
       "Nico Schottelius" <nico-kernel20060920@schottelius.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 20 Sep 2006, Nico Schottelius wrote:

> Hello!
>
> Would you accept patches, which
>   a) add printing MiB, GiB, ... ADDITIONALy to MB, GB, ..
>   b) replace GB with GiB
> ?
>
> If so, I would check the kernel source for occurences of those
> units and replace the calculation.
>
> Imho, it would be nicer to print GiB only, because it's the more
> accurate unit (today).
>
> You can have a look at GiB and co. at wikipedia, if you are not familar
> with it: http://en.wikipedia.org/wiki/Gigabyte
>
> Sincerly
>
> Nico
>
> P.S.: Please CC me on reply.
>

This is not trivial. Much Linux code assumes that k = 1024. It's easy
to use and conversions simply use shifts. If you use the newer
standards, where k = 1000, then you may have to divide by decimal
numbers which takes more time and might even be incorrect unless all
the intermediate steps are carried out, retaining any overflow.

I suggest that you just leave the legacy enumeration alone. It
doesn't hurt anything and kernel strings are for programmers
who know what 'k' means (even without the new 'i').  You can look
at the Wikipedia history and see the hassle caused amongst those
writing the entry. My advice is to stay well clear of the politics
where nobody wins. If somebody were to take my code that shifted-off
an integer, leaving the 'k' part and printed it, and replaced it
with integer/1000, I would take a fit -- and rightly so.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.24 on an i686 machine (5592.66 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
