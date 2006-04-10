Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751155AbWDJMSS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbWDJMSS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 08:18:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbWDJMSS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 08:18:18 -0400
Received: from spirit.analogic.com ([204.178.40.4]:58125 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1751155AbWDJMSR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 08:18:17 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
in-reply-to: <200604080917.39562.ak@suse.de>
x-originalarrivaltime: 10 Apr 2006 12:18:02.0775 (UTC) FILETIME=[D065BA70:01C65C98]
Content-class: urn:content-classes:message
Subject: Re: Black box flight recorder for Linux
Date: Mon, 10 Apr 2006 08:18:01 -0400
Message-ID: <Pine.LNX.4.61.0604100754340.25546@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Black box flight recorder for Linux
Thread-Index: AcZcmNBv0N2qS7ToRKKgXDIfnxodxg==
References: <5ZjEd-4ym-37@gated-at.bofh.it> <5ZlZk-7VF-13@gated-at.bofh.it> <4437C335.30107@shaw.ca> <200604080917.39562.ak@suse.de>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Andi Kleen" <ak@suse.de>
Cc: "Robert Hancock" <hancockr@shaw.ca>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 8 Apr 2006, Andi Kleen wrote:

> On Saturday 08 April 2006 16:05, Robert Hancock wrote:
>> Andi Kleen wrote:
>>> James Courtier-Dutton <James@superbug.co.uk> writes:
>>>> Now, the question I have is, if I write values to RAM, do any of those
>>>> values survive a reset?
>>>
>>> They don't generally.
>>>
>>> Some people used to write the oopses into video memory, but that
>>> is not portable.
>>
>> I wouldn't think most BIOSes these days would bother to clear system RAM
>> on a reboot. Certainly Microsoft was encouraging vendors not to do this
>> because it slowed down system boot time.to
>
> Reset button is like a cold boot and it generally ends up with cleared
> RAM.
>
> -Andi

Further, in a boot where the BIOS needs to initialize hardware,
It will write all RAM before enabling NMI. This makes sure that
the parity bit(s) are set properly. Most BIOS will attempt to
preserve RAM on a 'warm' boot as a throw-back to the '286 days
with their above-1MB-memory-manager paged RAM because the
only way to get back from protected mode to 16-bit real mode
was a hardware reset. When using a memory-manager like DOS's
HIMEM.SYS, you might actually be rebooting the machine hundreds
of times per second!

If you want to make a flight-data recorder, you need to use
FAA specs and, as such, you can't rely on second-order effects.
You will need write all the parameters to flash (or equivalent)
at least 10 times per second. I would advise against putting
a file-system on the flash because the file-system might get
corrupt because of a bad write during a crash. Instead, I would
write a large number of identical groups of parameters (a structure
image) at a large number of raw offsets, each with the required
time-stamp. This, done the required 10 times per second.

Note that the NTSB, in investigating some light airplane accidents,
has been successful extracting data from hand-held GPS receivers
and FADEC controllers, so using flash RAM for accident investigation
has some successful history (useful for obtaining certification).

I once proposed a FDR for light aircraft that would cost the end-user
under $2,000. This was to use a small embedded CPU, raw NAV inputs
from the panel, a cheap accelerometer, and some pressure sensors
for altimetry. This would be mounted in the tail, requiring no
user (pilot) input at all. In the event of a crash, the last
hour of flight could be retrieved.

Typical response; "There is no market for this...."

Good luck!

Cheers,
Dick Johnson
Penguin : Linux version 2.6.15.4 on an i686 machine (5589.42 BogoMips).
Warning : 98.36% of all statistics are fiction, book release in April.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
