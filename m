Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261198AbVESUaN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261198AbVESUaN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 16:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261247AbVESUaN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 16:30:13 -0400
Received: from zproxy.gmail.com ([64.233.162.194]:14220 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261245AbVESUaB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 16:30:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:from:to:cc:references:subject:date:mime-version:content-type:content-transfer-encoding:x-priority:x-msmail-priority:x-mailer:x-mimeole;
        b=fv4Srl5VQu9xDb2ICwAoPGf5bjidlTv2FbrqLozZRN/tXEcXC66vB6uxDn3yPPTQYe+PPu+VH4rBvGeP714itMKl9DouJCUgXBaYnOx95oj0Au7+bDqCpjvntf5VbhU7UI8n0fhUsWhiF0ApvDK6Ps45xqSo4dJt58taU3J475M=
Message-ID: <039001c55cb1$5f7ad760$1a4da8c0@NELSON2>
From: "Gianluca Varenni" <gianluca.varenni@gmail.com>
To: <linux-os@analogic.com>
Cc: "Linux kernel" <linux-kernel@vger.kernel.org>
References: <02e801c55ca5$7a9d1000$1a4da8c0@NELSON2> <Pine.LNX.4.61.0505191533590.2987@chaos.analogic.com>
Subject: Re: Problem mapping small PCI memory space.
Date: Thu, 19 May 2005 13:28:51 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=response
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2527
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message ----- 
From: "Richard B. Johnson" <linux-os@analogic.com>
To: "Gianluca Varenni" <gianluca.varenni@gmail.com>
Cc: "Linux kernel" <linux-kernel@vger.kernel.org>
Sent: Thursday, May 19, 2005 12:43 PM
Subject: Re: Problem mapping small PCI memory space.


> On Thu, 19 May 2005, Gianluca Varenni wrote:
>
>> Hi all.
>>
>> I'm writing a driver for a PCI board that exposes two memory spaces (out 
>> of
>> the 6 IO address regions).
>>
>> One of them is 1MB, and I can map it to user level without problems. The
>> other one is only 512 bytes.
>> If I try to open it with /dev/mem, it returns EINVAL (the 1MB memory 
>> space
>> is opened without any problem). If I try to expose it through mmap, mmap
>> succeeds, but I only see garbage at user level. At kernel level, I can
>> access that 512 bytes memory by using ioremap() on the physical address
>> returned by pci_resource_start().
>>
>> Are there any lower limits on the size of a PCI memory region?
>>
>> Have a nice day
>> GV
>>
>
> You impliment mmap() in your driver. It accesses the first megabyte
> as 256 pages. Then you tack on the additional page that your 512
> bytes resides at. mmap() only works with pages. The pages must
> be ioremap_nocache and they must be reserved. The reserved part
> is important to have them visible from user-space using mmap.
>
> That's IFF you really need to see the stuff in user-mode. Normally,
> you write a driver that accesses everything using the PCI primatives
> provided in the kernel, for the kernel.

Do you have any link to a linux driver working exactly like this?

Have a nice day
GV

>
>
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.6.11.9 on an i686 machine (5537.79 BogoMips).
>  Notice : All mail here is now cached for review by Dictator Bush.
>                  98.36% of all statistics are fiction. 

