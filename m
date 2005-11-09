Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750752AbVKINgN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750752AbVKINgN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 08:36:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750753AbVKINgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 08:36:13 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:26628 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1750752AbVKINgM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 08:36:12 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <05G2S1G12@briare1.heliogroup.fr>
References: <05G2S1G12@briare1.heliogroup.fr>
X-OriginalArrivalTime: 09 Nov 2005 13:36:10.0917 (UTC) FILETIME=[8BF56D50:01C5E532]
Content-class: urn:content-classes:message
Subject: Re: video4linux user land API concern
Date: Wed, 9 Nov 2005 08:36:08 -0500
Message-ID: <Pine.LNX.4.61.0511090810570.8550@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: video4linux user land API concern
Thread-Index: AcXlMov8UZLgp0HQQguPsnfewEntCg==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Hubert Tonneau" <hubert.tonneau@fullpliant.org>
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Linux kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 9 Nov 2005, Hubert Tonneau wrote:

> Alan Cox wrote:
>>
>> Many of the encodings done by hardware are extremely complicated and
>> tricky to unpack in kernel space. If a camera captures jpeg for example
>> you don't want in kernel jpeg decoders, let alone mpeg decoders etc
>
> So you fall back on the current main bad point about the Linux kernel design.
>

It isn't Linux kernel design. The Linux kernel emulates the Unix
architecture which, by definition, has the kernel performing tasks
on behalf of user programs. The kernel doesn't support the kernel!
It is designed to support user programs as efficiently as possible.
If you need a jpeg decoder, it is simply part of a user program,
hopefully shared with others as a runtime library. You just don't
put user stuff inside the kernel. It has no place there. Look at
Microsoft and see how they did things. They munged user-mode and
kernel stuff all into a slime-ball that gets linked together with
a database (the registry). That's why such systems perform poorly
and will never be reliable or secure.

If the techies (pronunced idiots) at Microsoft had left the Gordon
Bell kernel alone (he also designed VAX/VMS), and let it support
user-mode programs like it should, Linux probably would have died
out when Linus left Helsinki. Instead, people like you convinced
Microsoft that the "good stuff" should be inside the kernel.

People like Alan Cox are going to make sure that it doesn't
happen like that with Linux.

> One quality of Linux, as opposed to some other proposed kernels, is that all
> drivers are part of the kernel tarball, so you can expect to always get drivers
> that are consistent with the kernel internal API.
>
> On the other hand, over time, more and more kernel only related features
> have been rejected to user land, for various reasons mostly related to
> stability and security. I mean 'ifconfig', raid tools, etc.
> Your agument about video decoding falls in the stability category.
>

Again, learn about operating systems in general and what the
Unix/Linux platform is. These things didn't get rejected to user-land
they got put in user-land where they belong for the most efficient
operation.

> Now, if you look for documentation about the interface between the kernel
> and the user land tool that have has been written at the same time to provide
> an overall services (let think about software raid) then you discover that
> it's mosty inexisting, and that the interface in the middle is just an
> unengeneered nightmare.

No. We have a standard API that's well documented.

    Hint: struct file_operations

... for inside the kernel, and the usual open()/close()/read()/write()
/mmap()/poll()/ioctl() for the user-land interface. These are all
things that people who know about this architecture don't even have
to look up.

> So, in facts you can't use the kernel function without adopting the user
> land tool associated, but then you discover that very fiew eyes watched and
> checked the user land part of the tool, and that it's quality is really really
> poor (opens a file, but not check the error code, etc, etc)
>

So fix the user-land tool and send a patch to the maintainer.

> The proper solution seems clear: it is to have an in kernel tarball
> minimalistic glibc, in kernel tarball set of kernel related user land tools so
> that all of them benefit from the magic Linus taste.
> Building the kernel should build a new /kbin/ and /klib/ directory with all
> kernel related user land tools and libraries.
> Then distibutions should just set softlinks to these.
>

The proper solution is to learn what you are talking about,
then contribute something of value.

> As a summary, the fact that you say you don't want to have the decoding
> running at ring 0 does not mean that it should not be part of the kernel
> tarball.
>


Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.55 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
