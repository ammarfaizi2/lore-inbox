Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932315AbWHRUF2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932315AbWHRUF2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 16:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932487AbWHRUF2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 16:05:28 -0400
Received: from spirit.analogic.com ([204.178.40.4]:30987 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S932315AbWHRUF1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 16:05:27 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 18 Aug 2006 20:05:26.0137 (UTC) FILETIME=[A53EAE90:01C6C301]
Content-class: urn:content-classes:message
Subject: Re: Serial issue
Date: Fri, 18 Aug 2006 16:05:20 -0400
Message-ID: <Pine.LNX.4.61.0608181551510.19978@chaos.analogic.com>
In-Reply-To: <1155928885.2924.40.camel@mindpipe>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Serial issue
thread-index: AcbDAaVII8yyFmlYSkKrFpcayzkxxQ==
References: <1155862076.24907.5.camel@mindpipe> <1155915851.3426.4.camel@amdx2.microgate.com> <1155923734.2924.16.camel@mindpipe>  <44E602C8.3030805@microgate.com> <1155925024.2924.22.camel@mindpipe> <Pine.LNX.4.61.0608181512520.19876@chaos.analogic.com> <1155928885.2924.40.camel@mindpipe>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Lee Revell" <rlrevell@joe-job.com>
Cc: "Paul Fulghum" <paulkf@microgate.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>,
       "Russell King" <rmk+lkml@arm.linux.org.uk>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 18 Aug 2006, Lee Revell wrote:

> On Fri, 2006-08-18 at 15:15 -0400, linux-os (Dick Johnson) wrote:
>> A file-transfer protocol??? Has he got hardware the __required__
>> hardware flow-control enabled on both ends? One can't spew
>> high-speed serial data out forever without a hardware handshake.
>>
>
> Interesting you should mention that.  As a matter of fact I have to
> disable all flow control or the serial console doesn't even work.  I
> considered this a minor issue and had forgotten about it.
>
> But, in polled mode with no flow control I can transfer a 10MB file.
> There are a lot of retransmits but it works.
>
> Lee
>

Using RS-232C for file transfer and as a serial console are two
different things. Many terminals and terminal emulators don't
even activate RTS/CTS. If you are just getting data from the
output of a UART to view on a screen, the data usually comes
in spurts, a line at a time, and a screen at a time. There
is plenty of time for the receiving terminal to write the
stuff to the screen.

However, with file transfers, data streams with no breaks.
There needs to be time for these buffers of data to be written
to files, etc., or else you eventually run out of buffers even
if no interrupts are ever lost. Therefore, you must use hardware
handshake. In other words, you need to connect your machines
together with a complete null-modem cable, not just three wires.
Then both machines need to cooperate, i.e., the receiving machine
needs to lower CTS before its buffers get full and the sender,
must look at its RTS bit and wait for it to go false before
sending anymore data. Failure to do this __will__ result in
lost data.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.24 on an i686 machine (5592.62 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
