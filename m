Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932070AbWDJSFF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932070AbWDJSFF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 14:05:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932082AbWDJSFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 14:05:05 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:63492 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S932070AbWDJSFD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 14:05:03 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
in-reply-to: <20060410174252.GD2408@stusta.de>
x-originalarrivaltime: 10 Apr 2006 18:04:59.0569 (UTC) FILETIME=[482C6A10:01C65CC9]
Content-class: urn:content-classes:message
Subject: Re: The assemble file under the driver folder can not be recognized when the driver is built as module
Date: Mon, 10 Apr 2006 14:04:59 -0400
Message-ID: <Pine.LNX.4.61.0604101402400.26129@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: The assemble file under the driver folder can not be recognized when the driver is built as module
Thread-Index: AcZcyUg15GEJ1n17R0C+qHQVMD1Kqg==
References: <6d6a94c50604100316j43bcc32p6fa781c0ce47182d@mail.gmail.com> <20060410112817.GE12896@harddisk-recovery.com> <6d6a94c50604100627q297b7335yb58288356aaa8edd@mail.gmail.com> <20060410174252.GD2408@stusta.de>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Adrian Bunk" <bunk@stusta.de>
Cc: "Aubrey" <aubreylee@gmail.com>, "Erik Mouw" <erik@harddisk-recovery.com>,
       <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 10 Apr 2006, Adrian Bunk wrote:

> On Mon, Apr 10, 2006 at 09:27:18PM +0800, Aubrey wrote:
>> ...
>> Makefile is simple.
>> ===============================
>> ----snip----
>> obj-$(CONFIG_FB_BFIN_7171)	  += bfin_ad7171fb.o rgb2ycbcr.o
>> ----snip----
>> ===============================
>> There are two files, bfin_ad7171fb.c and rgb2ycbcr.S under the folder
>> " ./drivers/video".
>> It should be OK because the driver can pass the compilation when
>> select it as built-in.
>> It just failed when select it as module.
>>
>> Thanks your any hints.
>
> You can't build an object only built from an assembler file.
>
> But you don't want to get two modules, you want one module built from
> two source files.
>
> IOW, you want:
>
>  obj-$(CONFIG_FB_BFIN_7171)	+= bfin_ad7171fb.o
>  bfin_ad7171fb-objs		:= bfin_ad7171fb_main.o rgb2ycbcr.o
>
> Note that this requires renaming bfin_ad7171fb.c to bfin_ad7171fb_main.c.
>
>> Regards,
>> -Aubrey
>
> cu
> Adrian

Can't he just put his own private compile definition in his
own Makefile?

%.o:	%.S
 	as -o $@ $<


Cheers,
Dick Johnson
Penguin : Linux version 2.6.15.4 on an i686 machine (5589.42 BogoMips).
Warning : 98.36% of all statistics are fiction, book release in April.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
