Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261815AbULLODQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261815AbULLODQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 09:03:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262075AbULLODQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 09:03:16 -0500
Received: from pop.gmx.net ([213.165.64.20]:30373 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261815AbULLODI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 09:03:08 -0500
X-Authenticated: #10070094
Subject: Re: Improved console UTF-8 support for the Linux kernel?
From: Simos Xenitellis <simos74@gmx.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Message-Id: <1102860119.3389.7.camel@kl>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 12 Dec 2004 14:02:00 +0000
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jan Engelhardt wrote: 
> >> The current UTF-8 keyboard input (for the console) of the Linux kernel
> >> does not support  "composing" or writing characters with accents.
> 
> That's weird, because "ö" (LATIN O WITH DIAERESIS) -- which clearly lies
> outside the 7-bit range, is working on my system without myself poking the
> kernel. Both hitting the key or using compose mode. This also applies to
> A-with-DIAERESIS, U-with-DIAERESIS, sharp german S, but does not for anything
> else, e.g. compose-'-e to generate E with accent aigu.

I am a bit confused. Could you please comment on the following, as a
common test steps?

I am not sure how you wrote the above characters. According to UTF-8,
characters with codepoints above 0x79 require two bytes so that to be
valid. When you compose "ö" (you press something like ";", then "o") in
the console?

For simplicity, let's assume you do something like
% loadkeys --unicode
keycode 53 = 0x0d2f
compose '/' 'q' to U+00F6
compose '/' 'w' to U+00F7
compose '/' 'e' to U+00F8
compose '/' 'r' to U+00F9
compose '/' 't' to U+0100
compose '/' 'y' to U+0101
keycode 2 = U+00F6
keycode 3 = U+00F7
keycode 4 = U+00F8
keycode 5 = U+00F9
keycode 6 = U+0100
keycode 7 = U+0101
^D
% 

Dead key (due to "0d") is the character "/" (0x2f).
Keycodes 2-7 are keys for numbers 1-6.
To test, I type
% cat > test.txt
<we try out all key compositions to generate U+00F6-U+0101>
^D

When we try keys 1-6, we get
% od -x text.txt
0000000 b6c3 b7c3 b8c3 b9c3 80c4 81c4 000a
0000015
%
which is correct.

When we try using the dead key "/" and q-y, we get
% od -x test.txt
0000000 f7f6 f9f8 0100 000a
0000007
% 

To get the keyboard in a sane mode, "loadkeys --unicode -d".

>From here we see there is no conversion to UTF-8 whatsoever.

In the second case, the kernel cannot return the full character when it
is in Unicode mode.

> >Yes, i recently find it out when trying to switch all my system to
> >UTF-8. But the patch from Chris you mention below works very well
> >for me (and for anybody that needs to type compose characters for
> >languages based in the latin1 encoding i guess).
> >
> >> Is there an interest for re-submission of mentioned patches for
> >> inclusion in the kernel (yeah, provided coding style is "normalised")?
> >
> >At least, I am _really_ interested :)
> 
> So am I. I have to use xterm for anything fancy now...
> (especially for the even-more fancy stuff that begins at three-byte UTF8
> sequences, such as Japanese :-)

Good. I hope more people raise their hands for this.

Simos

[I am sending this again. It did not make it to the kernel mailing list in the first^Wsecond post for some reason..]

