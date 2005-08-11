Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932332AbVHKR5U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932332AbVHKR5U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 13:57:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932323AbVHKR5U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 13:57:20 -0400
Received: from spirit.analogic.com ([208.224.221.4]:63502 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S932333AbVHKR5T convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 13:57:19 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <1123781639.17269.83.camel@localhost.localdomain>
References: <4Ae73-6Mm-5@gated-at.bofh.it> <E1E3DJm-0000jy-0B@be1.lrz> <Pine.LNX.4.61.0508110954360.14541@chaos.analogic.com> <1123770661.17269.59.camel@localhost.localdomain> <2cd57c90050811081374d7c4ef@mail.gmail.com> <Pine.LNX.4.61.0508111124530.14789@chaos.analogic.com> <1123775508.17269.64.camel@localhost.localdomain> <1123777184.17269.67.camel@localhost.localdomain> <2cd57c90050811093112a57982@mail.gmail.com> <2cd57c9005081109597b18cc54@mail.gmail.com> <Pine.LNX.4.61.0508111310180.15153@chaos.analogic.com> <1123781187.17269.77.camel@localhost.localdomain> <1123781639.17269.83.camel@localhost.localdomain>
X-OriginalArrivalTime: 11 Aug 2005 17:57:18.0051 (UTC) FILETIME=[1D1EDB30:01C59E9E]
Content-class: urn:content-classes:message
Subject: Re: Need help in understanding x86 syscall
Date: Thu, 11 Aug 2005 13:57:03 -0400
Message-ID: <Pine.LNX.4.61.0508111348060.15330@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Need help in understanding x86 syscall
Thread-Index: AcWenh0oALfMtmgbS2itM+uI66HQMw==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Steven Rostedt" <rostedt@goodmis.org>
Cc: "Coywolf Qi Hunt" <coywolf@gmail.com>, <7eggert@gmx.de>,
       "Ukil a" <ukil_a@yahoo.com>, <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 11 Aug 2005, Steven Rostedt wrote:

> On Thu, 2005-08-11 at 13:26 -0400, Steven Rostedt wrote:
>
>> 288fb seems to use "int 0x80"  and so do all the other system calls that
>> I inspected.
>
> I expect that if I had a Gentoo system that I compiled for my machine,
> this would be different. But I suspect that Debian still wants to run on
> my old Pentium 75MHz laptop.  How would libc know to use sysenter
> instead of int 0x80.  It could do a test of the system, but would there
> be an if statement for every system call then?   I guess that libc needs
> to be compiled either to use it or not. Since there are still several
> machines out there that don't have this feature, it would be safer to
> not use it.
>
> -- Steve
>

Well I have a small-C runtime library that I put together for
imbedded systems. Once somebody heard that I was using the
"obsolete" int 0x80, they insisted that I re-do everything to
use the new interface. Since I wasn't getting paid to think
on that project, I did what I was told. Bench-marks to 'getpid()'
showed the 0x80 interrupt faster by a few cycles so the "suits"
claimed that I must have done something wrong. So we had a
"code-review".

Finally it was decided; "The CPU must be handling things differently..."
i.e., go back to the simpler int 0x80 interface. It was obvious
to me that any difference in speed was simply noise. Both ways
are essentially the same for performance so I wouldn't lose
any sleep over an "older" 'C' runtime library.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.12 on an i686 machine (5537.79 BogoMips).
Warning : 98.36% of all statistics are fiction.
.
I apologize for the following. I tried to kill it with the above dot :

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
