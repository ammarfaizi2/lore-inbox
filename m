Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262146AbVGVTed@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262146AbVGVTed (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 15:34:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262145AbVGVTed
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 15:34:33 -0400
Received: from spirit.analogic.com ([208.224.221.4]:15627 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S262146AbVGVTe2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 15:34:28 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <3faf056805072210563ed8f158@mail.gmail.com>
References: <3faf0568050721232547aa2482@mail.gmail.com> <7d15175e050722072727a7f539@mail.gmail.com> <3faf0568050722081890a2e@mail.gmail.com> <Pine.LNX.4.61.0507221154150.16740@chaos.analogic.com> <3faf056805072210563ed8f158@mail.gmail.com>
X-OriginalArrivalTime: 22 Jul 2005 19:34:27.0685 (UTC) FILETIME=[5F976950:01C58EF4]
Content-class: urn:content-classes:message
Subject: Re: Whats in this vaddr segment 0xffffe000-0xfffff000 ---p ?
Date: Fri, 22 Jul 2005 15:32:54 -0400
Message-ID: <Pine.LNX.4.61.0507221515040.18320@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Whats in this vaddr segment 0xffffe000-0xfffff000 ---p ?
thread-index: AcWO9F+epoq4qY0XSBKuArvwtVk5Bg==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "vamsi krishna" <vamsi.krishnak@gmail.com>
Cc: "Bhanu Kalyan Chetlapalli" <chbhanukalyan@gmail.com>,
       <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 22 Jul 2005, vamsi krishna wrote:

> Hi,
>
>> It doesn't. The 32-bit machines never show 64 bit words in
>> /proc/NN/maps. They don't "know" how.
>>
>> b7fd6000-b7fd7000 rw-p b7fd6000 00:00 0
>> b7ff5000-b7ff6000 rw-p b7ff5000 00:00 0
>> bffe1000-bfff6000 rw-p bffe1000 00:00 0          [stack]
>> ffffe000-fffff000 ---p 00000000 00:00 0          [vdso]
>> ^^^^^^^^____________ 32 bits
>
> hello john can you tell me what is [vdso], does it have any content
> related file descriptor table it seems that the if I dont save this
> segment during checkpointing,  the file open descriptors (i.e FILE *)
> seems to have null after restoration.
>
> Sincerely appreciate your inputs.
>
> Cheers!
> Vamsi
>

#include <stdio.h>

int main()
{
     long *foo = (long *)0xffffe000;
     printf("%08x\n", foo[0]);
     printf("%08x\n", foo[1]);
     printf("%08x\n", foo[2]);
     printf("%08x\n", foo[3]);
     printf("%08x\n", foo[4]);
     printf("%s\n", (char *)foo);

}

Seems to be readable and starts with 'ELF'. It's something
the the 'C' runtime may library use to make syscalls to the
kernel. Older libraries used interrupt 0x80, newer ones
may use this. Roland McGrath has made patches to this
segment so maybe he knows.



Cheers,
Dick Johnson
Penguin : Linux version 2.6.12 on an i686 machine (5537.79 BogoMips).
Warning : 98.36% of all statistics are fiction.
.
I apologize for the following. I tried to kill it with the above dot :

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
