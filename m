Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030380AbVKPPw3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030380AbVKPPw3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 10:52:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030382AbVKPPw3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 10:52:29 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:29970 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1030380AbVKPPw3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 10:52:29 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <437B3C62.2090803@eyal.emu.id.au>
References: <437B3C62.2090803@eyal.emu.id.au>
X-OriginalArrivalTime: 16 Nov 2005 15:52:27.0575 (UTC) FILETIME=[BE84AC70:01C5EAC5]
Content-class: urn:content-classes:message
Subject: Re: hware clock left bad after a system failure
Date: Wed, 16 Nov 2005 10:52:27 -0500
Message-ID: <Pine.LNX.4.61.0511161037130.12055@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: hware clock left bad after a system failure
Thread-Index: AcXqxb6LItyNepzLSJO2cAK/tpTr9Q==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Eyal Lebedinsky" <eyal@eyal.emu.id.au>
Cc: "list linux-kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 16 Nov 2005, Eyal Lebedinsky wrote:

> I recently had two cases where my machine locked up and needed
> a hard reset. The last time magic SysRq did not respond at all.
>
> In these cases I found that the hware clock was set incorrectly
> and the machine comes up with a bad date. It seems that the clock
> is ahead by as much as my TZ (+10 in my case). I may be able
> to understand if it was set 10h behind (kernel set it to UTC)
> but this is the other way. The machine comes up with UTC+20.
>
> Now this is just trouble. The machine comes up and spends 15m
> fscking. I then reset the clock and reboot and it does the whole
> fsck again because it thinks the fs was not checked for eons. It
> does not understand time in the future.
>
> So the points are
>
> - why is the clock mangled in this way?

I am assuming that you have an ix86 kind of machine.

It's probably mangled because you had a hardware-crash.

If you have a driver that accesses the RTC, it needs to leave
the index register at offset 0 so that a hardware crash can
only upset the seconds. Otherwise, even the RTC checksum
can get screwed up, forcing manual reconfiguration of the
BIOS.

During a hardware-crash, the chip enables may go TRUE. This
means that an RTC write can occur with junk that's on the
data-bus.

Now, you need to find out why you had a hardware-crash which
is quite unlike a software-crash. A hardware crash occurs when
you turn OFF the power or the power-good line from the
power-supply goes FALSE. You do not get a hardware-crash from
hitting the reset button. You may have induced the RTC failure
if you hit the power switch instead of the reset button.

> - should e2fsck not allow future check time (maybe within some
>  limits)?

Doesn't the `init` script ask you if you want to fsck the
drive? Most distributions do. Anyways, a time in the future
is one of the ways e2fsck may discover that your file-system
is dorked. You certainly don't want it to ignore it by default.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.51 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
