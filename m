Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313162AbSDDNNd>; Thu, 4 Apr 2002 08:13:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313164AbSDDNNX>; Thu, 4 Apr 2002 08:13:23 -0500
Received: from hera.cwi.nl ([192.16.191.8]:9213 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S313162AbSDDNNT>;
	Thu, 4 Apr 2002 08:13:19 -0500
From: Andries.Brouwer@cwi.nl
Date: Thu, 4 Apr 2002 13:13:18 GMT
Message-Id: <UTC200204041313.NAA524931.aeb@cwi.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] omission in video driver
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> if you think a linux KDSBORDER is worthwhile

Maybe mostly fun.

> Ok, so if we feed the above four lines through s/palette/border/g
> then we have an acceptable API?

Yes.

>> [In fact the author of the palette patch did not know the standard
>> for escape sequences, but nobody stopped him.]

> Alas, I too don't know what would be the standard/ANSI escape
> sequences for setting border colours

I meant it differently.

Escape sequences have a certain structure described
in various standards, like ISO 6429 (ECMA 48).
That is useful, it enables applications to parse input
into text and escape sequences without knowing of all
escape sequences precisely what they are supposed to do.

For example, for security one might want to have a filter
that removes the escape sequences (or maybe only the
unrecognized escape sequences) from text written to the
terminal.

Attempt to summarize very briefly:
One has
- single byte codes in 0x00-0x1f, like CR, LF, FF, ESC, BEL, etc.
- single byte codes in 0x80-0x9f, also representable as
  ESC followed by a single byte code in 0x40-0x5f.
  For example, CSI can be 0x9b or ESC [.
- two byte sequences of the form ESC followed by a byte in 0x60-0x7e.
- sequences that start with CSI, then zero or more parameter bytes
  in 0x30-0x3f, then zero or more intermediate bytes in 0x20-0x2f,
  then one final byte in 0x40-0x7e.
  For example, a typical sequence might be ESC [ rr ; cc H
  where rr and cc are sequences of decimal digits, and this
  sequence moves the cursor to row rr and column cc.
- finally there sequences that start with an opening delimiter
  (e.g. ESC _ or ESC P or ESC ] or ESC ^ or ESC X) and end
  with a string terminator (0x9c or ESC \).

The palette setting sequence that Linux uses is
ESC ] P nrrggbb. There is no string terminator here.

So, the structure of the sequence is wrong.
The choice of sequence, probably random, with P for palette,
is also wrong, SGR (set graphics rendition) or DCS (device
control string) would have been more logical choices.

Andries
