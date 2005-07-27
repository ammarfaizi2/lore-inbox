Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262311AbVG0UBY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262311AbVG0UBY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 16:01:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262150AbVG0UBW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 16:01:22 -0400
Received: from spirit.analogic.com ([208.224.221.4]:23309 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S262462AbVG0T6y convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 15:58:54 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <1122488682.7051.239374398@webmail.messagingengine.com>
References: <1122488682.7051.239374398@webmail.messagingengine.com>
X-OriginalArrivalTime: 27 Jul 2005 19:58:50.0688 (UTC) FILETIME=[9BACB400:01C592E5]
Content-class: urn:content-classes:message
Subject: Re: xor as a lazy comparison
Date: Wed, 27 Jul 2005 15:58:48 -0400
Message-ID: <Pine.LNX.4.61.0507271547580.7346@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: xor as a lazy comparison
thread-index: AcWS5ZvQesCvr+AgQmWIeli3Asd6/w==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Clayton Weaver" <cgweav@fastmail.fm>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 27 Jul 2005, Clayton Weaver wrote:

> Is not xor (^) typically compiled to a
> one cycle instruction regardless of
> requested optimization level? (May not
> always have been the case on every
> target architecture for != equality
> tests.)
> Clayton Weaver
> cgweav at fastmail dot fm
>

I think the XOR thread was started by somebody as a ruse or
a joke. XOR will always destroy the value of an operand. This
means that it needs to be loaded and perhaps reloaded. A 'TEST'
instruction or a 'CMP' instruction never destroys anything and
only affects the flags. TEST is an AND in which the result is
not saved, only the flags get changed. A CMP is a subtract in
which the result is not saved, only the flags. These are
ix86 instructions, but similar instructions exist for other
CPUs.

All these instructions in their simplest form (using registers)
are two-byte instructions!

Disassembly of section .text:

00000000 <.text>:
    0:	39 c3                	cmp    %eax,%ebx
    2:	31 c3                	xor    %eax,%ebx
    4:	85 d8                	test   %ebx,%eax

Instructions that access memory use more bytes...

Cheers,
Dick Johnson
Penguin : Linux version 2.6.12 on an i686 machine (5537.79 BogoMips).
Warning : 98.36% of all statistics are fiction.
.
I apologize for the following. I tried to kill it with the above dot :

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
