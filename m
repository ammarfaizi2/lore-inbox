Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262841AbTJEAvb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 20:51:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262844AbTJEAvb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 20:51:31 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:31501 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S262841AbTJEAv0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 20:51:26 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Horribly overdue update to unicode.txt
Date: 4 Oct 2003 17:51:11 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <blnptv$mnn$1@cesium.transmeta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Here is a horribly overdue update to unicode.txt.  It was circled as a
draft back in 2000, and the change is mostly identical except for text
changes (based on what the official Unicode changes were.)

The changes in summary:

- Straight-to-font is defined as F000-F7FF.
- F800-F804 are deprecated in favour of the new official Unicodes.
- Some additions for keyboards, now described in vendor-neutral
  language.  Note that the looks of any partical glyphs is not
  specified.

		 Last update: 2003-10-04, version 1.2

This file is maintained by H. Peter Anvin <unicode@lanana.org> as part
of the Linux Assigned Names And Numbers Authority (LANANA) project.
The current version can be found at:

	    http://www.lanana.org/docs/unicode/unicode.txt

		       ------------------------

The Linux kernel code has been rewritten to use Unicode to map
characters to fonts.  By downloading a single Unicode-to-font table,
both the eight-bit character sets and UTF-8 mode are changed to use
the font as indicated.

This changes the semantics of the eight-bit character tables subtly.
The four character tables are now:

Map symbol	Map name			Escape code (G0)

LAT1_MAP	Latin-1 (ISO 8859-1)		ESC ( B
GRAF_MAP	DEC VT100 pseudographics	ESC ( 0
IBMPC_MAP	IBM code page 437		ESC ( U
USER_MAP	User defined			ESC ( K

In particular, ESC ( U is no longer "straight to font", since the font
might be completely different than the IBM character set.  This
permits for example the use of block graphics even with a Latin-1 font
loaded.

In accordance with the Unicode standard/ISO 10646 the range U+F000 to
U+F8FF has been reserved for OS-wide allocation (the Unicode Standard
refers to this as a "Corporate Zone", since this is inaccurate for
Linux we call it the "Linux Zone").  U+F000 was picked as the starting
point since it lets the direct-mapping area start on a large power of
two (in case 1024- or 2048-character fonts ever become necessary).
This leaves U+E000 to U+EFFF as End User Zone.

[v1.2]: The Unicodes range from U+F000 and up to U+F7FF have been
hard-coded to map directly to the loaded font, bypassing the
translation table.  The user-defined map now defaults to U+F000 to
U+F0FF, emulating the previous behaviour.  In practice, this range
might be shorter; for example, vgacon can only handle 256-character
(U+F000..U+F0FF) or 512-character (U+F000..U+F1FF) fonts.


Actual characters assigned in the Linux Zone
--------------------------------------------

In addition, the following characters not present in Unicode 1.1.4
have been defined; these are used by the DEC VT graphics map.  [v1.2]
THIS USE IS OBSOLETE AND SHOULD NO LONGER BE USED; PLEASE SEE BELOW.

U+F800 DEC VT GRAPHICS HORIZONTAL LINE SCAN 1
U+F801 DEC VT GRAPHICS HORIZONTAL LINE SCAN 3
U+F803 DEC VT GRAPHICS HORIZONTAL LINE SCAN 7
U+F804 DEC VT GRAPHICS HORIZONTAL LINE SCAN 9

The DEC VT220 uses a 6x10 character matrix, and these characters form
a smooth progression in the DEC VT graphics character set.  I have
omitted the scan 5 line, since it is also used as a block-graphics
character, and hence has been coded as U+2500 FORMS LIGHT HORIZONTAL.

[v1.2]: These characters have been officially added to Unicode 3.2.0;
they are added at U+23BA, U+23BB, U+23BC, U+23BD.  It should be
expected that Linux will change in the future to use these code
values; new fonts should therefore treat both the old and new values
as aliases.

[v1.2]: The following characters have been added to represent common
keyboard symbols that are unlikely to ever be added to Unicode proper
since they are horribly vendor-specific.  This, of course, is an
excellent example on horrible design.

U+F810 KEYBOARD SYMBOL FLYING FLAG
U+F811 KEYBOARD SYMBOL PULLDOWN MENU
U+F812 KEYBOARD SYMBOL OPEN APPLE
U+F813 KEYBOARD SYMBOL SOLID APPLE

Klingon language support
------------------------

Unfortunately, Unicode/ISO 10646 does not allocate code points for the
language Klingon, probably fearing the potential code point explosion
if many fictional languages were submitted for inclusion.  There are
also political reasons (the Japanese, for example, are not too happy
about the whole 16-bit concept to begin with.)  However, with Linux
being a hacker-driven OS it seems this is a brilliant linguistic hack
worth supporting.  Hence I have chosen to add it to the list in the
Linux Zone.

Several glyph forms for the Klingon alphabet have been proposed.
However, since the set of symbols appear to be consistent throughout,
with only the actual shapes being different, in keeping with standard
Unicode practice these differences are considered font variants.

Klingon has an alphabet of 26 characters, a positional numeric writing
system with 10 digits, and is written left-to-right, top-to-bottom.
Punctuation appears to be only used in Latin transliteration; it
appears customary to write each sentence on its own line, and
centered.  Space has been reserved for punctuation should it prove
necessary.

This encoding has been endorsed by the Klingon Language Institute.
For more information, contact them at:

	http://www.kli.org/

Since the characters in the beginning of the Linux CZ have been more
of the dingbats/symbols/forms type and this is a language, I have
located it at the end, on a 16-cell boundary in keeping with standard
Unicode practice.

U+F8D0	KLINGON LETTER A
U+F8D1	KLINGON LETTER B
U+F8D2	KLINGON LETTER CH
U+F8D3	KLINGON LETTER D
U+F8D4	KLINGON LETTER E
U+F8D5	KLINGON LETTER GH
U+F8D6	KLINGON LETTER H
U+F8D7	KLINGON LETTER I
U+F8D8	KLINGON LETTER J
U+F8D9	KLINGON LETTER L
U+F8DA	KLINGON LETTER M
U+F8DB	KLINGON LETTER N
U+F8DC	KLINGON LETTER NG
U+F8DD	KLINGON LETTER O
U+F8DE	KLINGON LETTER P
U+F8DF	KLINGON LETTER Q
	- Written <q> in standard Okrand Latin transliteration
U+F8E0	KLINGON LETTER QH
	- Written <Q> in standard Okrand Latin transliteration
U+F8E1	KLINGON LETTER R
U+F8E2	KLINGON LETTER S
U+F8E3	KLINGON LETTER T
U+F8E4	KLINGON LETTER TLH
U+F8E5	KLINGON LETTER U
U+F8E6	KLINGON LETTER V
U+F8E7	KLINGON LETTER W
U+F8E8	KLINGON LETTER Y
U+F8E9	KLINGON LETTER GLOTTAL STOP

U+F8F0	KLINGON DIGIT ZERO
U+F8F1	KLINGON DIGIT ONE
U+F8F2	KLINGON DIGIT TWO
U+F8F3	KLINGON DIGIT THREE
U+F8F4	KLINGON DIGIT FOUR
U+F8F5	KLINGON DIGIT FIVE
U+F8F6	KLINGON DIGIT SIX
U+F8F7	KLINGON DIGIT SEVEN
U+F8F8	KLINGON DIGIT EIGHT
U+F8F9	KLINGON DIGIT NINE

U+F8FF	KLINGON SYMBOL FOR EMPIRE

Other Fictional and Artificial Scripts
--------------------------------------

Since the assignment of the Klingon Linux Unicode block, a registry of
fictional and artificial scripts has been established by John Cowan,
<cowan@ccil.org>.  The ConScript Unicode Registry is accessible at
<http://locke.ccil.org/~cowan/csur/>; the ranges used fall at the bottom
of the End User Zone and can hence not be normatively assigned, but it
is recommended that people who wish to encode fictional scripts use
these codes, in the interest of interoperability.  For Klingon, CSUR
has adopted the Linux encoding.  The CSUR people are driving adding
Tengwar and Cirth into Unicode Plane 1; the addition of Klingon to
Unicode Plane 1 has been rejected and so the above encoding remains
official.

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
If you send me mail in HTML format I will assume it's spam.
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
