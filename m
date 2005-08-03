Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262195AbVHCK5Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262195AbVHCK5Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 06:57:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262202AbVHCK5Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 06:57:16 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:37640 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S262195AbVHCK5P convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 06:57:15 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <1123065472.1590.84.camel@localhost.localdomain>
References: <20050730160345.GA3584@elte.hu> <1122920564.6759.15.camel@localhost.localdomain> <1122931238.4623.17.camel@dhcp153.mvista.com> <1122944010.6759.64.camel@localhost.localdomain> <20050802101920.GA25759@elte.hu> <1123011928.1590.43.camel@localhost.localdomain> <1123025895.25712.7.camel@dhcp153.mvista.com> <1123027226.1590.59.camel@localhost.localdomain> <1123035909.11101.1.camel@c-67-188-6-232.hsd1.ca.comcast.net> <1123036936.1590.69.camel@localhost.localdomain> <1123037933.11101.11.camel@c-67-188-6-232.hsd1.ca.comcast.net> <1123065472.1590.84.camel@localhost.localdomain>
X-OriginalArrivalTime: 03 Aug 2005 10:57:14.0009 (UTC) FILETIME=[1B094090:01C5981A]
Content-class: urn:content-classes:message
Subject: Re: [Question] arch-independent way to differentiate between user andkernel
Date: Wed, 3 Aug 2005 06:56:43 -0400
Message-ID: <Pine.LNX.4.61.0508030647140.9343@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Question] arch-independent way to differentiate between user andkernel
thread-index: AcWYGhsSNGIREfAiRvyfiDa8OmuGPQ==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Steven Rostedt" <rostedt@goodmis.org>
Cc: "LKML" <linux-kernel@vger.kernel.org>,
       "Daniel Walker" <dwalker@mvista.com>, "Ingo Molnar" <mingo@elte.hu>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 3 Aug 2005, Steven Rostedt wrote:

> Hi all,
>
> I'm dealing with a problem where I want to know from __do_IRQ in
> kernel/irq/handle.c if the interrupt occurred while the process was in
> user space or kernel space.  But the trick here is that it must work on
> all architectures.
>
> Does anyone know of some way that that function can tell if it had
> interrupted the kernel or user space?  I know of serveral arch-dependent
> ways, but that's not acceptable right now.
>
> Thanks,
>
> -- Steve
>

The interrupt handler gets a pointer to a structure called "struct pt_regs".
That contains, amongst other things, the registers pushed onto the stack
during the interrupt. If the segments were kernel segments, the interrupt
occurred while in kernel mode. But..... If you have any code that
needs to know, it's horribly and irreparably broken beyond all
repair. Interrupts need to be handled NOW, without regard to what
got interrupted.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.12 on an i686 machine (5537.79 BogoMips).
Warning : 98.36% of all statistics are fiction.
.
I apologize for the following. I tried to kill it with the above dot :

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
