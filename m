Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751245AbWELLxp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751245AbWELLxp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 07:53:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbWELLxp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 07:53:45 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:62216 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1751245AbWELLxo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 07:53:44 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 12 May 2006 11:53:41.0676 (UTC) FILETIME=[B6BBB6C0:01C675BA]
Content-class: urn:content-classes:message
Subject: Re: Linux poll() <sigh> again
Date: Fri, 12 May 2006 07:53:41 -0400
Message-ID: <Pine.LNX.4.61.0605120745050.8670@chaos.analogic.com>
In-Reply-To: <4463D1E4.5070605@shaw.ca>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Linux poll() <sigh> again
Thread-Index: AcZ1urbC6mwEqwBeQQaKJ/nAuHI8tg==
References: <6bkl7-56Y-11@gated-at.bofh.it> <4463D1E4.5070605@shaw.ca>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Robert Hancock" <hancockr@shaw.ca>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 11 May 2006, Robert Hancock wrote:

> linux-os (Dick Johnson) wrote:
>> The bug relates to Linux implementation of poll()
>> on a connected socket. If poll() is set to detect
>> changes on a connected socket, with an infinite
>> timeout (-1), and the client disconnects, it returns
>> with a positive value (correct). The returned
>> events (revents member), shows only POLLIN bit
>> set. This, according to all known documentation
>> including man pages on the web, is supposed to
>> mean that there are data to be read. In fact,
>> there are no data and a read will return 0.
>
> According to the Single UNIX Specification:
>
> http://www.opengroup.org/onlinepubs/007908799/xsh/poll.html
>
> POLLIN means "Data other than high-priority data may be read without
> blocking. For STREAMS, this flag is set in revents even if the message
> is of zero length." The way I read it, all this is telling you is that a
> read on that file descriptor will not block at that particular moment.
> It doesn't mean there is actually any data to be read. On a device like
> a socket, read returning 0 tells you that the connection's been closed.
>
> POLLHUP means "The device has been disconnected." This would obviously
> be appropriate for a device such as a serial line or TTY, etc. but for a
> socket it is less obvious that this return value is appropriate.
>

Hardly "less obvious". SunOs has returned POLLHUP as has other
Unixes like Interactive, from which the software was ported. It
went from Interactive, to SunOs, to Linux. Linux was the first
OS that required the hack. This was reported several years ago
and I was simply excoriated for having the audacity to report
such a thing. So, I just implemented a hack. Now the hack is
biting me. It's about time for poll() to return the correct
stuff.

>>
>> I have used the subsequent read() with a returned
>> value of zero, to indicate that the client disconnected
>> (as a work around). However, on recent versions of
>> Linux, this is not reliable and the read() may
>> wait forever instead of immediately returning.
>
> If you want nonblocking behavior, you should set the socket to
> nonblocking. This is a bit strange though, unless the data was stolen by
> another thread or something. Are you sure you've seen this?
>

I don't use threads. The hang under the specified conditions was first
observed on 2.6.16.4 (that I'm running on this system). The hack, previously
used, i.e., the read of zero was used since 2.4.x with success except it's
a hack and shouldn't be required. It was not ever required on SunOs from
which the software was ported.

> --
> Robert Hancock      Saskatoon, SK, Canada
> To email, remove "nospam" from hancockr@nospamshaw.ca
> Home Page: http://www.roberthancock.com/
>
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.4 on an i686 machine (5592.89 BogoMips).
New book: http://www.lymanschool.com
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
