Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751212AbVLHQIu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbVLHQIu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 11:08:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbVLHQIu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 11:08:50 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:49673 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1751212AbVLHQIt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 11:08:49 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <1134056272.2867.73.camel@laptopd505.fenrus.org>
X-OriginalArrivalTime: 08 Dec 2005 16:08:47.0821 (UTC) FILETIME=[ABE0D7D0:01C5FC11]
Content-class: urn:content-classes:message
Subject: Re: How to enable/disable security features on mmap() ?
Date: Thu, 8 Dec 2005 11:08:47 -0500
Message-ID: <Pine.LNX.4.61.0512081051250.13997@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: How to enable/disable security features on mmap() ?
Thread-Index: AcX8Eavozjt1JgdZQmu4OpOmTE9R3g==
References: <43983EBE.2080604@labri.fr> <1134051272.2867.63.camel@laptopd505.fenrus.org> <43984154.5050502@labri.fr>  <43984595.1090406@labri.fr> <1134053349.2867.65.camel@laptopd505.fenrus.org> <4398493E.50508@labri.fr> <Pine.LNX.4.61.0512081011020.32448@chaos.analogic.com> <1134056272.2867.73.camel@laptopd505.fenrus.org>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Arjan van de Ven" <arjan@infradead.org>
Cc: "Emmanuel Fleury" <emmanuel.fleury@labri.fr>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 8 Dec 2005, Arjan van de Ven wrote:

>
>> Isn't this too much?  I thought the random-stack patch was
>> only supposed to vary it a page or 64k at most. This looks
>> like some broken logic because it varies almost 8 megabytes!
>
> that is correct; the 64k was only there for one patch proposal; linus'
> tree had 8 Mb randomisation from the start
>
>> No wonder some of my user's database programs sometimes seg-fault
>> and other times work perfectly fine. I think this is incorrect
>> and shows a serious bug (misbehavior).
>
> eh how? This 8Mb isn't eaten from the stack rlimit; the entire stack is
> moved, and the rlimit applies to the size not the position.

The stack moves down! It cannot go below the heap without destroying
malloc()ed buffers. I note that the heap also was "dynamically" moved
down to accommodate this, but its lower limit can't interfere with
_end[], the end of initialized data (fixed by the compiler and
data-size in the program).

0xbfbb6d74	Stack
0xb7e97008	Heap
0x80495e8	_end[]

An 8 megabyte variation is absolutely insane. It follows the "If a
little is good, more must be better..." theory. The purpose of
the random stack start, initially proposed by me BTW, was to
prevent stack-exploit code from being able to hard-code addresses
on the stack. Being off by one byte is enough, 8192 was originally
discussed and, I thought, adopted. Eight megabytes is absurd and has
no technical basis.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.55 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
