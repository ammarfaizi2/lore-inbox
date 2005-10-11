Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932233AbVJKR6r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932233AbVJKR6r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 13:58:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751468AbVJKR6r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 13:58:47 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:26885 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1751467AbVJKR6q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 13:58:46 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <20051011103746.61598183.pj@sgi.com>
References: <20051010174429.GH5627@rama><Pine.LNX.4.44L0.0510101559330.10768-100000@netrider.rowland.org> <20051011103746.61598183.pj@sgi.com>
X-OriginalArrivalTime: 11 Oct 2005 17:58:34.0613 (UTC) FILETIME=[65F40A50:01C5CE8D]
Content-class: urn:content-classes:message
Subject: Re: [linux-usb-devel] Re: [BUG/PATCH/RFC] Oops while completing async USB via usbdevio
Date: Tue, 11 Oct 2005 13:58:25 -0400
Message-ID: <Pine.LNX.4.61.0510111352400.6379@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [linux-usb-devel] Re: [BUG/PATCH/RFC] Oops while completing async USB via usbdevio
Thread-Index: AcXOjWX98eVcDMdGSQ2tdJzqXMZLog==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Paul Jackson" <pj@sgi.com>
Cc: "Alan Stern" <stern@rowland.harvard.edu>, <laforge@gnumonks.org>,
       <torvalds@osdl.org>, <chrisw@osdl.org>, <vsu@altlinux.ru>,
       <linux-usb-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
       <security@linux.kernel.org>, <vendor-sec@lst.de>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 11 Oct 2005, Paul Jackson wrote:

> Alan asked:
>> But why do people go to the
>> effort of confusing readers by using "^" instead of "!="?
>
> My guess - eor (^) was quicker than not-equal (!=) on a PDP-11.
>
> That code fragment for checking uid's has been around a -long-
> time, if my memory serves me.
>
> It's gotten to be like the infamous "!!" boolean conversion
> operator, a bit of vernacular that would be harder to read if
> recoded using modern coding style.
>
> --
>                  I won't rest till it's the best ...
>                  Programmer, Linux Scalability
>                  Paul Jackson <pj@sgi.com> 1.925.600.0401

Also, at one time, people used to spend a lot of time
minimizing the number of CPU cycles used in the code.

For instance, when it's appropriate, using XOR makes the
resulting generated code simpler and usually faster:

int funct0(int i)
{
     return i ^ 1;
}
int funct1(int i)
{
     return (i != 1);
}

int main()
{
     int i;
     for(i=0; i< 100; i++)
     {
         if(funct0(i))
             printf("Yep %d\n", i);
         if(funct1(i))
             printf("Yep %d\n", i);
     }
     return 0;
}

gcc -O2 -fomit-frame-pointer ...

Here, funct0 clearly uses less code.

Disassembly of section .text:

00000000 <funct0>:
    0:	8b 44 24 04          	mov    0x4(%esp),%eax
    4:	83 f0 01             	xor    $0x1,%eax
    7:	c3                   	ret

00000008 <funct1>:
    8:	31 c0                	xor    %eax,%eax
    a:	83 7c 24 04 01       	cmpl   $0x1,0x4(%esp)
    f:	0f 95 c0             	setne  %al
   12:	c3                   	ret
   13:	90                   	nop

00000014 <main>:
[SNIPPED...]




Cheers,
Dick Johnson
Penguin : Linux version 2.6.13 on an i686 machine (5589.44 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
