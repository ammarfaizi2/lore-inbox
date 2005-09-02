Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750924AbVIBT3I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750924AbVIBT3I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 15:29:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750953AbVIBT3H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 15:29:07 -0400
Received: from spirit.analogic.com ([208.224.221.4]:62475 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1750924AbVIBT3D convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 15:29:03 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <1125688240.4318a3b02f418@webmail.cecs.pdx.edu>
References: <1125688240.4318a3b02f418@webmail.cecs.pdx.edu>
X-OriginalArrivalTime: 02 Sep 2005 19:29:01.0753 (UTC) FILETIME=[92ABA290:01C5AFF4]
Content-class: urn:content-classes:message
Subject: Re: kernel 2.6.13 - space not freed to kernel
Date: Fri, 2 Sep 2005 15:29:01 -0400
Message-ID: <Pine.LNX.4.61.0509021520140.4285@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: kernel 2.6.13 - space not freed to kernel
Thread-Index: AcWv9JK3HuZTAM0HTQ2vaEa28ijaXg==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: <tachades@cecs.pdx.edu>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 2 Sep 2005 tachades@cecs.pdx.edu wrote:

> i have a program that all it does is to allocate memory up until consume 1GB of
> free resources. but when i delete it, it seemed that the space is not free to
> kernel, (notice this by looking at "top" or meminfo, as well as debug messages
> prinf the memory info. using sysinfo (system call). this happens on mainline
> kernel 2.6.13 but not on other Redhat distros (RHEL3/RHEL4).
>
> so it seemed that on mainline 2.6.13, when the userprocess allocate mem and free
> it mem, the freed memory is not returned back to the kernel... is this a
> possible bug????
>
>
> Please Observe this test program:
> Assumption: in main() the space (units in KB) to allocate is 1GB, if you machine
> has less than that use lower space value- 100MB (to be left to avoid oom
> killer).
> Idea: allocate using a linked list to as many nodes as it required to filled up
> 1GB or less of address space
>
> Result: on RHEL3 or 4, after the program allocate nodes, and then deallocate it,
> sysinfo indicate the memory that were freed are returned to the kernel.
> on 2.6.13, after the proram allocate nodes, and then deallocate it, sysinfo give
> the free{ram+swap} to be about the same as it was after the node finish
> allocating, seemed like the freed nodes address space were not returned to the
> kernel
>
> any ideaS?
[SNIPPED strange program]

The program allocates memory. It does this by either setting the break
address or mapping memory. It depends upon the malloc() that your
'C' runtime library uses.

The usual malloc() never resets the break address or remaps memory
because it is an expensive operation. This means that when new
data space needs to be allocated, malloc() doesn't have to get
anything from the kernel because it already has, probably, all
that it needs.

The only way memory will be 'returned' is when your program
calls exit() or otherwise ceases to exist.

FYI, this isn't a kernel issue. Even if it was broken it's
not a kernel issue because the kernel doesn't care what a
user-mode program does with the address-space it has allocated.
It's address-space that it hasn't allocated that it cares
about. That gives you a seg-fault.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13 on an i686 machine (5589.54 BogoMips).
Warning : 98.36% of all statistics are fiction.
.
I apologize for the following. I tried to kill it with the above dot :

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
