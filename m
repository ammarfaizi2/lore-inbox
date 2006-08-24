Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422650AbWHXUn0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422650AbWHXUn0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 16:43:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422649AbWHXUn0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 16:43:26 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:20996 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1422646AbWHXUnZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 16:43:25 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
x-originalarrivaltime: 24 Aug 2006 20:43:23.0900 (UTC) FILETIME=[F1603BC0:01C6C7BD]
Content-class: urn:content-classes:message
Subject: Re: Serial custom speed deprecated?
Date: Thu, 24 Aug 2006 16:43:23 -0400
Message-ID: <Pine.LNX.4.61.0608241635090.13499@chaos.analogic.com>
In-Reply-To: <m31wr6otlr.fsf@defiant.localdomain>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Serial custom speed deprecated?
Thread-Index: AcbHvfFnSM+ypZlUTiG61wWOtUe6Tw==
References: <028a01c6c6fc$e792be90$294b82ce@stuartm><1156411101.3012.15.camel@pmac.infradead.org><m3bqqap09a.fsf@defiant.localdomain><1156441293.3007.184.camel@localhost.localdomain> <m31wr6otlr.fsf@defiant.localdomain>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Krzysztof Halasa" <khc@pm.waw.pl>
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "David Woodhouse" <dwmw2@infradead.org>,
       "Stuart MacDonald" <stuartm@connecttech.com>,
       <linux-serial@vger.kernel.org>, "LKML" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 24 Aug 2006, Krzysztof Halasa wrote:

> Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
>
>>> Does that mean that standard things like termios will use:
>>> #define B9600   9600
>>> #define B19200 19200
>>
>> That would have been very smart when Linus did Linux 0.12, unfortunately
>> he didn't and we've also got no spare bits. Worse still if we exported
>> them that way glibc has now way to map new speeds onto the old ones for
>> applications.
>
> Hmm... I'm not sure if I understand this correctly. Can't we just
> create the 3 new ioctls in the kernel and teach glibc to use it?
>
> The compatibility ioctls would talk to new ioctls only and translate
> things. Anything (userspace) wanting non-traditional speeds would
> have to use new interface (i.e., be compiled against the new glibc)
> and the speeds would show as EXTA or EXTB or something when queried
> using old ioctl.
>
> Yes, the binary interface between glibc and userland would change
> (with compatibility calls translated by glibc to new ioctls, or to
> old ones on older kernels).
>
> The old ioctls would be optional in the kernel (and perhaps in glibc,
> sometime).
>
> Not sure if we want int, uint, or long long for speed values :-)
> --
> Krzysztof Halasa

But the baud-rates have always been some approximation that starts
at 75 and increases by powers-of-two. This is because the hardware
always had fixed clocks with dividers that divided by powers-of-two.
What is the claim for the requirement of strange baud-rates set
as an integer of dimension "baud?" Where does this requirement
come from and what devices use these?

FYI, the EXTA and EXTB were added to accommodate UARTS that
had hardware pre-scalers so that portion of the 'int' was
translated and went somewhere else than the UART divisor.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.24 on an i686 machine (5592.62 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
