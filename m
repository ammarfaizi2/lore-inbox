Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261522AbVARAOc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261522AbVARAOc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 19:14:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261532AbVARAOc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 19:14:32 -0500
Received: from terminus.zytor.com ([209.128.68.124]:26080 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261522AbVARAN2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 19:13:28 -0500
Message-ID: <41EC5391.5070607@zytor.com>
Date: Mon, 17 Jan 2005 16:08:49 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: aeb@cwi.nl, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Use official Unicodes for DEC VT characters
Content-Type: multipart/mixed;
 boundary="------------080203060902000006040608"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080203060902000006040608
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The use of U+F800 to U+F804 has been deprecated since 2003; this makes 
the deprecation effective by replacing these characters with the 
officially assigned U+23BA to U+23BD.

It also updates unicode.txt to match the latest version from the LANANA 
webpage.

	-hpa

--------------080203060902000006040608
Content-Type: text/x-patch;
 name="new-unicodes.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="new-unicodes.patch"

Index: official-unicodes/Documentation/unicode.txt
===================================================================
RCS file: /home/hpa/kernel/bkcvs/linux-2.5/Documentation/unicode.txt,v
retrieving revision 1.2
diff -u -r1.2 unicode.txt
--- official-unicodes/Documentation/unicode.txt	5 Feb 2002 17:40:40 -0000	1.2
+++ official-unicodes/Documentation/unicode.txt	18 Jan 2005 00:08:13 -0000
@@ -1,3 +1,13 @@
+		 Last update: 2005-01-17, version 1.4
+
+This file is maintained by H. Peter Anvin <unicode@lanana.org> as part
+of the Linux Assigned Names And Numbers Authority (LANANA) project.
+The current version can be found at:
+
+	    http://www.lanana.org/docs/unicode/unicode.txt
+
+		       ------------------------
+
 The Linux kernel code has been rewritten to use Unicode to map
 characters to fonts.  By downloading a single Unicode-to-font table,
 both the eight-bit character sets and UTF-8 mode are changed to use
@@ -18,6 +28,10 @@
 permits for example the use of block graphics even with a Latin-1 font
 loaded.
 
+Note that although these codes are similar to ISO 2022, neither the
+codes nor their uses match ISO 2022; Linux has two 8-bit codes (G0 and
+G1), whereas ISO 2022 has four 7-bit codes (G0-G3).
+
 In accordance with the Unicode standard/ISO 10646 the range U+F000 to
 U+F8FF has been reserved for OS-wide allocation (the Unicode Standard
 refers to this as a "Corporate Zone", since this is inaccurate for
@@ -26,18 +40,20 @@
 two (in case 1024- or 2048-character fonts ever become necessary).
 This leaves U+E000 to U+EFFF as End User Zone.
 
-The Unicodes in the range U+F000 to U+F1FF have been hard-coded to map
-directly to the loaded font, bypassing the translation table.  The
-user-defined map now defaults to U+F000 to U+F1FF, emulating the
-previous behaviour.  This range may expand in the future should it be
-warranted.
+[v1.2]: The Unicodes range from U+F000 and up to U+F7FF have been
+hard-coded to map directly to the loaded font, bypassing the
+translation table.  The user-defined map now defaults to U+F000 to
+U+F0FF, emulating the previous behaviour.  In practice, this range
+might be shorter; for example, vgacon can only handle 256-character
+(U+F000..U+F0FF) or 512-character (U+F000..U+F1FF) fonts.
+
 
 Actual characters assigned in the Linux Zone
 --------------------------------------------
 
-In addition, the following characters not present in Unicode 1.1.4 (at
-least, I have not found them!) have been defined; these are used by
-the DEC VT graphics map:
+In addition, the following characters not present in Unicode 1.1.4
+have been defined; these are used by the DEC VT graphics map.  [v1.2]
+THIS USE IS OBSOLETE AND SHOULD NO LONGER BE USED; PLEASE SEE BELOW.
 
 U+F800 DEC VT GRAPHICS HORIZONTAL LINE SCAN 1
 U+F801 DEC VT GRAPHICS HORIZONTAL LINE SCAN 3
@@ -48,31 +64,30 @@
 a smooth progression in the DEC VT graphics character set.  I have
 omitted the scan 5 line, since it is also used as a block-graphics
 character, and hence has been coded as U+2500 FORMS LIGHT HORIZONTAL.
-However, I left U+F802 blank should the need arise.  
+
+[v1.3]: These characters have been officially added to Unicode 3.2.0;
+they are added at U+23BA, U+23BB, U+23BC, U+23BD.  Linux now uses the
+new values.
+
+[v1.2]: The following characters have been added to represent common
+keyboard symbols that are unlikely to ever be added to Unicode proper
+since they are horribly vendor-specific.  This, of course, is an
+excellent example of horrible design.
+
+U+F810 KEYBOARD SYMBOL FLYING FLAG
+U+F811 KEYBOARD SYMBOL PULLDOWN MENU
+U+F812 KEYBOARD SYMBOL OPEN APPLE
+U+F813 KEYBOARD SYMBOL SOLID APPLE
 
 Klingon language support
 ------------------------
 
-Unfortunately, Unicode/ISO 10646 does not allocate code points for the
-language Klingon, probably fearing the potential code point explosion
-if many fictional languages were submitted for inclusion.  There are
-also political reasons (the Japanese, for example, are not too happy
-about the whole 16-bit concept to begin with.)  However, with Linux
-being a hacker-driven OS it seems this is a brilliant linguistic hack
-worth supporting.  Hence I have chosen to add it to the list in the
-Linux Zone.
-
-Several glyph forms for the Klingon alphabet have been proposed.
-However, since the set of symbols appear to be consistent throughout,
-with only the actual shapes being different, in keeping with standard
-Unicode practice these differences are considered font variants.
-
-Klingon has an alphabet of 26 characters, a positional numeric writing
-system with 10 digits, and is written left-to-right, top-to-bottom.
-Punctuation appears to be only used in Latin transliteration; it
-appears customary to write each sentence on its own line, and
-centered.  Space has been reserved for punctuation should it prove
-necessary.
+In 1996, Linux was the first operating system in the world to add
+support for the artificial language Klingon, created by Marc Okrand
+for the "Star Trek" television series.	This encoding was later
+adopted by the ConScript Unicode Registry and proposed (but ultimately
+rejected) for inclusion in Unicode Plane 1.  Thus, it remains as a
+Linux/CSUR private assignment in the Linux Zone.
 
 This encoding has been endorsed by the Klingon Language Institute.
 For more information, contact them at:
@@ -84,6 +99,19 @@
 located it at the end, on a 16-cell boundary in keeping with standard
 Unicode practice.
 
+NOTE: This range is now officially managed by the ConScript Unicode
+Registry.  The normative reference is at:
+
+	http://www.evertype.com/standards/csur/klingon.html
+
+Klingon has an alphabet of 26 characters, a positional numeric writing
+system with 10 digits, and is written left-to-right, top-to-bottom.
+
+Several glyph forms for the Klingon alphabet have been proposed.
+However, since the set of symbols appear to be consistent throughout,
+with only the actual shapes being different, in keeping with standard
+Unicode practice these differences are considered font variants.
+
 U+F8D0	KLINGON LETTER A
 U+F8D1	KLINGON LETTER B
 U+F8D2	KLINGON LETTER CH
@@ -124,16 +152,24 @@
 U+F8F8	KLINGON DIGIT EIGHT
 U+F8F9	KLINGON DIGIT NINE
 
+U+F8FD	KLINGON COMMA
+U+F8FE	KLINGON FULL STOP
+U+F8FF	KLINGON SYMBOL FOR EMPIRE
+
 Other Fictional and Artificial Scripts
 --------------------------------------
 
 Since the assignment of the Klingon Linux Unicode block, a registry of
-fictional and artificial scripts has been established by John Cowan,
-<cowan@ccil.org>.  The ConScript Unicode Registry is accessible at
-http://locke.ccil.org/~cowan/csur/; the ranges used fall at the bottom
-of the End User Zone and can hence not be normatively assigned, but it
-is recommended that people who wish to encode fictional scripts use
-these codes, in the interest of interoperability.  For Klingon, CSUR
-has adopted the Linux encoding.
-
-	H. Peter Anvin <hpa@zytor.com>
+fictional and artificial scripts has been established by John Cowan
+<jcowan@reutershealth.com> and Michael Everson <everson@evertype.com>.
+The ConScript Unicode Registry is accessible at:
+
+	  http://www.evertype.com/standards/csur/
+
+The ranges used fall at the low end of the End User Zone and can hence
+not be normatively assigned, but it is recommended that people who
+wish to encode fictional scripts use these codes, in the interest of
+interoperability.  For Klingon, CSUR has adopted the Linux encoding.
+The CSUR people are driving adding Tengwar and Cirth into Unicode
+Plane 1; the addition of Klingon to Unicode Plane 1 has been rejected
+and so the above encoding remains official.
Index: official-unicodes/drivers/char/consolemap.c
===================================================================
RCS file: /home/hpa/kernel/bkcvs/linux-2.5/drivers/char/consolemap.c,v
retrieving revision 1.6
diff -u -r1.6 consolemap.c
--- official-unicodes/drivers/char/consolemap.c	31 May 2004 03:09:10 -0000	1.6
+++ official-unicodes/drivers/char/consolemap.c	17 Jan 2005 23:38:31 -0000
@@ -74,8 +74,8 @@
     0x0050, 0x0051, 0x0052, 0x0053, 0x0054, 0x0055, 0x0056, 0x0057,
     0x0058, 0x0059, 0x005a, 0x005b, 0x005c, 0x005d, 0x005e, 0x00a0,
     0x25c6, 0x2592, 0x2409, 0x240c, 0x240d, 0x240a, 0x00b0, 0x00b1,
-    0x2591, 0x240b, 0x2518, 0x2510, 0x250c, 0x2514, 0x253c, 0xf800,
-    0xf801, 0x2500, 0xf803, 0xf804, 0x251c, 0x2524, 0x2534, 0x252c,
+    0x2591, 0x240b, 0x2518, 0x2510, 0x250c, 0x2514, 0x253c, 0x23ba,
+    0x23bb, 0x2500, 0x23bc, 0x23bd, 0x251c, 0x2524, 0x2534, 0x252c,
     0x2502, 0x2264, 0x2265, 0x03c0, 0x2260, 0x00a3, 0x00b7, 0x007f,
     0x0080, 0x0081, 0x0082, 0x0083, 0x0084, 0x0085, 0x0086, 0x0087,
     0x0088, 0x0089, 0x008a, 0x008b, 0x008c, 0x008d, 0x008e, 0x008f,
Index: official-unicodes/drivers/char/cp437.uni
===================================================================
RCS file: /home/hpa/kernel/bkcvs/linux-2.5/drivers/char/cp437.uni,v
retrieving revision 1.2
diff -u -r1.2 cp437.uni
--- official-unicodes/drivers/char/cp437.uni	5 Feb 2002 17:40:40 -0000	1.2
+++ official-unicodes/drivers/char/cp437.uni	17 Jan 2005 23:38:54 -0000
@@ -111,7 +111,7 @@
 0x5c	U+005c
 0x5d	U+005d
 0x5e	U+005e
-0x5f	U+005f U+f804
+0x5f	U+005f U+23bd U+f804
 0x60	U+0060
 0x61	U+0061 U+00e3
 0x62	U+0062

--------------080203060902000006040608--
