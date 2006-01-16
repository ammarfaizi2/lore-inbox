Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751107AbWAPUaT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107AbWAPUaT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 15:30:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750968AbWAPUaT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 15:30:19 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:58127 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1751070AbWAPUaS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 15:30:18 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <200601161848.k0GIm3xH016052@turing-police.cc.vt.edu>
X-OriginalArrivalTime: 16 Jan 2006 20:30:13.0062 (UTC) FILETIME=[A71EEE60:01C61ADB]
Content-class: urn:content-classes:message
Subject: Re: Shared memory usage 
Date: Mon, 16 Jan 2006 15:30:12 -0500
Message-ID: <Pine.LNX.4.61.0601161510050.23899@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Shared memory usage 
Thread-Index: AcYa26cm6Yv/zAZZTz+DLlN2PnM5+A==
References: <Pine.LNX.4.61.0601160909590.22754@chaos.analogic.com> <200601161848.k0GIm3xH016052@turing-police.cc.vt.edu>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: <Valdis.Kletnieks@vt.edu>
Cc: "Linux kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 16 Jan 2006 Valdis.Kletnieks@vt.edu wrote:

> On Mon, 16 Jan 2006 09:15:16 EST, "linux-os (Dick Johnson)" said:
>> But the customer complained during certification testing
>> that shared memory in use is not measured and therefore
>> cannot be verified. This means that there may be rogue
>> communications channels, using shared memory, in the
>> system. I need to prove that there are no such channels
>> by metering the shared memory and then accounting for
>> every bit shown.
>
> The customer is confused, and your test is broken as designed.
>
> The fact that you look in /proc/meminfo and account for every shared
> memory page *at this instant* doesn't mean there isn't a communication
> channel *at some other time*. Even if you run a daemon that does nothing
> but monitor this usage 10 times a second, and complain if a discrepancy
> is found, it *still* won't work:
>
> 1) It's racy - 2 processes can mmap() some space during that 0.1 seconds,
> transfer the info, and detach the memory without your knowledge.
>
> 2) It's racy - if you inquire *while* some other process is in some
> intermediate
> state, causing false positives that will drive the SSO nuts.
>
> The *proper* solution is to use something like SELinux that will flat-out
> *prohibit* the attachment of a shared memory segment that isn't permitted.
>

The customer is not confused and is, in fact, a known expert.
This is not a "general purpose" setup. There are no executables
except what is burned into R/O PROM. There is no code that can
upload new executables nor any way to execute them. There is no
shell and no init.

There is a startup program called 'init' for convenience, but
whatever it does is hard-coded. It starts a bunch of predefined
tasks and sleeps after performing some initialization.

So, if the executable files are exactly like those which
were reviewed during a security review, and if all
communications between processes can be accounted for,
including shared memory, then it can be guaranteed that
whatever is being executed is exactly what passed the
security review. However, if all communications channels
cannot be accounted for, then it is not possible for such
a guarantee.

It can be argued that, once the executable code is known,
there is no reason to review possible rogue communications
channels. However, the customer is an expert in this field
and requires an audit of all possible communications
channels, including shared memory.

Note that this is an audit. The code for every communications
channel is reviewed. To verify that all such channels are
audited, one needs to find them. For instance even 'vdso' is
audited. These are not continuous audits that operate at
run-time. The reason for this 'static' audit is so that
CPU time eating checks don't have to be done at runtime.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.54 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
