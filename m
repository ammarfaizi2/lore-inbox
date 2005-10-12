Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751415AbVJLPnz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751415AbVJLPnz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 11:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751465AbVJLPnz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 11:43:55 -0400
Received: from spirit.analogic.com ([204.178.40.4]:9989 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1751415AbVJLPny convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 11:43:54 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <16960.1129131422@www39.gmx.net>
References: <Pine.LNX.4.61.0510121112060.4302@chaos.analogic.com> <16960.1129131422@www39.gmx.net>
X-OriginalArrivalTime: 12 Oct 2005 15:43:46.0201 (UTC) FILETIME=[BB4C1090:01C5CF43]
Content-class: urn:content-classes:message
Subject: Re: blocking file lock functions (lockf,flock,fcntl) do not return after timer signal
Date: Wed, 12 Oct 2005 11:43:45 -0400
Message-ID: <Pine.LNX.4.61.0510121138450.4391@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: blocking file lock functions (lockf,flock,fcntl) do not return after timer signal
Thread-Index: AcXPQ7tcDIV0IllLSoW/tAwD9k4pFA==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Michael Kerrisk" <mtk-lkml@gmx.net>
Cc: <raa.lkml@gmail.com>, <trond.myklebust@fys.uio.no>, <boi@boi.at>,
       <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 12 Oct 2005, Michael Kerrisk wrote:

>> Von: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
>> An: "Alex Riesen" <raa.lkml@gmail.com>
>> Kopie: "Trond Myklebust" <trond.myklebust@fys.uio.no>, <boi@boi.at>,
>> "Linux kernel" <linux-kernel@vger.kernel.org>
>> Betreff: Re: blocking file lock functions (lockf,flock,fcntl) do not
>> return after timer signal
>
> [...]
>
>> Datum: Wed, 12 Oct 2005 11:20:26 -0400
>> As I told you, you use sigaction(). Also flock() will not block
>> unless there is another open on the file. The code will run to
>> your blocking read(), wait 10 seconds, get your "timeout" from
>> the signal handler, then read() will return with -1 and ERESTARTSYS
>> in errno as required.
>
> I was just trying to write a message to say the same ;-).
>
>> Also, using a 'C' runtime library call like write() in a signal-
>> handler is a bug.
>
> But this is not correct.  write() is async-signal-safe (POSIX
> requires it).
>

Then tell it to the doom-sayers who always excoriate me when
I use a 'C' runtime library call in test signal code. I have
been told that the __only__ thing you can do in a signal handler
is access global memory and/or execute siglongjmp().

> Cheers,
>
> Michael
>
> --
> 10 GB Mailbox, 100 FreeSMS/Monat http://www.gmx.net/de/go/topmail
> +++ GMX - die erste Adresse für Mail, Message, More +++
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.56 BogoMips).
Warning : 98.36% of all statistics are fiction.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
