Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932431AbWH1MRo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932431AbWH1MRo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 08:17:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932490AbWH1MRo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 08:17:44 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:34064 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S932431AbWH1MRn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 08:17:43 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
x-originalarrivaltime: 28 Aug 2006 12:17:39.0874 (UTC) FILETIME=[F4945020:01C6CA9B]
Content-class: urn:content-classes:message
Subject: Re: Serial custom speed deprecated?
Date: Mon, 28 Aug 2006 08:17:39 -0400
Message-ID: <Pine.LNX.4.61.0608280817030.32531@chaos.analogic.com>
In-Reply-To: <20060826181639.6545.qmail@science.horizon.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Serial custom speed deprecated?
Thread-Index: AcbKm/SdIEnZQm5hQ+WhDC/Fz99cjg==
References: <20060826181639.6545.qmail@science.horizon.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: <linux@horizon.com>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 26 Aug 2006 linux@horizon.com wrote:

>> Or we could just add a standardised extra set of speed ioctls, but then
>> we need to decide what occurs if I set the speed and then issue a
>> termios call - does it override or not.
>
> Actually, we're not QUITE out of bits.  CBAUDEX | B0 is not taken.

B0 is not a bit (there are no bits in 0). It won't work.

> That would make a reasonable encoding for a custom speed.
> (But I haven't checked glibc... ah, yes, it should work!
> See glibc-2.4/sysdeps/unix/sysv/linux/speed.c; browse at
> http://sources.redhat.com/cgi-bin/cvsweb.cgi/libc/sysdeps/unix/sysv/linux/?cvsroot=glibc
> if you don't have a local copy source handy.)
>
> What I'd do is, when converting to the old-style for tcgetattr, if the
> current baud rate is not representable, cache it somewhere and return that
> (or some other magic value).  If a tcsetatt call comes in that specifies
> that magic value, use the cached baud rate.
>
> If you make the cache just the current baud rate setting (the magic
> value on set means "don't alter"), that will handle a lot of programs
> that just want to play with handshaking.
>
> If you make the cache separate, you can also survive an
> old-interface-using program switching to a different baud rate and then
> switching back.
>
>
> Also note that if you truly want to support all baud rates in historical
> use, you'll need to include at least one fractional bit for 134.5 baud.
> (Unless you're sure that IBM 2741 terminals are truly dead. :-))
>
> Alternatively, you could observe that asynchronous communications only
> requires agreement withing 5% between sender and receiver, so specifying
> a baud rate to much better than 1% is not too important.
>
> Half-precision floating point would be ideal for the job. :-)
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.24 on an i686 machine (5592.62 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
