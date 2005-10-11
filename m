Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750950AbVJKTtR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750950AbVJKTtR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 15:49:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750957AbVJKTtR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 15:49:17 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:64784 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1750941AbVJKTtQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 15:49:16 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <335DD0B75189FB428E5C32680089FB9F36B115@mtk-sms-mail01.digi.com>
References: <335DD0B75189FB428E5C32680089FB9F36B115@mtk-sms-mail01.digi.com>
X-OriginalArrivalTime: 11 Oct 2005 19:49:11.0682 (UTC) FILETIME=[D9F46620:01C5CE9C]
Content-class: urn:content-classes:message
Subject: RE: [BUG?] 2.6.x (2.6.13) - new signals not being delivered to a terminating (PF_EXITING) process.
Date: Tue, 11 Oct 2005 15:49:11 -0400
Message-ID: <Pine.LNX.4.61.0510111536260.5574@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [BUG?] 2.6.x (2.6.13) - new signals not being delivered to a terminating (PF_EXITING) process.
Thread-Index: AcXOnNn+xkqoU4tXQu+01yV8qFSJ+g==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Kilau, Scott" <Scott_Kilau@digi.com>
Cc: "Linux Kernel Mail List" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 11 Oct 2005, Kilau, Scott wrote:

>
>
>> Once a process in in the 'Z' state it should not receive any
>> signals. Its signal handlers are already gone. It's just a
>> snippit of sys_exit code that remains. If the process truly
>> is in the 'Z' state, its input/output/error file-descriptors
>> should have already been closed so the time-out from the
>> shutdown should have already happened.
>
> Hi Dick,
>
> You are right, its not a zombie.
>
> The process is held up in "drain" in the tty close of the
> processes stdin (/dev/ttyS0).
> (I assumed brackets in ps -ef meant zombies, but that's wrong)
>
> I added some code to make a short timeout in the "tty close" part of
> the driver, then check the values of:
>
> current->signal->shared_pending.list.next
> current->signal->shared_pending.list.prev
>
> They *do* change, when I send the process (date) a signal.
>
> The kernel just isn't waking up the driver's "wait" to let it
> know that there are signals pending.
>


Okay. I have to take a "work break", but you can check the
driver and see if the code is interruptible (it must be)
and if there is something like if(signal_pending(current))
get_to_hell_out_of_this_loop.... in the time-out loop.

You can check against 2.4 code to see what's changed (a lot).
Sometimes with massive re-writes, simple things are forgotten.


> Also, why did this work under 2.4?
>
> This is why I was wondering if this was intentional, or was just an
> oversight...
>

The tty drivers were modified.

> Thanks!
> Scott
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.48 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
