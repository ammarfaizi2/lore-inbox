Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965003AbVLFSXf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965003AbVLFSXf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 13:23:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932437AbVLFSXf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 13:23:35 -0500
Received: from spirit.analogic.com ([204.178.40.4]:8966 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S932529AbVLFSXd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 13:23:33 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <20051206175301.34596.qmail@web32110.mail.mud.yahoo.com>
X-OriginalArrivalTime: 06 Dec 2005 18:23:26.0546 (UTC) FILETIME=[2658F320:01C5FA92]
Content-class: urn:content-classes:message
Subject: Re: copy_from_user/copy_to_user question
Date: Tue, 6 Dec 2005 13:23:25 -0500
Message-ID: <Pine.LNX.4.61.0512061314560.5396@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: copy_from_user/copy_to_user question
Thread-Index: AcX6kiZ1DGuoOvZXQ+SiCpKiS9UAeg==
References: <20051206175301.34596.qmail@web32110.mail.mud.yahoo.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Vinay Venkataraghavan" <raghavanvinay@yahoo.com>
Cc: "Steven Rostedt" <rostedt@goodmis.org>, "Andi Kleen" <ak@suse.de>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 6 Dec 2005, Vinay Venkataraghavan wrote:

>
> Thanks to Steve and everybody who sent such detailed
> and timely responses to my question.
>
> The motivation for the copy to user question is due to
> the handling of ioctl calls in the driver for a chip
> that is widely used. I just could not beleive that
> they would/could commit such a mistake.
>
> It looks like the old driver code still seems to work
> even without performing copy_to_user and
> copy_from_user.
>
> But this brings about another scenario. What if the
> case statement in the ioctl call only needs to have
> access to the members of the structure passed in
> through the arg pointer but does not need to modify
> these values and return values.
>
> Is this still a problem if copy_to_user and
> copy_from_user is not used?
>
> Thanks,
> Vinay

If you __access__(note) user-mode data from the kernel, you __must__
use the appropriate /copy/to/from/get/put/user functions and/or
macros. And, you __must__ not be in a spin-lock, or otherwise have
the interrupts disabled, while doing it. There are no exceptions.

(note)__assess__ means even "peek at".

FYI, there should never even be such a question.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.55 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
