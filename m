Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262123AbTFOKhP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 06:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262127AbTFOKhP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 06:37:15 -0400
Received: from netmail01.services.quay.plus.net ([212.159.14.219]:55287 "HELO
	netmail01.services.quay.plus.net") by vger.kernel.org with SMTP
	id S262123AbTFOKhG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 06:37:06 -0400
From: "Riley Williams" <Riley@Williams.Name>
To: "Vojtech Pavlik" <vojtech@suse.cz>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: [patch] input: Fix CLOCK_TICK_RATE usage ...  [8/13]
Date: Sun, 15 Jun 2003 11:51:00 +0100
Message-ID: <BKEGKPICNAKILKJKMHCAOEGHEFAA.Riley@Williams.Name>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0041_01C33334.63F62EA0"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <20030614231455.A26303@ucw.cz>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0041_01C33334.63F62EA0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Hi.

I've taken Linus out of the CC list as he'll not want to see this until
it's all sorted out...

 >>> ChangeSet@1.1215.104.25, 2003-06-09 14:41:31+02:00, vojtech@suse.cz
 >>>   input: Change input/misc/pcspkr.c to use CLOCK_TICK_RATE instead of
 >>>   a fixed value of 1193182. And change CLOCK_TICK_RATE and several
 >>>   usages of a fixed value 1193180 to a slightly more correct value
 >>>   of 1193182. (True freq is 1.193181818181...).

 >> Is there any reason why you used CLOCK_TICK_RATE in some places and
 >> 1193182 in others ??? I can understand your using the number in the
 >> definition of CLOCK_TICK_RATE but not in the other cases.

 > I only changed the numbers from 1193180 to 1193182 in the patch.
 > The presence of the number instead of CLOCK_TICK_RATE in many drivers
 > is most likely a bug by itself, but that'll need to be addressed in a
 > different patch.
 >
 > The only one place where I fixed it for now is the pcspkr.c driver,
 > since that is the one that actually started the whole thing.

 >> If I'm reading it correctly, the result is a collection of bugs on the
 >> AMD ELAN system as that uses a different frequency (at least, according
 >> to the last but one hunk in your patch)...

 > Care to send me a patch to fix this all completely and for once?

I'm not sure whether your patch was for the 2.4 or 2.5 kernels. Linus has
just released the 2.5.71 kernel which I haven't yet downloaded, but when
UI have, I'll produce a patch for that as well. Enclosed is the relevant
patch against the 2.4.21 raw kernel tree with comments here:

 1. The asm-arm version of timex.h includes an arm-subarch header that
    is presumably supposed to define the relevant CLOCK_TICK_RATE for
    each sub-arch. However, some don't. I've included a catch-all in
    timex.h that defines CLOCK_TICK_RATE as being the standard value
    you've used if it isn't defined otherwise.

    Note that with the exception of the catch-all I've introduced, the
    various arm sub-arches all use values other than 1193182 here, so
    this architecture may need further work.

 2. The IA64 arch didn't define CLOCK_TICK_RATE at all, but then used the
    1193182 value as a magic value in several files. I've inserted that
    as the definition thereof in timex.h for that arch.

 3. The PARISC version of timex.h didn't define CLOCK_TICK_RATE at all.
    Other than the magic values in several generic files, it apparently
    didn't use it either. I've defined it with the 1193182 value here.

This patch defines CLOCK_TICK_RATE for all architectures as far as I can
tell, so the result should compile fine across them all. I can only test
it for the ix86 arch though as that's all I have.

 > Anyone disagrees with changing all the instances of 1193180/1193182 to
 > CLOCK_TICK_RATE?

Other than the ARM architecture, that appears to be the value used for
all of the currently supported architectures in the 2.4 kernel series...

Best wishes from Riley.
---
 * Nothing as pretty as a smile, nothing as ugly as a frown.

---
Outgoing mail is certified Virus Free.
Checked by AVG anti-virus system (http://www.grisoft.com).
Version: 6.0.489 / Virus Database: 288 - Release Date: 10-Jun-2003

------=_NextPart_000_0041_01C33334.63F62EA0
Content-Type: application/octet-stream;
	name="CLOCK_TICK_RATE.diff.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="CLOCK_TICK_RATE.diff.bz2"

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
a3nTL6jHoGjEpibSARge4FJ/8XckU4UJCfjLs6A=

------=_NextPart_000_0041_01C33334.63F62EA0--

