Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750835AbWJES7u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750835AbWJES7u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 14:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750936AbWJES7u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 14:59:50 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:64439
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S1750835AbWJES7t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 14:59:49 -0400
From: Michael Buesch <mb@bu3sch.de>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: Really good idea to allow mmap(0, FIXED)?
Date: Thu, 5 Oct 2006 20:59:11 +0200
User-Agent: KMail/1.9.4
MIME-Version: 1.0
Message-Id: <200610052059.11714.mb@bu3sch.de>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_/XVJFpeG1gqbajJ"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_/XVJFpeG1gqbajJ
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

This question has already been discussed here in the past, but
we did not come to a good result. So I want to ask the question again:

Is is really a good idea to allow processes to remap something
to address 0?
I say no, because this can potentially be used to turn rather harmless
kernel bugs into a security vulnerability.

Let's say we have some kernel NULL pointer dereference bug somewhere,
that's rather harmless, if it happens in process context and
does not leak any resources on segfaulting the triggering app.
So the worst thing that happens is a crashing app. Yeah, this bug must
be fixed. But my point is that this bug can probably be used to
manipulate the way the kernel works or even to inject code into
the kernel from userspace.

Attached to this mail is an example. The kernel module represents
the actual "kernel-bug". Its whole purpose in this example is to
introduce a user-triggerable NULL pointer dereference.
Please stop typing now, if you are typing something like
"If you can load a kernel module, you have access to the kernel anyway".
This is different. We always _had_ and most likely _have_ NULL pointer
dereference bugs in the kernel.

The example programm injects a magic value 0xB15B00B2 into the
kernel, which is printk'ed on success.

In my opinion, this should be forbidden by disallowing mmapping
to address 0. A NULL pointer dereference is such a common bug, that
it is worth protecting against.
Besides that, I currently don't see a valid reason to mmap address 0.

Comments?

-- 
Greetings Michael.

--Boundary-00=_/XVJFpeG1gqbajJ
Content-Type: application/x-tgz;
  name="knulltest.tar.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="knulltest.tar.gz"

H4sIABdVJUUAA+0XaXPaVtBfpV+xJW4iUW6M6ZiSDAHFYcLhAadJOpnRyNITVqyD6HBw2vS3d/dJ
Qgi7dT/E6WSqnYGnt/fxtPt05Ua2HbIgrB88GDQQup0Orc1up7G7pnDQbHSazVanddREvmbjGNmh
83AuZRAFoeYDHDgX/8x3H/07hatt/afaFTMtm319G1Tg46Ojv6t/s91oJ/VvHR93j7H+rXbr6AAa
X9+V2/A/r/+rX5WFIJz04VAKLpltQ+RqDoOqL4uvRmMkPetD3bYu6o5nRDYL6ocSicj1i8iyDfHs
zSgnvf5kyOLwxWRwuhSEn/pQnbegOr5TgeXqdmQwUbRMl30ECfHKYqZMFspEGSwVuSKLj0DXUKnp
ew5cMd9lNnCzENwEIXNE0bv4UHUA7dMpNpjPzJonbp+rSA6IGssiSWR2gBYNZmqRHZ5AFDAfEsdE
kXYxDlmFQ2k4lDGwOBoZql7MntDFROyEOKeDVwpyDJGdsibDtH8oYW7kTDlzDcsURd1mmosypuUa
UIP3ElR5wp+Ua1feEzKy3ee2tdBZq9fMDyzPDXJ8f+bYyjXdMZ7Ae1EQdnWhGzU9rx6Pfe3icyuP
9NmHPSd8a7WLoehRvcwNrH3LDeEP2Gj+KgDfgerCpOyuGQWXrLic3JHNKaCr8DRlo2NApyDZVg6l
T1hoXfO3imRZTI7MVibO6X/9Cn3XkPV/fq71h7BxX/8/bmfzv91Gvmaz2+0W/f9bwKP0nfolCA3L
q10+FXdQN0HdcTQ3j2W+7+4zhtgJVnlc5FqoMo8zdTe090UNbCKEE0UsRWjpECGi3VJDcLQVbvvQ
2Dxvdp43Gs9bPewTLhEsV7r2LBw2v4tCYH1myL3WVkyl554oEA3Ka3widtNIHjYoL2z5ULMUy8oY
qe65pqQuh+rZ4FRZjn9TZBTiHc6USpiF9ZpCrNXeuyVOQWnCSlJsS25UBEGol+EMJw+miBmgGYbP
ggAaUK5ju8wcTDjnLuO4hHy2mJ+rC2Uwwo7Kn98sxudKhTgX9TcJ03Rwpi5fDhYKcqX7wWw+ezed
v15mqBfjt8ooMaM6eMZVmlu3POI+E8/MA7r7GSxIKXIvIc1NM2BhImKZIGHk/djIYDxRcMZhCYQ1
huz5caJ4fgSfhZHvQhOfv4hZJsfuB6aHmEq4uMG+kyXUYY6+vpHWFXjM614BSpVnSnwny70dJec4
lVaMzlx6L5i9nkxg7SEZRzSf/vhzdZbpNw2smIdzQyrVDXZdJ4kq5yxVYK4uRvPZ5B0xUow/mEY+
LhKEfbnbceJOMyTTwCA22wA2eedfRpfPYBlaeLPRbOuaPYsdFFNNjZ745ZsNtaz/J5ekB5gA9/b/
Tjft//ih2OX3/2Zx//8mkDVi23KjTXJLz7fohGIFOp5/S7+TagZ3yjhxY4/aLSijrK0mr2gv6/ZB
0r5Rt8rfHhwmkR7yfgRl+q+Afok1UlV+/y5fRGYF37u07fOGCrZnmrgp48JnAn/ZrvgnhapMlcUp
7DaN+7vFHfKnXgjXmh2xExxIPzZ+fouslXxYt17jNEgaPhQg7z9JgJbrYabKfMFesR81D+MuXTuc
pM9HJH4TgOmtA+xwKFTzPrnMF/pw/nK8VKfz0euJUiE0Gkds6gehKOEJih4r4pfevp2s7uDgmphw
0G0yMR3jxBy9mw2m46E6Hc/mC1JL3wpILO32WESTi4h+TGvOFKVHVS3XCumDidZsuhMNmzBldjfV
6Adpx1IhkWYxuokxrPDSwXzpMbmaNnNkkKmV75Z0sYDS0IvwW9LFsqZyabB7HZmbzwrAB76qsk3s
Lq2Zu9wPCnnPExQX41Kok/FQmS0VqXR6NuF24peOxy8l8cspkmtPrMjFt04BBRRQQAEFFFBAAQUU
UEABBRRQQAEFFPDv4S/WJIm/ACgAAA==

--Boundary-00=_/XVJFpeG1gqbajJ--
